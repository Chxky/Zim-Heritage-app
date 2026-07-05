// widgets/ai_tutor.dart
import 'package:flutter/material.dart';

import '../services/gemini_service.dart';
import '../theme/app_theme.dart';

class AITutor extends StatefulWidget {
  final String gradeLevel;

  const AITutor({super.key, required this.gradeLevel});

  @override
  State<AITutor> createState() => _AITutorState();
}

class _AITutorState extends State<AITutor> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  final List<TutorMessage> _messages = [];
  final List<({String role, String text})> _history = [];
  bool _isThinking = false;
  String? _selectedSubject;
  String? _selectedDifficulty;

  final List<String> _subjects = [
    'Mathematics', 'English', 'Shona/Ndebele', 'Science', 'History',
    'Geography', 'Agriculture', 'Biology', 'Chemistry', 'Physics',
    'Accounting', 'Economics', 'Computer Science', 'Heritage Studies',
    'Global Perspectives', 'ICT', 'Art and Design', 'Music', 'French',
    'Business Studies', 'Psychology', 'Sociology', 'Law', 'Design and Technology',
    'Food and Nutrition', 'English Literature', 'Religious Studies',
  ];
  final List<String> _difficulties = ['Easy', 'Medium', 'Hard'];

  final List<String> _quickPrompts = [
    '📝 Give me a practice question',
    '💡 Explain the last topic',
    '✅ Check my understanding',
    '🇿🇼 Give a Zimbabwe example',
  ];

  @override
  void initState() {
    super.initState();
    final gradeLabel = widget.gradeLevel;
    String level = '';
    if (gradeLabel.startsWith('ECD')) {
      level = 'ECD';
    } else if (gradeLabel.startsWith('Grade')) {
      level = 'Primary';
    } else if (gradeLabel.startsWith('Form')) {
      level = 'Secondary';
    }

    _messages.add(TutorMessage(
      text: 'Salibonani! 👋 I\'m your **ZimHeritage AI Tutor** for **$gradeLabel** ($level).\n\n'
          'I\'m powered by Google Gemini and know the Zimbabwe Heritage Curriculum inside out.\n\n'
          '**I can help you:**\n'
          '- Explain tricky concepts in simple words\n'
          '- Practice questions at your level\n'
          '- Check your answers and give feedback\n'
          '- Connect lessons to real Zimbabwe examples\n\n'
          'Select a subject above, then ask me anything! 🌍',
      isUser: false,
    ));
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(TutorMessage(text: text.trim(), isUser: true));
      _isThinking = true;
    });
    _messageController.clear();
    _scrollToBottom();

    // Add to history
    _history.add((role: 'user', text: text.trim()));

    final response = await GeminiService.askTutor(
      userMessage: text.trim(),
      gradeLevel: widget.gradeLevel,
      subject: _selectedSubject,
      difficulty: _selectedDifficulty,
      history: List.from(_history)..removeLast(), // history without the last message
    );

    _history.add((role: 'model', text: response));

    if (!mounted) return;
    setState(() {
      _messages.add(TutorMessage(text: response, isUser: false));
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.auto_awesome, color: AppTheme.white, size: 22),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('AI Tutor',
                          style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('${widget.gradeLevel} • Powered by Gemini AI',
                          style: TextStyle(color: AppTheme.white.withValues(alpha: 0.8), fontSize: 11)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedDifficulty,
                        hint: const Text('Level', style: TextStyle(color: AppTheme.white, fontSize: 11)),
                        dropdownColor: AppTheme.primaryGreen,
                        style: const TextStyle(color: AppTheme.white, fontSize: 12),
                        items: _difficulties.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                        onChanged: (v) => setState(() => _selectedDifficulty = v),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppTheme.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSubject,
                    hint: const Text('Select subject to study', style: TextStyle(color: AppTheme.white70, fontSize: 11)),
                    isExpanded: true,
                    dropdownColor: AppTheme.primaryGreen,
                    style: const TextStyle(color: AppTheme.white, fontSize: 12),
                    items: _subjects.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) => setState(() => _selectedSubject = v),
                  ),
                ),
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
              if (index == _messages.length && _isThinking) {
                return _buildThinkingIndicator();
              }
              return _buildMessageBubble(_messages[index]);
            },
          ),
        ),

        // Quick prompts
        if (!_isThinking && _messages.length <= 2)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: _quickPrompts.map((p) => GestureDetector(
                onTap: () => _sendMessage(p),
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
                  ),
                  child: Text(p, style: const TextStyle(color: AppTheme.white70, fontSize: 12)),
                ),
              )).toList(),
            ),
          ),

        // Input bar
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.white,
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 10, offset: const Offset(0, -2))],
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: _selectedSubject != null
                        ? 'Ask about $_selectedSubject...'
                        : 'Ask me anything...',
                    filled: true,
                    fillColor: AppTheme.greyLight,
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
                decoration: const BoxDecoration(
                  gradient: AppTheme.primaryGradient,
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

  Widget _buildMessageBubble(TutorMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.82),
        decoration: BoxDecoration(
          color: message.isUser ? AppTheme.primaryGreen : AppTheme.white,
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomRight: message.isUser ? const Radius.circular(4) : null,
            bottomLeft: !message.isUser ? const Radius.circular(4) : null,
          ),
          boxShadow: AppTheme.softShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!message.isUser)
              const Row(
                children: [
                  Icon(Icons.auto_awesome, size: 14, color: AppTheme.primaryGreen),
                  SizedBox(width: 4),
                  Text('ZimHeritage AI',
                    style: TextStyle(color: AppTheme.primaryGreen, fontSize: 11, fontWeight: FontWeight.bold)),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isUser ? AppTheme.white : AppTheme.darkGreen,
              fontSize: 14,
            )),
        ));
      } else if (line.startsWith('_') && line.endsWith('_')) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(line.replaceAll('_', ''),
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: isUser ? AppTheme.white70 : AppTheme.greyMedium,
              fontSize: 12,
            )),
        ));
      } else if (line.startsWith('- ') || RegExp(r'^\d+\.').hasMatch(line)) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(left: 8, top: 2),
          child: Text(line,
            style: TextStyle(color: isUser ? AppTheme.white : AppTheme.black, fontSize: 13)),
        ));
      } else {
        widgets.add(Padding(
          padding: const EdgeInsets.only(top: 1),
          child: Text(line,
            style: TextStyle(color: isUser ? AppTheme.white : AppTheme.black, fontSize: 13)),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(16).copyWith(bottomLeft: const Radius.circular(4)),
          boxShadow: AppTheme.softShadow,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_awesome, size: 14, color: AppTheme.primaryGreen),
            SizedBox(width: 8),
            SizedBox(width: 18, height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.primaryGreen)),
            SizedBox(width: 8),
            Text('Gemini is thinking...', style: TextStyle(color: AppTheme.greyMedium, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class TutorMessage {
  final String text;
  final bool isUser;

  TutorMessage({required this.text, required this.isUser});
}
