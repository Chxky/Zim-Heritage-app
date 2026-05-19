import '../models/heritage.dart';
import '../data/heritage_data.dart';

class HeritageService {
  static List<HeritageSite> searchSites(String query) {
    final q = query.toLowerCase();
    return getHeritageSites().where((s) =>
      s.name.toLowerCase().contains(q) ||
      s.location.toLowerCase().contains(q) ||
      s.province.toLowerCase().contains(q) ||
      s.category.toLowerCase().contains(q)
    ).toList();
  }

  static List<HeritageSite> sitesByProvince(String province) {
    return getHeritageSites().where((s) => s.province == province).toList();
  }

  static List<HeritageSite> unescoSites() {
    return getHeritageSites().where((s) => s.isUnesco).toList();
  }

  static List<OralHistory> oralHistoriesByLanguage(String language) {
    return getOralHistories().where((o) => o.language.toLowerCase() == language.toLowerCase()).toList();
  }

  static List<OralHistory> oralHistoriesByCategory(String category) {
    return getOralHistories().where((o) => o.category == category).toList();
  }

  static List<IndigenousKnowledge> knowledgeByCategory(String category) {
    return getIndigenousKnowledge().where((k) => k.category == category).toList();
  }

  static List<IndigenousKnowledge> preservedKnowledge() {
    return getIndigenousKnowledge().where((k) => k.preserved).toList();
  }

  static List<IndigenousKnowledge> unpreservedKnowledge() {
    return getIndigenousKnowledge().where((k) => !k.preserved).toList();
  }

  static List<CulturalPractice> activePractices() {
    return getCulturalPractices().where((p) => p.isActive).toList();
  }

  static List<VirtualTour> availableTours() => getVirtualTours();

  static Map<String, int> siteCountByProvince() {
    final map = <String, int>{};
    for (final s in getHeritageSites()) {
      map[s.province] = (map[s.province] ?? 0) + 1;
    }
    return map;
  }

  static List<HeritageSite> getSitesForCurriculum(String gradeLevel, String subject) {
    if (gradeLevel.startsWith('ECD') || gradeLevel.startsWith('Grade')) {
      return getHeritageSites().where((s) =>
        s.category == 'natural' || s.category == 'rock_art'
      ).toList();
    }
    if (subject.toLowerCase().contains('heritage') || subject.toLowerCase().contains('history')) {
      return getHeritageSites();
    }
    if (subject.toLowerCase().contains('science')) {
      return getHeritageSites().where((s) =>
        s.category == 'natural' || s.category == 'unesco_natural'
      ).toList();
    }
    return [];
  }
}
