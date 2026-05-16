import '../models/exam_prediction.dart';

class PredictionService {
  static const _subjectWeights = {
    'english': 1.2, 'mathematics': 1.2, 'science': 1.0,
    'heritage': 1.0, 'shona': 0.9, 'agriculture': 0.9,
    'vpa': 0.8, 'frm': 0.8, 'ict': 1.1,
  };

  static String gradeToSymbol(double grade) {
    if (grade >= 80) return 'A';
    if (grade >= 70) return 'B';
    if (grade >= 60) return 'C';
    if (grade >= 50) return 'D';
    if (grade >= 40) return 'E';
    return 'U';
  }

  static String getRiskLevel(double predicted, double confidence) {
    final riskScore = (100 - predicted) * (1 - confidence / 100);
    if (riskScore < 15) return 'low';
    if (riskScore < 30) return 'medium';
    return 'high';
  }

  static PredictionResult predict({
    required String subjectId,
    required String subjectName,
    required double currentAverage,
    required List<HistoricalTrend> history,
    required Map<String, double> topicScores,
  }) {
    final weight = _subjectWeights.entries
        .firstWhere((e) => subjectId.contains(e.key), orElse: () => const MapEntry('', 1.0))
        .value;

    double trendFactor = 0;
    if (history.length >= 2) {
      final recent = history.sublist(history.length - 3);
      final improvements = <double>[];
      for (int i = 1; i < recent.length; i++) {
        improvements.add(recent[i].score - recent[i - 1].score);
      }
      trendFactor = improvements.isEmpty ? 0 : improvements.reduce((a, b) => a + b) / improvements.length;
    }

    final predictedGrade = (currentAverage * 0.6 + trendFactor * 0.2) * weight + 5;
    final clamped = predictedGrade.clamp(0.0, 100.0);

    final confidence = history.isNotEmpty
        ? (60 + history.length * 5 - topicScores.values.where((s) => s < 50).length * 5).clamp(20, 95).toDouble()
        : 40.0;

    final weakAreas = topicScores.entries
        .where((e) => e.value < 65)
        .map((e) => WeakArea(
              topic: e.key,
              score: e.value,
              severity: e.value < 40 ? 'critical' : e.value < 55 ? 'weak' : 'developing',
            ))
        .toList()
      ..sort((a, b) => a.score.compareTo(b.score));

    final recommendations = _generateRecommendations(weakAreas, clamped);

    return PredictionResult(
      subjectId: subjectId,
      subjectName: subjectName,
      predictedGrade: clamped,
      predictedSymbol: gradeToSymbol(clamped),
      confidence: confidence,
      currentAverage: currentAverage,
      weakAreas: weakAreas,
      recommendations: recommendations,
      riskLevel: getRiskLevel(clamped, confidence),
    );
  }

  static List<StudyRecommendation> _generateRecommendations(List<WeakArea> weakAreas, double predicted) {
    final recs = <StudyRecommendation>[];
    var priority = 1;

    for (final weak in weakAreas.where((w) => w.severity == 'critical').take(3)) {
      recs.add(StudyRecommendation(
        title: 'Focus on ${weak.topic}',
        description: 'Spend 2 hours daily on ${weak.topic} until you reach 60% mastery. Use practice questions and past papers.',
        priority: priority++, estimatedHours: 10,
      ));
    }

    for (final weak in weakAreas.where((w) => w.severity == 'weak').take(3)) {
      recs.add(StudyRecommendation(
        title: 'Review ${weak.topic}',
        description: 'Allocate 1 hour daily to strengthen ${weak.topic}. Focus on problem areas and seek teacher help.',
        priority: priority++, estimatedHours: 6,
      ));
    }

    if (predicted < 40) {
      recs.add(StudyRecommendation(
        title: 'Foundational Concepts',
        description: 'Start with basic concepts. Work through simplified exercises and build up to exam-level questions.',
        priority: priority++, estimatedHours: 15,
      ));
    }

    recs.add(StudyRecommendation(
      title: 'Past Paper Practice',
      description: 'Complete at least 5 past exam papers under timed conditions to build speed and exam technique.',
      priority: priority, estimatedHours: 8,
    ));

    return recs;
  }

  static StudyPlan generateStudyPlan({
    required String examDate,
    required List<PredictionResult> predictions,
  }) {
    final startDate = DateTime.now();
    final exam = DateTime.parse(examDate);

    final sessions = <StudySession>[];
    var hourCounter = 0;

    for (final pred in predictions) {
      for (final weak in pred.weakAreas.take(3)) {
        final hours = weak.severity == 'critical' ? 2 : 1;
        sessions.add(StudySession(
          subjectId: pred.subjectId,
          topic: weak.topic,
          durationMinutes: hours * 60,
          activity: 'Focused study & practice: ${weak.topic}',
        ));
        hourCounter += hours;
      }

      sessions.add(StudySession(
        subjectId: pred.subjectId,
        topic: 'Past Paper Revision',
        durationMinutes: 120,
        activity: 'Complete 1 past paper for ${pred.subjectName}',
      ));
      hourCounter += 2;
    }

    return StudyPlan(startDate: startDate, examDate: exam, sessions: sessions, totalHours: hourCounter);
  }
}
