import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class DigitalLibraryScreen extends StatelessWidget {
  const DigitalLibraryScreen({super.key});

  final List<Map<String, String>> _textbooks = const [
    {
      'title': 'Heritage Studies',
      'publisher': 'Secondary Book Press',
      'subject': 'Heritage Studies (Core)',
      'icon': '🏛️',
      'color': '0xFFD4AF37'
    },
    {
      'title': 'New General Mathematics',
      'publisher': 'College Press',
      'subject': 'Mathematics (Core)',
      'icon': '📐',
      'color': '0xFF3A86FF'
    },
    {
      'title': 'Step Ahead: English Language',
      'publisher': 'College Press',
      'subject': 'English Language (Core)',
      'icon': '📚',
      'color': '0xFFFF006E'
    },
    {
      'title': 'Focus on Combined Science',
      'publisher': 'College Press',
      'subject': 'Combined Science (Core)',
      'icon': '🔬',
      'color': '0xFF06D6A0'
    },
    {
      'title': 'ChiShona & Ndebele Literature',
      'publisher': 'Secondary Book Press',
      'subject': 'Indigenous Language (Core)',
      'icon': '🗣️',
      'color': '0xFFFFBE0B'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Library (HBC)'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      backgroundColor: AppTheme.surfaceDark,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primaryGreen, AppTheme.surfaceMid],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Zimbabwe Heritage-Based Curriculum', 
                    style: TextStyle(color: AppTheme.gold, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1)),
                  const SizedBox(height: 8),
                  const Text('Official Course Textbooks', 
                    style: TextStyle(color: AppTheme.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Access MoPSE approved textbooks for your registered curriculum.', 
                    style: TextStyle(color: AppTheme.white.withValues(alpha: 0.8), fontSize: 13)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _textbooks.length,
                itemBuilder: (context, index) {
                  final book = _textbooks[index];
                  return _buildBookCard(book);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookCard(Map<String, String> book) {
    final color = Color(int.parse(book['color']!));
    return GlassCard(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(book['icon']!, style: const TextStyle(fontSize: 32)),
              ),
            ),
            const Spacer(),
            Text(book['subject']!, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(book['title']!, style: const TextStyle(color: AppTheme.white, fontSize: 14, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 4),
            Text(book['publisher']!, style: const TextStyle(color: AppTheme.white50, fontSize: 11)),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('READ NOW', textAlign: TextAlign.center, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
