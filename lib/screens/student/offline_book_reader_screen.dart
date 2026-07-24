import 'package:flutter/material.dart';
import '../../models/book.dart';
import '../../services/offline_book_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class OfflineBookReaderScreen extends StatefulWidget {
  final Book book;

  const OfflineBookReaderScreen({super.key, required this.book});

  @override
  State<OfflineBookReaderScreen> createState() => _OfflineBookReaderScreenState();
}

class _OfflineBookReaderScreenState extends State<OfflineBookReaderScreen> {
  List<Map<String, dynamic>> _chapters = [];
  bool _isLoading = true;
  int _currentChapterIndex = 0;
  double _fontSize = 15.0;
  bool _showAnswers = false;

  @override
  void initState() {
    super.initState();
    _loadBookContent();
  }

  Future<void> _loadBookContent() async {
    try {
      final content = await OfflineBookService.getOfflineBookContent(widget.book.id);
      if (mounted) {
        setState(() {
          _chapters = content;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.book.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            const Text('⚡ Offline Reading Mode', style: TextStyle(fontSize: 10, color: AppTheme.greenBright)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.text_fields),
            tooltip: 'Adjust Font Size',
            onPressed: () {
              setState(() {
                _fontSize = (_fontSize >= 20.0) ? 13.0 : _fontSize + 2.0;
              });
            },
          ),
        ],
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.gold))
          : _chapters.isEmpty
              ? const Center(child: Text('No offline content available', style: TextStyle(color: AppTheme.white60)))
              : Column(
                  children: [
                    // Chapter selector tabs bar
                    Container(
                      height: 48,
                      color: AppTheme.surfaceMid,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        itemCount: _chapters.length,
                        itemBuilder: (context, idx) {
                          final isSelected = idx == _currentChapterIndex;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text('Ch ${idx + 1}',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected ? AppTheme.surfaceDark : AppTheme.white,
                                ),
                              ),
                              selected: isSelected,
                              selectedColor: AppTheme.gold,
                              backgroundColor: AppTheme.white.withValues(alpha: 0.1),
                              onSelected: (_) => setState(() {
                                _currentChapterIndex = idx;
                                _showAnswers = false;
                              }),
                            ),
                          );
                        },
                      ),
                    ),

                    // Chapter Reading Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildChapterHeader(_chapters[_currentChapterIndex]),
                            const SizedBox(height: 20),
                            _buildChapterBody(_chapters[_currentChapterIndex]),
                            const SizedBox(height: 24),
                            _buildPracticeQuestionsSection(_chapters[_currentChapterIndex]),
                            const SizedBox(height: 32),
                            _buildChapterNavigationButtons(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildChapterHeader(Map<String, dynamic> chapter) {
    final title = chapter['title'] as String? ?? 'Chapter Title';
    final objectives = List<String>.from(chapter['objectives'] as List? ?? []);

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: AppTheme.gold.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.gold)),
          if (objectives.isNotEmpty) ...[
            const SizedBox(height: 12),
            const Text('Chapter Objectives:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.white)),
            const SizedBox(height: 6),
            ...objectives.map((obj) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_outline, color: AppTheme.greenBright, size: 14),
                  const SizedBox(width: 6),
                  Expanded(child: Text(obj, style: const TextStyle(fontSize: 12, color: AppTheme.white80))),
                ],
              ),
            )),
          ],
        ],
      ),
    );
  }

  Widget _buildChapterBody(Map<String, dynamic> chapter) {
    final content = chapter['content'] as String? ?? '';
    final keyPoints = List<String>.from(chapter['keyPoints'] as List? ?? []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(content,
          style: TextStyle(fontSize: _fontSize, height: 1.6, color: AppTheme.white.withValues(alpha: 0.9))),
        if (keyPoints.isNotEmpty) ...[
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.stars, color: AppTheme.greenBright, size: 18),
                    SizedBox(width: 8),
                    Text('Key Summary Points:',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.greenBright)),
                  ],
                ),
                const SizedBox(height: 10),
                ...keyPoints.map((kp) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold)),
                      Expanded(child: Text(kp, style: const TextStyle(fontSize: 13, color: AppTheme.white))),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPracticeQuestionsSection(Map<String, dynamic> chapter) {
    final rawQuestions = chapter['practiceQuestions'] as List? ?? [];
    if (rawQuestions.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.quiz, color: AppTheme.gold, size: 20),
                SizedBox(width: 8),
                Text('Self-Assessment Quizzes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
              ],
            ),
            TextButton.icon(
              onPressed: () => setState(() => _showAnswers = !_showAnswers),
              icon: Icon(_showAnswers ? Icons.visibility_off : Icons.visibility, size: 16, color: AppTheme.gold),
              label: Text(_showAnswers ? 'Hide Answers' : 'Reveal Answers',
                style: const TextStyle(fontSize: 12, color: AppTheme.gold, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...rawQuestions.map((q) {
          final map = q as Map<String, dynamic>;
          final question = map['question'] as String? ?? '';
          final answer = map['answer'] as String? ?? '';
          final explanation = map['explanation'] as String? ?? '';

          return GlassCard(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            borderColor: AppTheme.white10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Q: $question',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.white)),
                if (_showAnswers) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppTheme.gold.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Answer: $answer',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                        if (explanation.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text('Explanation: $explanation',
                            style: const TextStyle(fontSize: 11, color: AppTheme.white70)),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildChapterNavigationButtons() {
    final isFirst = _currentChapterIndex == 0;
    final isLast = _currentChapterIndex == _chapters.length - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: isFirst
              ? null
              : () => setState(() {
                    _currentChapterIndex--;
                    _showAnswers = false;
                  }),
          icon: const Icon(Icons.arrow_back, size: 16),
          label: const Text('Previous Chapter'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.surfaceMid,
            foregroundColor: AppTheme.white,
          ),
        ),
        ElevatedButton.icon(
          onPressed: isLast
              ? null
              : () => setState(() {
                    _currentChapterIndex++;
                    _showAnswers = false;
                  }),
          icon: const Icon(Icons.arrow_forward, size: 16),
          label: const Text('Next Chapter'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.gold,
            foregroundColor: AppTheme.surfaceDark,
          ),
        ),
      ],
    );
  }
}
