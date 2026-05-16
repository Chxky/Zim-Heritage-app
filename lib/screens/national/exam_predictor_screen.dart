import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/exam_prediction.dart';
import '../../services/prediction_service.dart';
import '../../widgets/glass_card.dart';

class ExamPredictorScreen extends StatefulWidget {
  final String gradeLevel;
  const ExamPredictorScreen({super.key, required this.gradeLevel});
  @override
  State<ExamPredictorScreen> createState() => _ExamPredictorScreenState();
}

class _ExamPredictorScreenState extends State<ExamPredictorScreen> {
  final _history = <HistoricalTrend>[];
  final _topicScores = <String, double>{};
  PredictionResult? _result;
  StudyPlan? _plan;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _generateSampleData();
  }

  void _generateSampleData() {
    _history.addAll([
      const HistoricalTrend(year: '2024', term: 'Term 1', score: 58.0, subject: 'Mathematics'),
      const HistoricalTrend(year: '2024', term: 'Term 2', score: 65.0, subject: 'Mathematics'),
      const HistoricalTrend(year: '2024', term: 'Term 3', score: 71.0, subject: 'Mathematics'),
    ]);
    _topicScores.addAll({
      'Algebra': 62.0, 'Geometry': 45.0, 'Trigonometry': 38.0,
      'Statistics': 78.0, 'Calculus': 55.0,
    });
  }

  void _runPrediction() {
    setState(() => _loading = true);
    Future.delayed(const Duration(milliseconds: 800), () {
      final result = PredictionService.predict(
        subjectId: 'g7_mat',
        subjectName: 'Mathematics',
        currentAverage: 71.0,
        history: _history,
        topicScores: _topicScores,
      );
      final plan = PredictionService.generateStudyPlan(
        examDate: '2025-11-15',
        predictions: [result],
      );
      setState(() { _result = result; _plan = plan; _loading = false; });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ZIMSEC Exam Predictor'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF5C6BC0)],
              begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroCard(),
            const SizedBox(height: 16),
            if (_loading) const Center(
              child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator(color: AppTheme.gold)),
            ),
            if (_result != null) ...[
              _buildPredictionResult(),
              const SizedBox(height: 16),
              _buildWeakAreas(),
              const SizedBox(height: 16),
              _buildRecommendations(),
              const SizedBox(height: 16),
              if (_plan != null) _buildStudyPlan(),
            ],
            if (_result == null && !_loading) ...[
              _buildTopicScores(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 52,
                child: ElevatedButton.icon(
                  onPressed: _runPrediction,
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Generate Prediction'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5C6BC0),
                    foregroundColor: AppTheme.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: const Color(0xFF5C6BC0).withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF5C6BC0).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.psychology, color: Color(0xFF5C6BC0), size: 32),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI Exam Grade Predictor',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    Text('Predict your ZIMSEC grade with AI-powered analysis',
                      style: TextStyle(fontSize: 12, color: AppTheme.white60)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.school, size: 14, color: AppTheme.gold),
                const SizedBox(width: 6),
                Text(widget.gradeLevel,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.gold)),
                const Spacer(),
                const Icon(Icons.date_range, size: 14, color: AppTheme.white50),
                const SizedBox(width: 6),
                const Text('Exam: Nov 2025',
                  style: TextStyle(fontSize: 12, color: AppTheme.white50)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopicScores() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: Colors.lightBlue.withValues(alpha: 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.assignment, color: AppTheme.gold, size: 18),
              SizedBox(width: 8),
              Text('Your Topic Scores', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ],
          ),
          const SizedBox(height: 12),
          ..._topicScores.entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(e.key, style: const TextStyle(fontSize: 13, color: AppTheme.white80)),
                    const Spacer(),
                    Text('${e.value.toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                        color: e.value >= 70 ? AppTheme.greenBright : e.value >= 50 ? Colors.orange : Colors.red)),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: e.value / 100,
                    backgroundColor: AppTheme.white10,
                    valueColor: AlwaysStoppedAnimation(
                      e.value >= 70 ? AppTheme.greenBright : e.value >= 50 ? Colors.orange : Colors.red),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildPredictionResult() {
    final result = _result!;
    Color gradeColor;
    if (result.predictedSymbol == 'A' || result.predictedSymbol == 'B') {
      gradeColor = AppTheme.greenBright;
    } else if (result.predictedSymbol == 'C') {
      gradeColor = Colors.orange;
    } else {
      gradeColor = Colors.red;
    }

    Color riskColor;
    String riskText;
    switch (result.riskLevel) {
      case 'low': riskColor = AppTheme.greenBright; riskText = 'Low Risk'; break;
      case 'medium': riskColor = Colors.orange; riskText = 'Medium Risk'; break;
      default: riskColor = Colors.red; riskText = 'High Risk';
    }

    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: gradeColor.withValues(alpha: 0.3),
      boxShadow: [BoxShadow(color: gradeColor.withValues(alpha: 0.12), blurRadius: 24, offset: const Offset(0, 4))],
      child: Column(
        children: [
          const Text('Predicted ZIMSEC Grade',
            style: TextStyle(fontSize: 14, color: AppTheme.white60)),
          const SizedBox(height: 8),
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: gradeColor.withValues(alpha: 0.15),
              border: Border.all(color: gradeColor.withValues(alpha: 0.3), width: 3),
            ),
            child: Center(
              child: Text(result.predictedSymbol,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: gradeColor)),
            ),
          ),
          const SizedBox(height: 8),
          Text('${result.predictedGrade.toStringAsFixed(1)}%',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: gradeColor)),
          const SizedBox(height: 4),
          Text('Current Average: ${result.currentAverage.toStringAsFixed(0)}%',
            style: const TextStyle(fontSize: 12, color: AppTheme.white50)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: riskColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shield, size: 14, color: riskColor),
                const SizedBox(width: 4),
                Text(riskText, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: riskColor)),
                const SizedBox(width: 4),
                Text('• ${result.confidence.toStringAsFixed(0)}% confidence',
                  style: TextStyle(fontSize: 11, color: riskColor.withValues(alpha: 0.7))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeakAreas() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: Colors.orange.withValues(alpha: 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber, color: Colors.orange, size: 18),
              SizedBox(width: 8),
              Text('Weak Areas Identified',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ],
          ),
          const SizedBox(height: 12),
          ..._result!.weakAreas.map((w) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: w.severity == 'critical' ? Colors.red.withValues(alpha: 0.15) :
                           w.severity == 'weak' ? Colors.orange.withValues(alpha: 0.15) :
                           AppTheme.gold.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    w.severity == 'critical' ? Icons.dangerous : Icons.error_outline,
                    size: 16,
                    color: w.severity == 'critical' ? Colors.red :
                           w.severity == 'weak' ? Colors.orange : AppTheme.gold,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(w.topic, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.white)),
                      Text('Score: ${w.score.toStringAsFixed(0)}% - ${w.severity.toUpperCase()}',
                        style: TextStyle(fontSize: 11, color: w.severity == 'critical' ? Colors.red : Colors.orange)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildRecommendations() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: AppTheme.greenBright.withValues(alpha: 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: AppTheme.gold, size: 18),
              SizedBox(width: 8),
              Text('Personalised Study Plan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ],
          ),
          const SizedBox(height: 12),
          ..._result!.recommendations.map((r) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24, height: 24,
                  decoration: BoxDecoration(
                    color: AppTheme.greenBright.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('${r.priority}',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.greenBright)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.white)),
                      Text(r.description,
                        style: const TextStyle(fontSize: 11, color: AppTheme.white60, height: 1.3)),
                      const SizedBox(height: 2),
                      Text('~${r.estimatedHours} hours recommended',
                        style: TextStyle(fontSize: 10, color: AppTheme.greenBright, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildStudyPlan() {
    final p = _plan!;
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: Colors.cyan.withValues(alpha: 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.cyan, size: 18),
              const SizedBox(width: 8),
              Text('Study Schedule (${p.totalHours}h total)',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ],
          ),
          const SizedBox(height: 12),
          ...p.sessions.map((s) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassCard(
              padding: const EdgeInsets.all(10),
              borderColor: Colors.cyan.withValues(alpha: 0.1),
              child: Row(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: Colors.cyan.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.schedule, color: Colors.cyan, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.activity,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.white)),
                        Text('${s.durationMinutes} minutes',
                          style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
