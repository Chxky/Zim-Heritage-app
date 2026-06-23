import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import 'package:flutter_tts/flutter_tts.dart';

class EcdWordGamesScreen extends StatefulWidget {
  const EcdWordGamesScreen({super.key});

  @override
  State<EcdWordGamesScreen> createState() => _EcdWordGamesScreenState();
}

class _EcdWordGamesScreenState extends State<EcdWordGamesScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  final List<Map<String, String>> _animals = [
    {'letter': 'A', 'word': 'Antelope', 'icon': '🦌'},
    {'letter': 'B', 'word': 'Buffalo', 'icon': '🐃'},
    {'letter': 'C', 'word': 'Cheetah', 'icon': '🐆'},
    {'letter': 'E', 'word': 'Elephant', 'icon': '🐘'},
    {'letter': 'G', 'word': 'Giraffe', 'icon': '🦒'},
    {'letter': 'H', 'word': 'Hippo', 'icon': '🦛'},
    {'letter': 'L', 'word': 'Lion', 'icon': '🦁'},
    {'letter': 'M', 'word': 'Monkey', 'icon': '🐒'},
    {'letter': 'Z', 'word': 'Zebra', 'icon': '🦓'},
  ];

  final List<Map<String, String>> _transport = [
    {'letter': 'B', 'word': 'Bus', 'icon': '🚌'},
    {'letter': 'C', 'word': 'Car', 'icon': '🚗'},
    {'letter': 'T', 'word': 'Train', 'icon': '🚂'},
    {'letter': 'A', 'word': 'Airplane', 'icon': '✈️'},
    {'letter': 'B', 'word': 'Bicycle', 'icon': '🚲'},
  ];

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.4);
    await _flutterTts.setVolume(1.0);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppTheme.surfaceDark,
        appBar: AppBar(
          title: const Text('Word Games'),
          backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
          bottom: const TabBar(
            indicatorColor: AppTheme.gold,
            tabs: [
              Tab(text: 'Animals'),
              Tab(text: 'Transport'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildGrid(_animals, Colors.orange),
            _buildGrid(_transport, Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(List<Map<String, String>> items, Color color) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GlassCard(
          padding: const EdgeInsets.all(16),
          borderColor: color.withValues(alpha: 0.3),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 4)),
          ],
          onTap: () {
            _speak("${item['letter']} is for ${item['word']}");
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(item['icon']!, style: const TextStyle(fontSize: 60)),
              const SizedBox(height: 12),
              Text(item['word']!, style: const TextStyle(color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(item['letter']!, style: TextStyle(color: color, fontSize: 16, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        );
      },
    );
  }
}
