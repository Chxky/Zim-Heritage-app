import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AIReadingAssistant extends StatefulWidget {
  const AIReadingAssistant({super.key});

  @override
  State<AIReadingAssistant> createState() => _AIReadingAssistantState();
}

class _AIReadingAssistantState extends State<AIReadingAssistant>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  final _textController = TextEditingController();
  bool _isListening = false;
  String _aiResponse = '';
  bool _hasResponded = false;

  final List<Map<String, String>> _readingExercises = [
    {'text': 'The cat sat on the mat.', 'age': 'ECD A'},
    {'text': 'I can see a big red ball.', 'age': 'ECD A'},
    {'text': 'The sun is hot and yellow.', 'age': 'ECD A'},
    {'text': 'My dog runs in the park.', 'age': 'ECD A'},
    {'text': 'She has a blue dress.', 'age': 'ECD B'},
    {'text': 'The bird can fly very high.', 'age': 'ECD B'},
    {'text': 'We play and sing every day.', 'age': 'ECD B'},
    {'text': 'He likes to eat apples.', 'age': 'ECD B'},
  ];

  int _currentExercise = 0;
  int _starsEarned = 0;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        _pulseController.repeat(reverse: true);
        _hasResponded = false;
        _aiResponse = '';
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) _simulateReading();
        });
      } else {
        _pulseController.stop();
        _pulseController.reset();
      }
    });
  }

  void _simulateReading() {
    final exercise = _readingExercises[_currentExercise];
    final text = exercise['text']!;
    final typedText = _textController.text.trim();

    if (typedText.isEmpty) {
      setState(() {
        _aiResponse = 'Try reading the sentence aloud! Point to each word as you say it.';
        _hasResponded = true;
        _isListening = false;
        _pulseController.stop();
        _pulseController.reset();
      });
      return;
    }

    final errors = <String>[];
    final typedWords = typedText.split(RegExp(r'\s+'));
    final correctWords = text.split(RegExp(r'\s+'));

    for (int i = 0; i < typedWords.length && i < correctWords.length; i++) {
      if (typedWords[i].toLowerCase() != correctWords[i].toLowerCase()) {
        errors.add('"${typedWords[i]}" should be "${correctWords[i]}"');
      }
    }

    if (typedWords.length < correctWords.length) {
      errors.add('Keep going! You missed: "${correctWords.sublist(typedWords.length).join(' ')}"');
    }

    if (errors.isEmpty) {
      final newStars = _starsEarned + 1;
      _starsEarned = newStars;
      setState(() {
        _aiResponse = 'Perfect reading! You got it all right! \n\n'
            '${newStars % 3 == 0 ? "Amazing! You earned a star! " : ""}'
            'Keep practising to become a super reader!';
        _hasResponded = true;
        _isListening = false;
        _pulseController.stop();
        _pulseController.reset();
      });
    } else {
      setState(() {
        _aiResponse = 'Good try! Let me help you:\n\n'
            '${errors.take(3).join('\n')}\n\n'
            'Try again slowly. You can do it!';
        _hasResponded = true;
        _isListening = false;
        _pulseController.stop();
        _pulseController.reset();
      });
    }
  }

  void _nextExercise() {
    setState(() {
      _currentExercise = (_currentExercise + 1) % _readingExercises.length;
      _textController.clear();
      _aiResponse = '';
      _hasResponded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercise = _readingExercises[_currentExercise];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTheme.cardGlow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.auto_awesome, color: AppTheme.white, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('AI Reading Assistant',
                          style: TextStyle(color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        Text('Learn to read with AI',
                          style: TextStyle(color: AppTheme.white.withValues(alpha: 0.8), fontSize: 13)),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.gold,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.brown, size: 16),
                          const SizedBox(width: 4),
                          Text('$_starsEarned',
                            style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTheme.softShadow,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.cream,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(exercise['age']!,
                        style: const TextStyle(color: Colors.brown, fontWeight: FontWeight.bold, fontSize: 11)),
                    ),
                    const Spacer(),
                    Text('Exercise ${_currentExercise + 1}/${_readingExercises.length}',
                      style: const TextStyle(color: AppTheme.greyMedium, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),
                const Text('Read this sentence:',
                  style: TextStyle(fontSize: 13, color: AppTheme.greyDark)),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.lightGreen,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
                  ),
                  child: Text(exercise['text']!,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryGreen, height: 1.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: AppTheme.softShadow,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Type what you read:',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.greyDark)),
                const SizedBox(height: 8),
                TextField(
                  controller: _textController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText: 'Type the sentence here...',
                    hintStyle: const TextStyle(color: AppTheme.greyMedium),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale = _isListening ? 1.0 + (_pulseController.value * 0.05) : 1.0;
                    return Transform.scale(
                      scale: scale,
                      child: SizedBox(
                        height: 52,
                        child: ElevatedButton.icon(
                          onPressed: _toggleListening,
                          icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                          label: Text(_isListening ? 'Listening...' : 'Start Reading'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isListening ? AppTheme.gold : AppTheme.primaryGreen,
                            foregroundColor: _isListening ? Colors.brown : AppTheme.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 52,
                child: OutlinedButton(
                  onPressed: _nextExercise,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    side: const BorderSide(color: AppTheme.primaryGreen),
                  ),
                  child: const Text('Next', style: TextStyle(color: AppTheme.primaryGreen)),
                ),
              ),
            ],
          ),
          if (_hasResponded) ...[
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _aiResponse.contains('Perfect') ? AppTheme.lightGreen : AppTheme.cream,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _aiResponse.contains('Perfect') ? AppTheme.primaryGreen : AppTheme.gold,
                  width: 1.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: _aiResponse.contains('Perfect') ? AppTheme.primaryGreen : AppTheme.gold,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _aiResponse.contains('Perfect') ? Icons.celebration : Icons.auto_awesome,
                      color: AppTheme.white, size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(_aiResponse,
                      style: TextStyle(
                        fontSize: 14,
                        color: _aiResponse.contains('Perfect') ? AppTheme.darkGreen : Colors.brown,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
