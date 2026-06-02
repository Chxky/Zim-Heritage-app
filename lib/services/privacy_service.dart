import 'dart:convert';
import 'user_repository.dart';
import 'submission_repository.dart';
import 'progress_repository.dart';
import 'local_persistence_service.dart';
import 'di_container.dart';

class PrivacyService {
  static Future<Map<String, dynamic>> exportUserData(String userId) async {
    final user = await UserRepository.getUserByUid(userId);
    final submissions = await SubmissionRepository.getSubmissionsByStudent(userId);
    final progress = await ProgressRepository.getProgressForStudent(userId);

    return {
      'exportDate': DateTime.now().toIso8601String(),
      'user': user?.toMap(),
      'submissions': submissions.map((s) => s.toMap()).toList(),
      'progress': progress.map((p) => p.toMap()).toList(),
      'dataTypes': ['user_profile', 'submissions', 'progress_records'],
    };
  }

  static Future<void> deleteUserData(String userId) async {
    final persistence = sl<LocalPersistenceService>();
    await persistence.clearSession();
    await persistence.clearAll();
  }

  static String generateDataExportJson(Map<String, dynamic> data) {
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data);
  }
}
