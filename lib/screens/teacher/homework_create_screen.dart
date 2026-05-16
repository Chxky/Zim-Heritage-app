// screens/teacher/homework_create_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/user.dart';
import '../../models/homework.dart';
import '../../services/homework_repository.dart';
import '../../data/zimbabwe_curriculum.dart';
import '../../models/subject.dart';
import '../../widgets/glass_card.dart';

class HomeworkCreateScreen extends StatefulWidget {
  final User user;

  const HomeworkCreateScreen({super.key, required this.user});

  @override
  State<HomeworkCreateScreen> createState() => _HomeworkCreateScreenState();
}

class _HomeworkCreateScreenState extends State<HomeworkCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final List<_QuestionEntry> _questions = [];
  bool _isSubmitting = false;

  String? _selectedGrade;
  String? _selectedSubject;
  DateTime? _dueDate;

  List<String> get _grades => getGradeLevels();
  List<Subject> get _subjects => getAllSubjects();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (final q in _questions) {
      q.questionController.dispose();
      q.marksController.dispose();
      for (final o in q.optionControllers) {
        o.dispose();
      }
    }
    super.dispose();
  }

  void _addQuestion() {
    setState(() {
      _questions.add(_QuestionEntry(
        questionController: TextEditingController(),
        marksController: TextEditingController(),
      ));
    });
  }

  void _removeQuestion(int index) {
    final q = _questions[index];
    q.questionController.dispose();
    q.marksController.dispose();
    for (final o in q.optionControllers) {
      o.dispose();
    }
    setState(() {
      _questions.removeAt(index);
    });
  }

  void _addOption(int questionIndex) {
    setState(() {
      _questions[questionIndex].optionControllers.add(TextEditingController());
    });
  }

  void _removeOption(int questionIndex, int optionIndex) {
    final ctrl = _questions[questionIndex].optionControllers[optionIndex];
    ctrl.dispose();
    setState(() {
      _questions[questionIndex].optionControllers.removeAt(optionIndex);
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppTheme.surfaceDark,
              headerBackgroundColor: AppTheme.primaryGreen,
              headerForegroundColor: AppTheme.white,
              dayForegroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return AppTheme.white;
                return AppTheme.white80;
              }),
              dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) return AppTheme.primaryGreen;
                return null;
              }),
              todayForegroundColor: WidgetStateProperty.all(AppTheme.gold),
              todayBackgroundColor: WidgetStateProperty.all(AppTheme.gold.withValues(alpha: 0.15)),
              surfaceTintColor: AppTheme.surfaceDark,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _dueDate = picked);
    }
  }

  String? _validateQuestions() {
    if (_questions.isEmpty) return 'Add at least one question';
    for (int i = 0; i < _questions.length; i++) {
      final q = _questions[i];
      if (q.questionController.text.trim().isEmpty) {
        return 'Question ${i + 1} text is required';
      }
      if (q.marksController.text.trim().isEmpty) {
        return 'Question ${i + 1} marks are required';
      }
      if (int.tryParse(q.marksController.text.trim()) == null ||
          int.parse(q.marksController.text.trim()) <= 0) {
        return 'Question ${i + 1} marks must be a positive number';
      }
      if (q.type == 'multiple_choice') {
        if (q.optionControllers.length < 2) {
          return 'Question ${i + 1} needs at least 2 options';
        }
        for (int j = 0; j < q.optionControllers.length; j++) {
          if (q.optionControllers[j].text.trim().isEmpty) {
            return 'Question ${i + 1}, option ${j + 1} is empty';
          }
        }
      }
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final questionsError = _validateQuestions();
    if (questionsError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(questionsError)),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final id = '${widget.user.id}_${DateTime.now().millisecondsSinceEpoch}';
      if (_selectedSubject == null) throw Exception('Please select a subject');
      final subject = _subjects.firstWhere((s) => s.id == _selectedSubject);

      final questions = <HomeworkQuestion>[];
      for (int i = 0; i < _questions.length; i++) {
        final q = _questions[i];
        questions.add(HomeworkQuestion(
          id: '${id}_q$i',
          question: q.questionController.text.trim(),
          type: q.type,
          marks: int.parse(q.marksController.text.trim()),
          options: q.type == 'multiple_choice'
              ? q.optionControllers.map((o) => o.text.trim()).toList()
              : null,
        ));
      }

      final homework = Homework(
        id: id,
        subjectId: subject.id,
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        gradeLevel: _selectedGrade!,
        dueDate: _dueDate!,
        questions: questions,
        teacherId: widget.user.id,
      );

      await HomeworkRepository.createHomework(homework);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Homework created successfully!'),
          backgroundColor: AppTheme.primaryGreen,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create homework: $e'),
          backgroundColor: AppTheme.red,
        ),
      );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Homework'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildBasicFields(),
              const SizedBox(height: 20),
              _buildQuestionsSection(),
              const SizedBox(height: 20),
              _buildSubmitButton(),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return GlassCard(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
                ),
                child: const Icon(Icons.assignment_add, color: AppTheme.gold, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('New Homework',
                      style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Create and assign homework to your class',
                      style: TextStyle(color: AppTheme.white60, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 3,
            decoration: const BoxDecoration(
              gradient: AppTheme.flagBarGradient,
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicFields() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Homework Details',
            style: TextStyle(color: AppTheme.white, fontSize: 16, fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          TextFormField(
            controller: _titleController,
            style: const TextStyle(color: AppTheme.white),
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'e.g. Chapter 3 Review Questions',
              prefixIcon: Icon(Icons.title),
            ),
            validator: (v) => v == null || v.trim().isEmpty ? 'Title is required' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _descriptionController,
            maxLines: 3,
            style: const TextStyle(color: AppTheme.white),
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText: 'Describe what this homework covers...',
              prefixIcon: Icon(Icons.description),
              alignLabelWithHint: true,
            ),
            validator: (v) => v == null || v.trim().isEmpty ? 'Description is required' : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedGrade,
            dropdownColor: AppTheme.surfaceDark,
            decoration: const InputDecoration(
              labelText: 'Grade Level',
              prefixIcon: Icon(Icons.school),
            ),
            style: const TextStyle(color: AppTheme.white),
            items: _grades.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
            onChanged: (v) => setState(() => _selectedGrade = v),
            validator: (v) => v == null ? 'Select a grade level' : null,
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedSubject,
            dropdownColor: AppTheme.surfaceDark,
            decoration: const InputDecoration(
              labelText: 'Subject',
              prefixIcon: Icon(Icons.book),
            ),
            style: const TextStyle(color: AppTheme.white),
            items: _subjects.map((s) => DropdownMenuItem(value: s.id, child: Text(s.name))).toList(),
            onChanged: (v) => setState(() => _selectedSubject = v),
            validator: (v) => v == null ? 'Select a subject' : null,
          ),
          const SizedBox(height: 12),
          InkWell(
            onTap: _pickDate,
            borderRadius: BorderRadius.circular(12),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Due Date',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              child: Text(
                _dueDate != null
                    ? '${_dueDate!.day}/${_dueDate!.month}/${_dueDate!.year}'
                    : 'Select due date',
                style: TextStyle(
                  color: _dueDate != null ? AppTheme.white : AppTheme.white30,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('Questions',
              style: TextStyle(color: AppTheme.white, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppTheme.gold.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text('${_questions.length}',
                style: const TextStyle(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (_questions.isEmpty)
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Column(
                children: [
                  Icon(Icons.help_outline, color: AppTheme.white30, size: 40),
                  const SizedBox(height: 8),
                  Text('No questions yet. Tap the button below to add one.',
                    style: TextStyle(color: AppTheme.white50, fontSize: 13),
                    textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ...List.generate(_questions.length, (i) => _buildQuestionCard(i)),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _addQuestion,
            icon: const Icon(Icons.add),
            label: const Text('Add Question'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.gold,
              side: BorderSide(color: AppTheme.gold.withValues(alpha: 0.5)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(int index) {
    final q = _questions[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text('Question ${index + 1}',
                    style: const TextStyle(color: AppTheme.greenBright, fontSize: 12, fontWeight: FontWeight.w600)),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.redBright, size: 20),
                  onPressed: () => _removeQuestion(index),
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Remove question',
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: q.questionController,
              maxLines: 2,
              style: const TextStyle(color: AppTheme.white),
              decoration: const InputDecoration(
                labelText: 'Question Text',
                hintText: 'Enter the question...',
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: q.type,
                    dropdownColor: AppTheme.surfaceDark,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                    style: const TextStyle(color: AppTheme.white, fontSize: 13),
                    items: const [
                      DropdownMenuItem(value: 'short_answer', child: Text('Short Answer')),
                      DropdownMenuItem(value: 'multiple_choice', child: Text('Multiple Choice')),
                    ],
                    onChanged: (v) {
                      setState(() {
                        q.type = v!;
                        if (q.type == 'multiple_choice' && q.optionControllers.isEmpty) {
                          q.optionControllers.addAll([
                            TextEditingController(),
                            TextEditingController(),
                          ]);
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: q.marksController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: AppTheme.white),
                    decoration: const InputDecoration(
                      labelText: 'Marks',
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            if (q.type == 'multiple_choice') ...[
              const SizedBox(height: 12),
              const Text('Options:',
                style: TextStyle(color: AppTheme.white60, fontSize: 12, fontWeight: FontWeight.w500)),
              const SizedBox(height: 6),
              ...List.generate(q.optionControllers.length, (oi) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(String.fromCharCode(65 + oi),
                          style: const TextStyle(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextFormField(
                          controller: q.optionControllers[oi],
                          style: const TextStyle(color: AppTheme.white, fontSize: 13),
                          decoration: InputDecoration(
                            hintText: 'Option ${String.fromCharCode(65 + oi)}',
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      ),
                      if (q.optionControllers.length > 2)
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: AppTheme.redBright, size: 18),
                          onPressed: () => _removeOption(index, oi),
                          visualDensity: VisualDensity.compact,
                        ),
                    ],
                  ),
                );
              }),
              TextButton.icon(
                onPressed: () => _addOption(index),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Option', style: TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(foregroundColor: AppTheme.gold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          foregroundColor: AppTheme.white,
          disabledBackgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.5),
          disabledForegroundColor: AppTheme.white50,
        ),
        child: _isSubmitting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: AppTheme.white,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 20),
                  SizedBox(width: 8),
                  Text('Create Homework', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
      ),
    );
  }
}

class _QuestionEntry {
  final TextEditingController questionController;
  String type;
  final TextEditingController marksController;
  List<TextEditingController> optionControllers;

  _QuestionEntry({
    required this.questionController,
    required this.marksController,
    List<TextEditingController>? optionControllers,
  })  : type = 'short_answer',
        optionControllers = optionControllers ?? [];
}
