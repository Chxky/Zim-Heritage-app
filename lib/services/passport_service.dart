import 'dart:convert';
import '../models/learner_passport.dart';

class PassportService {
  static String generatePassportHash(String studentId, String name) {
    final raw = '$studentId|$name|${DateTime.now().millisecondsSinceEpoch}';
    final bytes = utf8.encode(raw);
    final hash = bytes.fold<int>(0, (h, b) => ((h << 5) - h) + b);
    return 'ZIM-P-${hash.abs().toRadixString(16).toUpperCase().padLeft(8, '0')}';
  }

  static String generateVerificationHash(String id, String title, String issuer) {
    final raw = '$id|$title|$issuer|${DateTime.now().year}';
    final bytes = utf8.encode(raw);
    final hash = bytes.fold<int>(0, (h, b) => ((h << 5) - h) + b);
    return 'ZIM-V-${hash.abs().toRadixString(16).toUpperCase().padLeft(8, '0')}';
  }

  static LearnerPassport createPassport({
    required String studentId,
    required String studentName,
    required String gradeLevel,
    required String school,
  }) {
    return LearnerPassport(
      studentId: studentId,
      studentName: studentName,
      gradeLevel: gradeLevel,
      school: school,
      passportHash: generatePassportHash(studentId, studentName),
      records: _generateDemoRecords(studentName),
      achievements: _demoAchievements,
      skills: _demoSkills,
      certificates: _demoCertificates,
    );
  }

  static List<AcademicRecord> _generateDemoRecords(String name) {
    return [
      AcademicRecord(year: '2023', term: 'Term 1', gradeLevel: 'Grade 6', subjectScores: {'English': 72.0, 'Mathematics': 65.0, 'Science': 78.0, 'Heritage': 81.0, 'Shona': 70.0}, average: 73.2, className: '6A'),
      AcademicRecord(year: '2023', term: 'Term 2', gradeLevel: 'Grade 6', subjectScores: {'English': 75.0, 'Mathematics': 68.0, 'Science': 80.0, 'Heritage': 83.0, 'Shona': 72.0}, average: 75.6, className: '6A'),
      AcademicRecord(year: '2023', term: 'Term 3', gradeLevel: 'Grade 6', subjectScores: {'English': 76.0, 'Mathematics': 71.0, 'Science': 82.0, 'Heritage': 85.0, 'Shona': 74.0}, average: 77.6, className: '6A'),
      AcademicRecord(year: '2024', term: 'Term 1', gradeLevel: 'Grade 7', subjectScores: {'English': 78.0, 'Mathematics': 73.0, 'Science': 84.0, 'Heritage': 86.0, 'Shona': 75.0}, average: 79.2, className: '7A'),
      AcademicRecord(year: '2024', term: 'Term 2', gradeLevel: 'Grade 7', subjectScores: {'English': 80.0, 'Mathematics': 75.0, 'Science': 85.0, 'Heritage': 88.0, 'Shona': 76.0}, average: 80.8, className: '7A'),
    ];
  }

  static const _demoAchievements = [
    Achievement(id: 'ach_1', title: 'Top Performer - Heritage Studies', description: 'Highest score in Heritage Studies for Term 2, 2024', category: 'academic', date: '2024-08-15'),
    Achievement(id: 'ach_2', title: 'Perfect Attendance', description: '100% attendance for Term 1 and Term 2, 2024', category: 'attendance', date: '2024-07-01'),
    Achievement(id: 'ach_3', title: 'Science Fair Winner', description: 'First place in school science fair for renewable energy project', category: 'stem', date: '2024-06-20'),
    Achievement(id: 'ach_4', title: 'Cultural Ambassador', description: 'Represented school in national traditional dance competition', category: 'cultural', date: '2024-05-10'),
    Achievement(id: 'ach_5', title: 'Literacy Champion', description: 'Read 30 books in one term, highest in grade', category: 'academic', date: '2024-04-01'),
  ];

  static const _demoSkills = [
    Skill(name: 'Public Speaking', category: 'communication', level: 'advanced', verifiedBy: 'English Teacher'),
    Skill(name: 'Traditional Dance', category: 'cultural', level: 'intermediate', verifiedBy: 'VPA Teacher'),
    Skill(name: 'Digital Literacy', category: 'technology', level: 'intermediate', verifiedBy: 'ICT Teacher'),
    Skill(name: 'Creative Writing', category: 'literacy', level: 'advanced', verifiedBy: 'English Teacher'),
    Skill(name: 'Leadership', category: 'life_skills', level: 'intermediate', verifiedBy: 'Class Teacher'),
  ];

  static const _demoCertificates = [
    Certificate(id: 'cert_1', title: 'ZIMSEC Grade 7 Certificate', issuer: 'ZIMSEC', date: '2025-01-15', verificationHash: 'ZIM-V-A3F9C1D2'),
    Certificate(id: 'cert_2', title: 'ICT Literacy Certificate', issuer: 'Ministry of Education', date: '2024-11-20', verificationHash: 'ZIM-V-B7E2D4F5'),
  ];

  static bool verifyCertificate(String hash) {
    return hash.startsWith('ZIM-V-') && hash.length == 16;
  }

  static CredentialShare createShareLink(LearnerPassport passport, String sharedWith, List<String> records) {
    return CredentialShare(
      passportHash: passport.passportHash,
      sharedWith: sharedWith,
      sharedAt: DateTime.now(),
      recordsShared: records,
    );
  }
}
