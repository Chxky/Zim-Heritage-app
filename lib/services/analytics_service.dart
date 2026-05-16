import '../models/national_models.dart';
import '../data/national_data.dart';

class AnalyticsService {
  static int totalSchools() {
    var count = 0;
    for (final p in getProvinces()) {
      for (final d in p.districts) {
        count += d.schools.length;
      }
    }
    return count * 120;
  }

  static int totalStudents() => 4800000;

  static int totalTeachers() {
    var count = 0;
    for (final p in getProvinces()) {
      for (final d in p.districts) {
        count += d.schools.fold<int>(0, (sum, s) => sum + s.teachers);
      }
    }
    return count * 100;
  }

  static double nationalPassRate() {
    var total = 0.0;
    var count = 0;
    for (final p in getProvinces()) {
      for (final d in p.districts) {
        for (final s in d.schools) {
          total += s.passRate;
          count++;
        }
      }
    }
    return count > 0 ? (total / count) : 0;
  }

  static double nationalAttendanceRate() {
    var total = 0.0;
    var count = 0;
    for (final p in getProvinces()) {
      for (final d in p.districts) {
        for (final s in d.schools) {
          total += s.attendanceRate;
          count++;
        }
      }
    }
    return count > 0 ? (total / count) : 0;
  }

  static double schoolsWithInternet() {
    var total = 0;
    var withInternet = 0;
    for (final p in getProvinces()) {
      for (final d in p.districts) {
        for (final s in d.schools) {
          total++;
          if (s.hasInternet) withInternet++;
        }
      }
    }
    return total > 0 ? (withInternet / total * 100) : 0;
  }

  static List<School> getLowPerformingSchools(double threshold) {
    final low = <School>[];
    for (final p in getProvinces()) {
      for (final d in p.districts) {
        low.addAll(d.schools.where((s) => s.passRate < threshold));
      }
    }
    return low;
  }

  static Map<String, double> passRateByProvince() {
    final map = <String, List<double>>{};
    for (final p in getProvinces()) {
      for (final d in p.districts) {
        for (final s in d.schools) {
          map.putIfAbsent(p.name, () => []);
          map[p.name]!.add(s.passRate);
        }
      }
    }
    return map.map((k, v) => MapEntry(k, v.reduce((a, b) => a + b) / v.length));
  }

  static List<School> schoolsNeedingInfrastructure() {
    final needing = <School>[];
    for (final p in getProvinces()) {
      for (final d in p.districts) {
        needing.addAll(d.schools.where((s) => !s.hasInternet || !s.hasElectricity || !s.hasWater));
      }
    }
    return needing;
  }
}
