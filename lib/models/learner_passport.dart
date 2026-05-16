class LearnerPassport {
  final String studentId;
  final String studentName;
  final String gradeLevel;
  final String school;
  final String passportHash;
  final List<AcademicRecord> records;
  final List<Achievement> achievements;
  final List<Skill> skills;
  final List<Certificate> certificates;

  const LearnerPassport({
    required this.studentId, required this.studentName, required this.gradeLevel,
    required this.school, required this.passportHash, required this.records,
    required this.achievements, required this.skills, required this.certificates,
  });
}

class AcademicRecord {
  final String year;
  final String term;
  final String gradeLevel;
  final Map<String, double> subjectScores;
  final double average;
  final String className;

  const AcademicRecord({required this.year, required this.term, required this.gradeLevel, required this.subjectScores, required this.average, required this.className});
}

class Achievement {
  final String id;
  final String title;
  final String description;
  final String category;
  final String date;
  final String badgeUrl;

  const Achievement({required this.id, required this.title, required this.description, required this.category, required this.date, this.badgeUrl = ''});
}

class Skill {
  final String name;
  final String category;
  final String level;
  final String verifiedBy;

  const Skill({required this.name, required this.category, required this.level, required this.verifiedBy});
}

class Certificate {
  final String id;
  final String title;
  final String issuer;
  final String date;
  final String verificationHash;
  final String url;

  const Certificate({required this.id, required this.title, required this.issuer, required this.date, required this.verificationHash, this.url = ''});
}

class CredentialShare {
  final String passportHash;
  final String sharedWith;
  final DateTime sharedAt;
  final List<String> recordsShared;
  final bool expires;

  const CredentialShare({required this.passportHash, required this.sharedWith, required this.sharedAt, required this.recordsShared, this.expires = false});
}
