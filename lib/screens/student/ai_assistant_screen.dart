import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

import '../../services/env_config.dart';
import '../../theme/app_theme.dart';

class AiAssistantScreen extends StatefulWidget {
  const AiAssistantScreen({super.key});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _isLoading = false;
  late GenerativeModel _model;
  late ChatSession _chat;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: EnvConfig.geminiApiKey,
      systemInstruction: Content.system('You are the ZimHeritage AI Assistant. You are an expert on the Zimbabwe Heritage-Based Curriculum. Answer student questions about Zimbabwean history, culture, and NDS1 in a friendly, encouraging way.'),
    );
    _chat = _model.startChat();
    _messages.add({'role': 'assistant', 'text': 'Mhoro! Siyabonga! I am the ZimHeritage AI Assistant. How can I help you with your Heritage Studies today?'});
  }

  Future<void> _sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    
    setState(() {
      _messages.add({'role': 'user', 'text': text});
      _isLoading = true;
    });
    _controller.clear();

    try {
      final response = await _chat.sendMessage(Content.text(text));
      setState(() {
        _messages.add({'role': 'assistant', 'text': response.text ?? 'I am not sure how to answer that.'});
      });
    } catch (e) {
      setState(() {
        _messages.add({'role': 'assistant', 'text': 'Sorry, I am having trouble connecting to the Ministry servers right now. Please try again later.'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      appBar: AppBar(
        title: const Text('ZimHeritage AI Assistant'),
        backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppTheme.redBright.withValues(alpha: 0.2),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppTheme.redBright, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'MVP Pilot Phase: AI responses are generated automatically. Please verify important facts with your teacher.',
                      style: TextStyle(color: AppTheme.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  _buildPromptChip('What is NDS1?'),
                  const SizedBox(width: 8),
                  _buildPromptChip('Tell me about Great Zimbabwe'),
                  const SizedBox(width: 8),
                  _buildPromptChip('What are Zimbabwe\'s natural resources?'),
                  const SizedBox(width: 8),
                  _buildPromptChip('Explain the liberation struggle'),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isUser = msg['role'] == 'user';
                  return Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                      decoration: BoxDecoration(
                        color: isUser ? AppTheme.gold.withValues(alpha: 0.2) : AppTheme.surfaceDark.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isUser ? AppTheme.gold.withValues(alpha: 0.5) : AppTheme.greenBright.withValues(alpha: 0.3)),
                      ),
                      child: Text(msg['text']!, style: const TextStyle(color: AppTheme.white)),
                    ),
                  );
                },
              ),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: AppTheme.gold),
              ),
            Container(
              padding: const EdgeInsets.all(16),
              color: AppTheme.surfaceDark.withValues(alpha: 0.8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: AppTheme.white),
                      decoration: InputDecoration(
                        hintText: 'Ask about the curriculum...',
                        hintStyle: const TextStyle(color: AppTheme.white50),
                        filled: true,
                        fillColor: AppTheme.black.withValues(alpha: 0.5),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: AppTheme.primaryGreen,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: AppTheme.white),
                      onPressed: () => _sendMessage(_controller.text),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromptChip(String prompt) {
    return ActionChip(
      label: Text(prompt, style: const TextStyle(color: AppTheme.gold, fontSize: 12)),
      backgroundColor: AppTheme.gold.withValues(alpha: 0.1),
      side: BorderSide(color: AppTheme.gold.withValues(alpha: 0.3)),
      onPressed: () {
        _controller.text = prompt;
        _sendMessage(prompt);
      },
    );
  }
}
