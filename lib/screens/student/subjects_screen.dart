import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/book_data.dart';
import '../../data/study_resources.dart';
import '../../data/zimbabwe_curriculum.dart';
import '../../models/book.dart';
import '../../models/homework.dart';
import '../../models/study_resource.dart';
import '../../models/subject.dart';
import '../../models/user.dart';
import '../../services/homework_repository.dart';
import '../../theme/app_theme.dart';
import '../../theme/subject_themes.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/subject_scaffold.dart';
import 'past_exams_screen.dart';
import 'topic_detail_screen.dart';

class SubjectsScreen extends StatelessWidget {
  final User user;

  const SubjectsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final subjects = getSubjectsForGradeAndCurriculum(user.gradeLevel, user.curriculum);

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 0.85,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return _buildSubjectCard(context, subjects[index]);
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Subject subject) {
    final color = Color(int.parse(subject.color));
    return GlassCard(
      padding: const EdgeInsets.all(14),
      borderColor: color.withValues(alpha: 0.2),
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => SubjectDetailScreen(subject: subject, user: user),
      )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(_getIconData(subject.icon), size: 32, color: color),
          ),
          const SizedBox(height: 10),
          Text(subject.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.white),
            textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(subject.description,
            style: const TextStyle(fontSize: 11, color: AppTheme.white50),
            textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'abc': return Icons.abc;
      case 'calculate': return Icons.calculate;
      case 'translate': return Icons.translate;
      case 'account_balance': return Icons.account_balance;
      case 'science': return Icons.science;
      case 'palette': return Icons.palette;
      case 'church': return Icons.church;
      case 'sports': return Icons.sports;
      case 'computer': return Icons.computer;
      case 'agriculture': return Icons.agriculture;
      case 'public': return Icons.public;
      case 'explore': return Icons.explore;
      case 'music_note': return Icons.music_note;
      case 'trending_up': return Icons.trending_up;
      case 'business': return Icons.business;
      case 'restaurant': return Icons.restaurant;
      case 'build': return Icons.build;
      case 'psychology': return Icons.psychology;
      case 'groups': return Icons.groups;
      case 'gavel': return Icons.gavel;
      default: return Icons.book;
    }
  }
}

class SubjectDetailScreen extends StatefulWidget {
  final Subject subject;
  final User user;

  const SubjectDetailScreen({super.key, required this.subject, required this.user});

  @override
  State<SubjectDetailScreen> createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  List<Homework> _homeworks = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHomeworks();
  }

  Future<void> _loadHomeworks() async {
    try {
      final homeworks = await HomeworkRepository.getHomeworksByGradeAndSubject(
        widget.user.gradeLevel, widget.subject.id);
      if (mounted) {
        setState(() {
          _homeworks = homeworks;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(widget.subject.color));
    final topics = getTopicsForSubjectAndCurriculum(widget.subject.id, user.gradeLevel, user.curriculum);
    final subTheme = SubjectThemes.forSubjectId(widget.subject.id);

    return SubjectScaffold(
      subjectId: widget.subject.id,
      title: widget.subject.name,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubjectHeaderCard(
              subjectId: widget.subject.id,
              subjectColor: color,
              subjectName: widget.subject.name,
              description: widget.subject.description,
              gradeLevel: widget.subject.gradeLevel,
              icon: _getIconData(widget.subject.icon),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Icon(Icons.menu_book, color: subTheme?.accentColor ?? AppTheme.gold, size: 20),
                const SizedBox(width: 8),
                Text('Topics ($termName)',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
              ],
            ),
            const SizedBox(height: 12),
            if (topics.isEmpty)
              const GlassCard(
                padding: EdgeInsets.all(20),
                child: Text('Topics loading...', style: TextStyle(color: AppTheme.white50)),
              )
            else
              ...topics.map((t) => _buildTopicCard(t, color)),
            if (!user.gradeLevel.startsWith('ECD') && !user.gradeLevel.startsWith('Grade')) ...[
              const SizedBox(height: 20),
              _buildPastExamsButton(color),
            ],
            const SizedBox(height: 24),
            _buildBooksSection(color),
            const SizedBox(height: 24),
            _buildStudyResourcesSection(color),
            if (_homeworks.isNotEmpty || _loading) ...[
              const SizedBox(height: 24),
              Row(
                children: [
                  Icon(Icons.assignment, color: subTheme?.accentColor ?? AppTheme.gold, size: 20),
                  const SizedBox(width: 8),
                  const Text('Homework Assignments',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                ],
              ),
              const SizedBox(height: 12),
              if (_loading)
                const Center(child: CircularProgressIndicator())
              else
                ..._homeworks.map((h) => _buildHomeworkCard(context, h)),
            ],
          ],
        ),
      ),
    );
  }

  String get termName {
    final month = DateTime.now().month;
    if (month >= 1 && month <= 4) return 'Term 1';
    if (month >= 5 && month <= 8) return 'Term 2';
    return 'Term 3';
  }

  User get user => widget.user;

  Widget _buildStudyResourcesSection(Color color) {
    final resources = getResourcesForSubject(widget.subject.id, user.gradeLevel);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.language, color: AppTheme.gold, size: 20),
            const SizedBox(width: 8),
            const Text('Internet & Open Study Resources',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text('${resources.length}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
            ),
          ],
        ),
        const SizedBox(height: 4),
        const Text('Sourced Open Educational Resources (OER), video labs, simulations & study portals',
          style: TextStyle(fontSize: 12, color: AppTheme.white50)),
        const SizedBox(height: 12),
        ...resources.map((res) => _buildResourceCard(res, color)),
      ],
    );
  }

  Widget _buildResourceCard(StudyResource res, Color subjectColor) {
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
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      borderColor: subjectColor.withValues(alpha: 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: categoryColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(categoryIcon, color: categoryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(res.title,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    Text(res.provider,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: categoryColor)),
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
              label: const Text('Open Internet Study Source', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: subjectColor.withValues(alpha: 0.25),
                foregroundColor: AppTheme.white,
                side: BorderSide(color: subjectColor.withValues(alpha: 0.5)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksSection(Color color) {
    final books = getBooksForSubject(widget.subject.id, user.gradeLevel);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.library_books, color: AppTheme.gold, size: 20),
            const SizedBox(width: 8),
            const Text('Recommended Books',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
            const SizedBox(width: 8),
            if (books.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('${books.length}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
              ),
          ],
        ),
        const SizedBox(height: 12),
        if (books.isEmpty)
          GlassCard(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const Icon(Icons.menu_book, size: 40, color: AppTheme.white30),
                const SizedBox(height: 8),
                const Text('Learning materials coming soon',
                  style: TextStyle(color: AppTheme.white60, fontSize: 14)),
                Text('Books and resources for ${widget.subject.name} will be added shortly',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.white30, fontSize: 12)),
              ],
            ),
          )
        else
          ...books.map((book) => _buildBookCard(book, color)),
      ],
    );
  }

  Widget _buildBookCard(Book book, Color subjectColor) {
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
        typeColor = Colors.blue;
        break;
      case 'activity_book':
        typeIcon = Icons.handyman;
        typeColor = Colors.orange;
        break;
      case 'storybook':
        typeIcon = Icons.child_care;
        typeColor = Colors.pink;
        break;
      default:
        typeIcon = Icons.book;
        typeColor = AppTheme.white60;
    }

    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      borderColor: subjectColor.withValues(alpha: 0.12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: typeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(typeIcon, color: typeColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.white)),
                const SizedBox(height: 2),
                Text(book.author,
                  style: const TextStyle(fontSize: 11, color: AppTheme.gold)),
                const SizedBox(height: 4),
                Text(book.description,
                  maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: AppTheme.white50, height: 1.4)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: typeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: typeColor.withValues(alpha: 0.2)),
                  ),
                  child: Text(_typeLabel(book.type),
                    style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: typeColor)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'textbook': return 'TEXTBOOK';
      case 'set_book': return 'SET BOOK';
      case 'reference': return 'REFERENCE';
      case 'activity_book': return 'ACTIVITY BOOK';
      case 'storybook': return 'STORYBOOK';
      default: return type.toUpperCase();
    }
  }

  Widget _buildTopicCard(Topic data, Color color) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: color.withValues(alpha: 0.15),
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => TopicDetailScreen(topic: data, subject: widget.subject, user: user),
      )),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.menu_book, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.name,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: AppTheme.white)),
                const SizedBox(height: 2),
                Text(data.description,
                  maxLines: 1, overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(data.term,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.gold)),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: AppTheme.white30, size: 20),
        ],
      ),
    );
  }

  Widget _buildHomeworkCard(BuildContext context, Homework hw) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      onTap: () => Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomeworkDetailScreen(homework: hw, user: user),
      )),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.gold.withValues(alpha: 0.1)),
            ),
            child: const Icon(Icons.assignment, color: AppTheme.gold, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(hw.title, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.white)),
                const SizedBox(height: 2),
                Text('Due: ${hw.dueDate.day}/${hw.dueDate.month}/${hw.dueDate.year}  •  ${hw.questions.length} questions',
                  style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.white30),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'abc': return Icons.abc;
      case 'calculate': return Icons.calculate;
      case 'translate': return Icons.translate;
      case 'account_balance': return Icons.account_balance;
      case 'science': return Icons.science;
      case 'palette': return Icons.palette;
      case 'church': return Icons.church;
      case 'sports': return Icons.sports;
      case 'computer': return Icons.computer;
      case 'agriculture': return Icons.agriculture;
      case 'public': return Icons.public;
      case 'explore': return Icons.explore;
      case 'music_note': return Icons.music_note;
      case 'trending_up': return Icons.trending_up;
      case 'business': return Icons.business;
      case 'restaurant': return Icons.restaurant;
      case 'build': return Icons.build;
      case 'psychology': return Icons.psychology;
      case 'groups': return Icons.groups;
      case 'gavel': return Icons.gavel;
      default: return Icons.book;
    }
  }

  Widget _buildPastExamsButton(Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      borderColor: Colors.deepPurple.withValues(alpha: 0.15),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('${widget.subject.name} Past Exams'),
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
            body: PastExamsScreen(user: user),
          ),
        ));
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.history_edu, color: Colors.deepPurple, size: 24),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Past Exam Papers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppTheme.white)),
                Text('Practice with real exam questions from past years',
                  style: TextStyle(color: AppTheme.white50, fontSize: 11)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.deepPurple, size: 24),
        ],
      ),
    );
  }
}

class HomeworkDetailScreen extends StatefulWidget {
  final Homework homework;
  final User user;

  const HomeworkDetailScreen({super.key, required this.homework, required this.user});

  @override
  State<HomeworkDetailScreen> createState() => _HomeworkDetailScreenState();
}

class _HomeworkDetailScreenState extends State<HomeworkDetailScreen> {
  final Map<String, TextEditingController> _controllers = {};
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    for (final q in widget.homework.questions) {
      _controllers[q.id] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) { c.dispose(); }
    super.dispose();
  }

  void _submitHomework() {
    final allAnswered = widget.homework.questions
        .every((q) => _controllers[q.id]!.text.trim().isNotEmpty);
    if (!allAnswered) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please answer all questions before submitting.'),
          backgroundColor: AppTheme.red),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Submit Homework?'),
        content: const Text('Once submitted, you cannot edit your answers. Your teacher will review your work.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _submitted = true);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Homework submitted successfully!'),
                  backgroundColor: AppTheme.primaryGreen),
              );
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.homework.title),
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
      body: _submitted
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppTheme.greenBright.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
                    ),
                    child: const Icon(Icons.check_circle, color: AppTheme.greenBright, size: 64),
                  ),
                  const SizedBox(height: 20),
                  const Text('Homework Submitted!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.white)),
                  const SizedBox(height: 8),
                  const Text('Your teacher will review and provide feedback.', style: TextStyle(color: AppTheme.white60)),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.greenBright.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.2)),
                              ),
                              child: Text(widget.homework.gradeLevel,
                                style: const TextStyle(color: AppTheme.greenBright, fontWeight: FontWeight.bold, fontSize: 12)),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.calendar_today, size: 14, color: AppTheme.white50),
                            const SizedBox(width: 4),
                            Text('Due: ${widget.homework.dueDate.day}/${widget.homework.dueDate.month}/${widget.homework.dueDate.year}',
                              style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(widget.homework.description, style: const TextStyle(fontSize: 14, color: AppTheme.white80)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.gold.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text('Total Marks: ${widget.homework.questions.fold(0, (sum, q) => sum + q.marks)}',
                            style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text('Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                  const SizedBox(height: 12),
                  ...widget.homework.questions.asMap().entries.map((entry) {
                    final index = entry.key;
                    final q = entry.value;
                    return GlassCard(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 28, height: 28,
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text('${index + 1}',
                                    style: const TextStyle(color: AppTheme.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(q.question, style: const TextStyle(fontSize: 14, color: AppTheme.white))),
                              Text('${q.marks} mk', style: const TextStyle(color: AppTheme.white50, fontSize: 12)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextField(
                            controller: _controllers[q.id],
                            maxLines: null,
                            minLines: 2,
                            decoration: InputDecoration(
                              hintText: 'Type your answer here...',
                              filled: true,
                              fillColor: AppTheme.surfaceMid,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.all(12),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity, height: 50,
                    child: ElevatedButton.icon(
                      onPressed: _submitHomework,
                      icon: const Icon(Icons.send),
                      label: const Text('Submit Homework', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
