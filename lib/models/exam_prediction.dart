class PredictionResult {
  final String subjectId;
  final String subjectName;
  final double predictedGrade;
  final String predictedSymbol;
  final double confidence;
  final double currentAverage;
  final List<WeakArea> weakAreas;
  final List<StudyRecommendation> recommendations;
  final String riskLevel;

  const PredictionResult({
    required this.subjectId, required this.subjectName, required this.predictedGrade,
    required this.predictedSymbol, required this.confidence, required this.currentAverage,
    required this.weakAreas, required this.recommendations, required this.riskLevel,
  });
}

class WeakArea {
  final String topic;
  final double score;
  final String severity;

  const WeakArea({required this.topic, required this.score, required this.severity});
}

class StudyRecommendation {
  final String title;
  final String description;
  final int priority;
  final int estimatedHours;

  const StudyRecommendation({required this.title, required this.description, required this.priority, required this.estimatedHours});
}

class StudyPlan {
  final DateTime startDate;
  final DateTime examDate;
  final List<StudySession> sessions;
  final int totalHours;

  const StudyPlan({required this.startDate, required this.examDate, required this.sessions, required this.totalHours});
}

class StudySession {
  final String subjectId;
  final String topic;
  final int durationMinutes;
  final String activity;
  final bool completed;

  const StudySession({required this.subjectId, required this.topic, required this.durationMinutes, required this.activity, this.completed = false});
}

class HistoricalTrend {
  final String year;
  final String term;
  final double score;
  final String subject;

  const HistoricalTrend({required this.year, required this.term, required this.score, required this.subject});
}
