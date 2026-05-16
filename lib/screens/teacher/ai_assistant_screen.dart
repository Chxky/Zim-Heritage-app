// screens/teacher/ai_assistant_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/user.dart';
import '../../services/gemini_service.dart';

class AIAssistantScreen extends StatefulWidget {
  final User user;

  const AIAssistantScreen({super.key, required this.user});

  @override
  State<AIAssistantScreen> createState() => _AIAssistantScreenState();
}

class _AIAssistantScreenState extends State<AIAssistantScreen> {
  final _messageController = TextEditingController();
  final _questionController = TextEditingController();
  final _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final List<({String role, String text})> _history = [];
  bool _isThinking = false;
  String? _selectedSubject;
  String? _selectedGrade;
  String? _selectedDifficulty;

  final List<String> _subjects = [
    'Mathematics', 'English', 'Shona/Ndebele', 'Science', 'History',
    'Geography', 'Agriculture', 'Biology', 'Chemistry', 'Physics',
    'Accounting', 'Economics', 'Computer Science', 'Heritage Studies',
  ];
  final List<String> _grades = [
    'ECD A', 'ECD B', 'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4',
    'Grade 5', 'Grade 6', 'Grade 7', 'Form 1', 'Form 2', 'Form 3',
    'Form 4', 'Form 5', 'Form 6',
  ];
  final List<String> _difficulties = ['Easy', 'Medium', 'Hard', 'Mixed'];

  final List<({String emoji, String prompt})> _quickActions = [
    (emoji: '📋', prompt: 'Create a complete lesson plan for my selected subject and grade'),
    (emoji: '❓', prompt: 'Generate 5 practice questions for my selected grade and subject'),
    (emoji: '📊', prompt: 'Suggest formative assessment strategies for this topic'),
    (emoji: '🌍', prompt: 'How can I connect this topic to Zimbabwe heritage and culture?'),
    (emoji: '🤝', prompt: 'Give me differentiation strategies for diverse learners'),
    (emoji: '📝', prompt: 'Design effective homework for this topic'),
  ];

  @override
  void initState() {
    super.initState();
    _messages.add(ChatMessage(
      text: 'Mhoro! 👋 I\'m your **ZimHeritage AI Teaching Assistant**, powered by Google Gemini.\n\n'
          'I\'m trained on the Zimbabwe Heritage-Based Curriculum and ZIMSEC standards.\n\n'
          '**I can help you:**\n'
          '- Create detailed lesson plans with heritage integration\n'
          '- Design practice questions at any difficulty\n'
          '- Develop assessment strategies and rubrics\n'
          '- Suggest differentiation for diverse learners\n'
          '- Give curriculum alignment guidance\n'
          '- Design meaningful homework\n\n'
          'Select your subject and grade above, then ask anything!',
      isUser: false,
    ));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _questionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(text: text.trim(), isUser: true));
      _isThinking = true;
    });
    _messageController.clear();
    _scrollToBottom();

    _history.add((role: 'user', text: text.trim()));

    final response = await GeminiService.askTeacherAssistant(
      userMessage: text.trim(),
      subject: _selectedSubject,
      grade: _selectedGrade,
      difficulty: _selectedDifficulty,
      history: List.from(_history)..removeLast(),
    );

    _history.add((role: 'model', text: response));

    if (!mounted) return;
    setState(() {
      _messages.add(ChatMessage(text: response, isUser: false));
      _isThinking = false;
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showQuestionDesigner() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          border: Border.all(color: AppTheme.white20),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_fix_high, color: AppTheme.gold),
                  const SizedBox(width: 8),
                  const Text('Question Designer',
                    style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: AppTheme.white60),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _selectedSubject,
                dropdownColor: AppTheme.surfaceDark,
                decoration: const InputDecoration(labelText: 'Subject'),
                style: const TextStyle(color: AppTheme.white),
                items: _subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (v) => setState(() => _selectedSubject = v),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedGrade,
                dropdownColor: AppTheme.surfaceDark,
                decoration: const InputDecoration(labelText: 'Grade Level'),
                style: const TextStyle(color: AppTheme.white),
                items: _grades.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                onChanged: (v) => setState(() => _selectedGrade = v),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _selectedDifficulty,
                dropdownColor: AppTheme.surfaceDark,
                decoration: const InputDecoration(labelText: 'Difficulty'),
                style: const TextStyle(color: AppTheme.white),
                items: _difficulties.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (v) => setState(() => _selectedDifficulty = v),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _questionController,
                maxLines: 3,
                style: const TextStyle(color: AppTheme.white),
                decoration: const InputDecoration(
                  labelText: 'Topic or concept',
                  hintText: 'e.g. Photosynthesis, Fractions, Great Zimbabwe...',
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    final topic = _questionController.text.trim();
                    if (topic.isNotEmpty) {
                      _sendMessage(
                        'Generate 5 well-structured practice questions about "$topic" '
                        'for ${_selectedGrade ?? "the selected grade"} '
                        '${_selectedSubject ?? "students"} at '
                        '${_selectedDifficulty ?? "mixed"} difficulty. '
                        'Include marking allocations and model answers.',
                      );
                      _questionController.clear();
                    }
                  },
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Generate Questions'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.gold,
                    foregroundColor: AppTheme.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.auto_awesome, color: AppTheme.gold, size: 24),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('AI Teaching Assistant',
                          style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Powered by Gemini AI • ZIMSEC Curriculum Expert',
                          style: TextStyle(color: AppTheme.white70, fontSize: 11)),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
                      ),
                      child: const Icon(Icons.tune, color: AppTheme.gold, size: 18),
                    ),
                    onPressed: _showQuestionDesigner,
                    tooltip: 'Question Designer',
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedGrade,
                          hint: const Text('Grade', style: TextStyle(color: AppTheme.white50, fontSize: 11)),
                          dropdownColor: AppTheme.surfaceDark,
                          style: const TextStyle(color: AppTheme.white, fontSize: 12),
                          items: _grades.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
                          onChanged: (v) => setState(() => _selectedGrade = v),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.white.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedSubject,
                          hint: const Text('Subject', style: TextStyle(color: AppTheme.white50, fontSize: 11)),
                          dropdownColor: AppTheme.surfaceDark,
                          style: const TextStyle(color: AppTheme.white, fontSize: 12),
                          items: _subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                          onChanged: (v) => setState(() => _selectedSubject = v),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Messages
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length + (_isThinking ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length && _isThinking) return _buildThinkingIndicator();
              return _buildMessageBubble(_messages[index]);
            },
          ),
        ),

        // Quick action chips
        if (!_isThinking && _messages.length <= 2)
          Container(
            color: AppTheme.surfaceDark,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Quick Actions:',
                  style: TextStyle(color: AppTheme.white50, fontSize: 11, fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8, runSpacing: 6,
                  children: _quickActions.map((a) => GestureDetector(
                    onTap: () => _sendMessage(a.prompt),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.gold.withValues(alpha: 0.25)),
                      ),
                      child: Text('${a.emoji} ${a.prompt.split(' ').take(4).join(' ')}...',
                        style: const TextStyle(color: AppTheme.white70, fontSize: 11)),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),

        // Input bar
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            boxShadow: [BoxShadow(color: AppTheme.gold.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, -2))],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  style: const TextStyle(color: AppTheme.white),
                  decoration: InputDecoration(
                    hintText: 'Ask for teaching guidance...',
                    hintStyle: const TextStyle(color: AppTheme.white30),
                    filled: true,
                    fillColor: AppTheme.surfaceMid,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  textInputAction: TextInputAction.send,
                  onSubmitted: _sendMessage,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [AppTheme.primaryGreen, AppTheme.greenBright]),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.send, color: AppTheme.white, size: 20),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
        decoration: BoxDecoration(
          color: message.isUser ? AppTheme.primaryGreen : AppTheme.surfaceMid,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: message.isUser ? const Radius.circular(4) : null,
            bottomLeft: !message.isUser ? const Radius.circular(4) : null,
          ),
          boxShadow: AppTheme.cardGlow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser)
              Row(
                children: [
                  const Icon(Icons.auto_awesome, size: 14, color: AppTheme.gold),
                  const SizedBox(width: 4),
                  const Text('ZimHeritage AI',
                    style: TextStyle(color: AppTheme.gold, fontSize: 11, fontWeight: FontWeight.bold)),
                ],
              ),
            if (!message.isUser) const SizedBox(height: 6),
            _buildMessageContent(message.text, message.isUser),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageContent(String text, bool isUser) {
    final lines = text.split('\n');
    final widgets = <Widget>[];
    for (final line in lines) {
      if (line.startsWith('**') && line.endsWith('**')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 6, bottom: 4),
          child: Text(line.replaceAll('**', ''),
            style: TextStyle(fontWeight: FontWeight.bold,
              color: isUser ? AppTheme.white : AppTheme.gold, fontSize: 14)),
        ));
      } else if (line.startsWith('_') && line.endsWith('_')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(line.replaceAll('_', ''),
            style: TextStyle(fontStyle: FontStyle.italic,
              color: isUser ? AppTheme.white70 : AppTheme.white50, fontSize: 12)),
        ));
      } else {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(line, style: TextStyle(color: isUser ? AppTheme.white : AppTheme.white, fontSize: 13)),
        ));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: widgets);
  }

  Widget _buildThinkingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceMid,
          borderRadius: BorderRadius.circular(16).copyWith(bottomLeft: const Radius.circular(4)),
          boxShadow: AppTheme.cardGlow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome, size: 14, color: AppTheme.gold),
            const SizedBox(width: 8),
            const SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.gold)),
            const SizedBox(width: 8),
            const Text('Gemini AI is preparing your response...',
              style: TextStyle(color: AppTheme.white50, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}
