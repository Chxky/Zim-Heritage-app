import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EcdStoryScreen extends StatefulWidget {
  const EcdStoryScreen({super.key});

  @override
  State<EcdStoryScreen> createState() => _EcdStoryScreenState();
}

class _EcdStoryScreenState extends State<EcdStoryScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      'text': 'Once upon a time, in the beautiful plains of Zimbabwe, lived a clever hare named Tsuro.',
      'icon': '🐇',
    },
    {
      'text': 'Tsuro was friends with Gudo, the strong baboon. They played together near the big baobab tree.',
      'icon': '🐒',
    },
    {
      'text': 'One day, it was very hot. Tsuro and Gudo went looking for sweet watermelons.',
      'icon': '🍉',
    },
    {
      'text': 'They found a big, green watermelon! They shared it and lived happily ever after.',
      'icon': '✨',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initTts();
    _speakCurrentPage();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.setVolume(1.0);
  }

  Future<void> _speakCurrentPage() async {
    await _flutterTts.speak(_pages[_currentIndex]['text']!);
  }

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _speakCurrentPage();
    }
  }

  void _prevPage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _speakCurrentPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    final page = _pages[_currentIndex];
    
    return Scaffold(
      backgroundColor: AppTheme.surfaceDark,
      appBar: AppBar(
        title: const Text('Tsuro and Gudo'),
        backgroundColor: Colors.pink.withValues(alpha: 0.2),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: _speakCurrentPage,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(32),
                borderColor: Colors.pink.withValues(alpha: 0.3),
                boxShadow: [
                  BoxShadow(color: Colors.pink.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 10)),
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(page['icon']!, style: const TextStyle(fontSize: 100)),
                    const SizedBox(height: 40),
                    Text(
                      page['text']!,
                      style: const TextStyle(
                        color: AppTheme.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentIndex > 0 ? _prevPage : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.surfaceMid,
                    foregroundColor: AppTheme.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                Text('${_currentIndex + 1} / ${_pages.length}', style: const TextStyle(color: AppTheme.white50, fontSize: 18)),
                ElevatedButton.icon(
                  onPressed: _currentIndex < _pages.length - 1 ? _nextPage : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: AppTheme.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
