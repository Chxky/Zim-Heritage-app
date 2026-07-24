import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/book_data.dart';
import '../../data/study_resources.dart';
import '../../models/book.dart';
import '../../models/study_resource.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class DigitalLibraryScreen extends StatefulWidget {
  const DigitalLibraryScreen({super.key});

  @override
  State<DigitalLibraryScreen> createState() => _DigitalLibraryScreenState();
}

class _DigitalLibraryScreenState extends State<DigitalLibraryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Library & Open Study Hub'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.gold,
          labelColor: AppTheme.gold,
          unselectedLabelColor: AppTheme.white60,
          tabs: const [
            Tab(icon: Icon(Icons.import_contacts), text: 'MoPSE & Set Books'),
            Tab(icon: Icon(Icons.language), text: 'Internet & OER Portals'),
          ],
        ),
      ),
      backgroundColor: AppTheme.surfaceDark,
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildTextbooksTab(),
            _buildStudyResourcesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextbooksTab() {
    final books = allBooks;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return _buildBookCard(book);
      },
    );
  }

  Widget _buildStudyResourcesTab() {
    final resources = allStudyResources;
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: resources.length,
      itemBuilder: (context, index) {
        final res = resources[index];
        return _buildResourceCard(res);
      },
    );
  }

  Widget _buildBookCard(Book book) {
    IconData typeIcon;
    Color typeColor;
    switch (book.type) {
      case 'textbook':
        typeIcon = Icons.import_contacts;
        typeColor = AppTheme.primaryGreen;
        break;
      case 'set_book':
        typeIcon = Icons.auto_stories;
        typeColor = AppTheme.gold;
        break;
      case 'reference':
        typeIcon = Icons.find_in_page;
        typeColor = Colors.blueAccent;
        break;
      case 'activity_book':
        typeIcon = Icons.handyman;
        typeColor = Colors.orangeAccent;
        break;
      case 'storybook':
        typeIcon = Icons.child_care;
        typeColor = Colors.pinkAccent;
        break;
      default:
        typeIcon = Icons.book;
        typeColor = AppTheme.white60;
    }

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      borderColor: typeColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(typeIcon, color: typeColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    Text('Author: ${book.author}',
                      style: const TextStyle(fontSize: 12, color: AppTheme.white60)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(book.description,
            style: const TextStyle(fontSize: 12, color: AppTheme.white70)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 6,
            runSpacing: 4,
            children: book.gradeLevels.map((g) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(g, style: const TextStyle(fontSize: 10, color: AppTheme.gold, fontWeight: FontWeight.bold)),
            )).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(StudyResource res) {
    IconData categoryIcon;
    Color categoryColor;
    switch (res.category) {
      case 'video_lesson':
        categoryIcon = Icons.play_circle_fill;
        categoryColor = Colors.redAccent;
        break;
      case 'interactive_simulation':
        categoryIcon = Icons.science;
        categoryColor = Colors.purpleAccent;
        break;
      case 'past_papers':
        categoryIcon = Icons.description;
        categoryColor = AppTheme.gold;
        break;
      case 'heritage_archive':
        categoryIcon = Icons.account_balance;
        categoryColor = AppTheme.greenBright;
        break;
      default:
        categoryIcon = Icons.language;
        categoryColor = Colors.blueAccent;
    }

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      borderColor: categoryColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(categoryIcon, color: categoryColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(res.title,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    Text(res.provider,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: categoryColor)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(res.description,
            style: const TextStyle(fontSize: 12, color: AppTheme.white70)),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(res.url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } else {
                  await launchUrl(uri, mode: LaunchMode.inAppWebView);
                }
              },
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Open Resource', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: categoryColor.withValues(alpha: 0.25),
                foregroundColor: AppTheme.white,
                side: BorderSide(color: categoryColor.withValues(alpha: 0.5)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
