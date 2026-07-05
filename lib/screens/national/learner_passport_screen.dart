import 'package:flutter/material.dart';

import '../../models/learner_passport.dart';
import '../../services/passport_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

class LearnerPassportScreen extends StatelessWidget {
  final String studentName;
  final String gradeLevel;
  final String school;
  final String studentId;

  const LearnerPassportScreen({
    super.key, required this.studentName, required this.gradeLevel,
    required this.school, this.studentId = 'demo_001',
  });

  @override
  Widget build(BuildContext context) {
    final passport = PassportService.createPassport(
      studentId: studentId, studentName: studentName,
      gradeLevel: gradeLevel, school: school,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Learner Passport'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B5E20), Color(0xFF2E7D32), Color(0xFF4CAF50)],
              begin: Alignment.topLeft, end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            tooltip: 'Share Credentials',
            onPressed: () => _showShareDialog(context, passport),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPassportHeader(passport),
            const SizedBox(height: 20),
            _buildSectionTitle(Icons.verified, 'Academic Records'),
            const SizedBox(height: 8),
            ...passport.records.map((r) => _buildRecordCard(r)),
            const SizedBox(height: 20),
            _buildSectionTitle(Icons.emoji_events, 'Achievements'),
            const SizedBox(height: 8),
            _buildAchievements(passport.achievements),
            const SizedBox(height: 20),
            _buildSectionTitle(Icons.stars, 'Skills & Competencies'),
            const SizedBox(height: 8),
            ...passport.skills.map((s) => _buildSkillCard(s)),
            const SizedBox(height: 20),
            _buildSectionTitle(Icons.verified_user, 'Certificates'),
            const SizedBox(height: 8),
            ...passport.certificates.map((c) => _buildCertificateCard(c)),
          ],
        ),
      ),
    );
  }

  Widget _buildPassportHeader(LearnerPassport p) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: const Color(0xFF4CAF50).withValues(alpha: 0.2),
      boxShadow: [
        BoxShadow(color: const Color(0xFF4CAF50).withValues(alpha: 0.12), blurRadius: 24, offset: const Offset(0, 4)),
      ],
      child: Column(
        children: [
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                begin: Alignment.topLeft, end: Alignment.bottomRight),
              border: Border.all(color: AppTheme.gold, width: 2),
            ),
            child: Center(
              child: Text(p.studentName[0].toUpperCase(),
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ),
          ),
          const SizedBox(height: 12),
          Text(p.studentName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.white)),
          Text(p.gradeLevel, style: const TextStyle(fontSize: 14, color: AppTheme.gold)),
          const SizedBox(height: 4),
          Text(p.school, style: const TextStyle(fontSize: 12, color: AppTheme.white60)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF4CAF50).withValues(alpha: 0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code, size: 14, color: Color(0xFF4CAF50)),
                const SizedBox(width: 6),
                Text(p.passportHash,
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(AcademicRecord r) {
    final trend = r.average >= 75 ? AppTheme.greenBright : r.average >= 60 ? Colors.orange : Colors.red;
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: trend.withValues(alpha: 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: AppTheme.gold.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                child: Text('${r.year} ${r.term}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.gold)),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: trend.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(6)),
                child: Text(r.className, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: trend)),
              ),
              const Spacer(),
              Text('Avg: ${r.average.toStringAsFixed(0)}%',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: trend)),
            ],
          ),
          const SizedBox(height: 8),
          ...r.subjectScores.entries.map((e) => Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Row(
              children: [
                Expanded(child: Text(e.key, style: const TextStyle(fontSize: 11, color: AppTheme.white70))),
                Text('${e.value.toStringAsFixed(0)}%',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600,
                    color: e.value >= 70 ? AppTheme.greenBright : Colors.orange)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildAchievements(List<Achievement> achievements) {
    return Wrap(
      spacing: 8, runSpacing: 8,
      children: achievements.map((a) {
        Color catColor;
        IconData catIcon;
        switch (a.category) {
          case 'academic': catColor = Colors.blue; catIcon = Icons.school; break;
          case 'attendance': catColor = AppTheme.greenBright; catIcon = Icons.calendar_today; break;
          case 'stem': catColor = Colors.cyan; catIcon = Icons.science; break;
          case 'cultural': catColor = Colors.purple; catIcon = Icons.palette; break;
          default: catColor = AppTheme.gold; catIcon = Icons.star;
        }
        return Container(
          width: 160,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: catColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: catColor.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(catIcon, size: 14, color: catColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(a.category.toUpperCase(),
                      style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: catColor)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(a.title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppTheme.white)),
              Text(a.description, style: const TextStyle(fontSize: 9, color: AppTheme.white50)),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillCard(Skill s) {
    Color levelColor;
    switch (s.level) {
      case 'advanced': levelColor = AppTheme.greenBright; break;
      case 'intermediate': levelColor = Colors.orange; break;
      default: levelColor = Colors.blue;
    }
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(10),
      borderColor: levelColor.withValues(alpha: 0.12),
      child: Row(
        children: [
          Icon(Icons.stars, size: 18, color: levelColor),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(s.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.white)),
                Text('Verified by ${s.verifiedBy}', style: const TextStyle(fontSize: 10, color: AppTheme.white50)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: levelColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)),
            child: Text(s.level.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: levelColor)),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(Certificate c) {
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      borderColor: AppTheme.gold.withValues(alpha: 0.15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.verified_user, color: AppTheme.gold, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: AppTheme.white)),
                Text(c.issuer, style: const TextStyle(fontSize: 11, color: AppTheme.white60)),
                Text(c.verificationHash, style: const TextStyle(fontSize: 9, color: AppTheme.greenBright, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          const Icon(Icons.verified, size: 20, color: AppTheme.greenBright),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.gold, size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
      ],
    );
  }

  void _showShareDialog(BuildContext context, LearnerPassport passport) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16), alignment: Alignment.center,
              width: 40, height: 4,
              decoration: BoxDecoration(color: AppTheme.white30, borderRadius: BorderRadius.circular(2)),
            ),
            const Text('Share Credentials', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
            const SizedBox(height: 4),
            const Text('Choose who to share your passport with', style: TextStyle(fontSize: 13, color: AppTheme.white60)),
            const SizedBox(height: 20),
            _buildShareOption(Icons.business, 'Employer', 'Share verified credentials with potential employers'),
            _buildShareOption(Icons.school, 'College / University', 'Share academic records for applications'),
            _buildShareOption(Icons.account_balance, 'ZIMSEC', 'Verify results directly with ZIMSEC'),
            _buildShareOption(Icons.person, 'Parent / Guardian', 'Share progress with family members'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.gold, foregroundColor: AppTheme.black),
                child: const Text('Generate Share Link'),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(IconData icon, String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppTheme.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppTheme.gold, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.white)),
                    Text(description, style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
