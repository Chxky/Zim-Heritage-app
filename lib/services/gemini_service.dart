import 'package:google_generative_ai/google_generative_ai.dart';
import 'env_config.dart';

/// Gemini AI Service for EduBridge Zimbabwe Heritage App.
/// Uses gemini-2.0-flash with a Zimbabwe Heritage curriculum context.
/// Falls back to templated responses if the API key is not configured.
class GeminiService {
  static String get _apiKey => EnvConfig.geminiApiKey;

  static GenerativeModel? _model;

  static bool get _isConfigured =>
      _apiKey.isNotEmpty && _apiKey != 'your_gemini_api_key_here';

  static GenerativeModel get _getModel {
    _model ??= GenerativeModel(
      model: 'gemini-2.0-flash',
      apiKey: _apiKey,
      systemInstruction: Content.system(
        '''You are ZimHeritage AI — an expert educational assistant specialised in the 
Zimbabwe Heritage-Based Curriculum (ZIMSEC). Your purpose is to empower students, 
teachers, and parents across all 15 grade levels: ECD A, ECD B, Grades 1–7, Forms 1–6.

CORE PRINCIPLES:
- Guide learners to DISCOVER answers through questions, never just give them.
- Ground every example in Zimbabwean context (Great Zimbabwe, agriculture, local culture, Shona/Ndebele).
- Adapt language and complexity to the grade level.
- Celebrate effort and resilience — every learner can succeed.
- Connect concepts to Ubuntu philosophy and community values.
- Be warm, encouraging, and precise.

GRADE ADAPTATIONS:
- ECD: Simple, visual, hands-on. Use songs, colours, counting objects.
- Primary (Grades 1–7): Step-by-step, real-world Zimbabwe examples.
- Secondary (Forms 1–6): Critical thinking, analytical depth, exam preparation.

Always respond in clear, structured text. Use **bold** for key terms, numbered lists for steps, and - bullets for options. Keep responses focused and practical.''',
      ),
    );
    return _model!;
  }

  /// Send a message for a student AI tutor session.
  static Future<String> askTutor({
    required String userMessage,
    required String gradeLevel,
    String? subject,
    String? difficulty,
    List<({String role, String text})> history = const [],
  }) async {
    if (!_isConfigured) {
      return _fallbackTutorResponse(userMessage, gradeLevel, subject, difficulty);
    }

    try {
      final chat = _getModel.startChat(
        history: history
            .map((m) => Content(m.role, [TextPart(m.text)]))
            .toList(),
      );

      final context = StringBuffer();
      context.write('Grade: $gradeLevel. ');
      if (subject != null) context.write('Subject: $subject. ');
      if (difficulty != null) context.write('Difficulty: $difficulty. ');
      context.write('\n\nStudent question: $userMessage');

      final response = await chat.sendMessage(Content.text(context.toString()));
      return response.text ?? _fallbackTutorResponse(userMessage, gradeLevel, subject, difficulty);
    } catch (e) {
      return _fallbackTutorResponse(userMessage, gradeLevel, subject, difficulty);
    }
  }

  /// Send a message for a teacher AI assistant session.
  static Future<String> askTeacherAssistant({
    required String userMessage,
    String? subject,
    String? grade,
    String? difficulty,
    List<({String role, String text})> history = const [],
  }) async {
    if (!_isConfigured) {
      return _fallbackTeacherResponse(userMessage, subject, grade, difficulty);
    }

    try {
      final chat = _getModel.startChat(
        history: history
            .map((m) => Content(m.role, [TextPart(m.text)]))
            .toList(),
      );

      final context = StringBuffer();
      context.write('You are assisting a TEACHER (not a student). ');
      if (grade != null) context.write('Grade: $grade. ');
      if (subject != null) context.write('Subject: $subject. ');
      if (difficulty != null) context.write('Difficulty level: $difficulty. ');
      context.write('\n\nTeacher request: $userMessage');

      final response = await chat.sendMessage(Content.text(context.toString()));
      return response.text ?? _fallbackTeacherResponse(userMessage, subject, grade, difficulty);
    } catch (e) {
      return _fallbackTeacherResponse(userMessage, subject, grade, difficulty);
    }
  }

  /// Auto-grade a student's short-answer homework response.
  static Future<({int score, int maxScore, String feedback})> gradeAnswer({
    required String question,
    required String studentAnswer,
    required String correctAnswer,
    required int maxMarks,
    required String gradeLevel,
  }) async {
    if (!_isConfigured || studentAnswer.trim().isEmpty) {
      return _fallbackGrade(studentAnswer, correctAnswer, maxMarks);
    }

    try {
      final prompt = '''
You are an experienced Zimbabwe ZIMSEC examiner marking a student's homework.

Grade Level: $gradeLevel
Question: $question
Model Answer: $correctAnswer
Student's Answer: $studentAnswer
Maximum Marks: $maxMarks

MARKING TASK:
1. Award marks fairly (0 to $maxMarks) based on accuracy and completeness.
2. Write 1-2 sentences of specific, encouraging feedback.
3. Respond ONLY in this exact format:
SCORE: [number]
FEEDBACK: [your feedback here]''';

      final response = await _getModel.generateContent([Content.text(prompt)]);
      final text = response.text ?? '';

      final scoreMatch = RegExp(r'SCORE:\s*(\d+)').firstMatch(text);
      final feedbackMatch = RegExp(r'FEEDBACK:\s*(.+)', dotAll: true).firstMatch(text);

      final score = int.tryParse(scoreMatch?.group(1) ?? '0') ?? 0;
      final feedback = feedbackMatch?.group(1)?.trim() ?? 'Good attempt! Keep practising.';

      return (score: score.clamp(0, maxMarks), maxScore: maxMarks, feedback: feedback);
    } catch (e) {
      return _fallbackGrade(studentAnswer, correctAnswer, maxMarks);
    }
  }

  // ─── FALLBACK RESPONSES ────────────────────────────────────────────────────

  static String _fallbackTutorResponse(
      String query, String grade, String? subject, String? difficulty) {
    final q = query.toLowerCase();
    if (q.contains('explain') || q.contains('what is') || q.contains('how')) {
      return '**Understanding ${subject ?? 'this topic'} — $grade**\n\n'
          'Great question! Let\'s explore this together.\n\n'
          '**Think About It:**\n'
          '- What do you already know about this?\n'
          '- Can you connect it to something in your daily life in Zimbabwe?\n'
          '- Try explaining it in your own words first.\n\n'
          '**Hint:** Break the concept into smaller parts. '
          'What is the first thing you understand? Start there!\n\n'
          '_Tip: Configure your Gemini API key in gemini_service.dart for full AI responses._';
    } else if (q.contains('practice') || q.contains('question') || q.contains('exercise')) {
      return '**Practice Time — ${subject ?? 'General'} ($grade)**\n\n'
          'Here\'s a challenge for you:\n\n'
          'Q: Think of a real-world example from Zimbabwe that connects to what you\'re studying. '
          'Describe it in 3-4 sentences and explain how it relates to the concept.\n\n'
          '_This kind of heritage-based thinking is exactly what ZIMSEC examiners love to see!_';
    } else {
      return '**I\'m here to help you learn!**\n\n'
          'You can ask me to:\n'
          '- **Explain** any concept in your curriculum\n'
          '- **Practice** with questions at your level\n'
          '- **Check** your answers and give feedback\n'
          '- **Help** when you\'re stuck\n\n'
          'What would you like to explore today?\n\n'
          '_Note: Add your Gemini API key in gemini_service.dart for full AI-powered responses._';
    }
  }

  static String _fallbackTeacherResponse(
      String query, String? subject, String? grade, String? difficulty) {
    final q = query.toLowerCase();
    if (q.contains('lesson')) {
      return '**Lesson Plan Structure — $grade ${subject ?? ''} **\n\n'
          '1. **Objectives** (5 min) — SMART goals aligned to ZIMSEC outcomes\n'
          '2. **Hook** (5–10 min) — Connect to Zimbabwean heritage or local context\n'
          '3. **Main Activity** (20–30 min) — Heritage-based hands-on learning\n'
          '4. **Assessment** (5–10 min) — Quick checks, peer assessment\n'
          '5. **Closure** (5 min) — Recap + homework assignment\n\n'
          '_Add your Gemini API key for fully personalised lesson plans._';
    }
    return '**Teaching Guidance**\n\n'
        'I can help you with:\n'
        '- Lesson plans and teaching strategies\n'
        '- Practice questions and assessments\n'
        '- Curriculum alignment and differentiation\n'
        '- Homework design\n\n'
        '_Configure Gemini API in gemini_service.dart for AI-powered responses._';
  }

  static ({int score, int maxScore, String feedback}) _fallbackGrade(
      String answer, String correct, int max) {
    if (answer.trim().isEmpty) {
      return (score: 0, maxScore: max, feedback: 'No answer provided. Please attempt the question!');
    }
    // Simple keyword overlap scoring
    final answerWords = answer.toLowerCase().split(RegExp(r'\s+'));
    final correctWords = correct.toLowerCase().split(RegExp(r'\s+'));
    final overlap = answerWords.where((w) => correctWords.contains(w) && w.length > 3).length;
    final ratio = (overlap / correctWords.length).clamp(0.0, 1.0);
    final score = (max * ratio).round();
    return (
      score: score,
      maxScore: max,
      feedback: score >= max * 0.7
          ? 'Well done! Your answer captures the key ideas.'
          : 'Good attempt! Review the key terms and try to be more specific.',
    );
  }
}
