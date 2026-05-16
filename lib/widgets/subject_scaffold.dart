// widgets/subject_scaffold.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/subject_themes.dart';
import 'glass_card.dart';

class SubjectScaffold extends StatelessWidget {
  final Widget body;
  final String? subjectId;
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final Widget? bottomWidget;
  final bool showFlagBar;

  const SubjectScaffold({
    super.key,
    required this.body,
    this.subjectId,
    required this.title,
    this.actions,
    this.leading,
    this.bottomWidget,
    this.showFlagBar = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = subjectId != null
        ? SubjectThemes.forSubjectId(subjectId!) ?? SubjectThemes.getDefault()
        : SubjectThemes.getDefault();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: leading,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: theme.headerGradient),
        ),
        actions: actions,
      ),
      body: Container(
        decoration: BoxDecoration(gradient: theme.backgroundGradient),
        child: Column(
          children: [
            Expanded(child: body),
            ?bottomWidget,
            if (showFlagBar)
              const FlagBar(height: 3),
          ],
        ),
      ),
    );
  }
}

class SubjectBackground extends StatelessWidget {
  final Widget child;
  final String? subjectId;
  final Color? subjectColor;

  const SubjectBackground({
    super.key,
    required this.child,
    this.subjectId,
    this.subjectColor,
  });

  SubjectThemeData _getTheme() {
    if (subjectId != null) {
      return SubjectThemes.forSubjectId(subjectId!) ?? SubjectThemes.getDefault();
    }
    if (subjectColor != null) {
      return SubjectThemes.fromSubjectColor(subjectColor!);
    }
    return SubjectThemes.getDefault();
  }

  @override
  Widget build(BuildContext context) {
    final theme = _getTheme();
    return Container(
      decoration: BoxDecoration(gradient: theme.backgroundGradient),
      child: Stack(
        children: [
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.glowColor.withValues(alpha: 0.04),
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.glowColor.withValues(alpha: 0.03),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class SubjectHeaderCard extends StatelessWidget {
  final String subjectName;
  final String description;
  final String gradeLevel;
  final IconData icon;
  final String? subjectId;
  final Color? subjectColor;

  const SubjectHeaderCard({
    super.key,
    required this.subjectName,
    required this.description,
    required this.gradeLevel,
    required this.icon,
    this.subjectId,
    this.subjectColor,
  });

  SubjectThemeData _getTheme() {
    if (subjectId != null) {
      return SubjectThemes.forSubjectId(subjectId!) ?? SubjectThemes.getDefault();
    }
    if (subjectColor != null) {
      return SubjectThemes.fromSubjectColor(subjectColor!);
    }
    return SubjectThemes.getDefault();
  }

  @override
  Widget build(BuildContext context) {
    final theme = _getTheme();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.primaryColor.withValues(alpha: 0.15),
            theme.primaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.accentColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.glowColor.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: theme.accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.accentColor.withValues(alpha: 0.2)),
            ),
            child: Icon(icon, size: 28, color: theme.accentColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subjectName,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: theme.accentColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description,
                  style: const TextStyle(color: AppTheme.white70, fontSize: 13)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(gradeLevel,
                    style: const TextStyle(color: AppTheme.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubjectGlowBadge extends StatelessWidget {
  final String label;
  final Color? color;

  const SubjectGlowBadge({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.gold;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: c.withValues(alpha: 0.2)),
      ),
      child: Text(label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: c)),
    );
  }
}

class SubjectIconBox extends StatelessWidget {
  final IconData icon;
  final Color? color;
  final double size;

  const SubjectIconBox({
    super.key,
    required this.icon,
    this.color,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppTheme.gold;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: c.withValues(alpha: 0.15)),
      ),
      child: Icon(icon, color: c, size: size * 0.5),
    );
  }
}
