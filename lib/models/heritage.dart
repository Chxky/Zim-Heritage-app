class OralHistory {
  final String id;
  final String title;
  final String storyteller;
  final String community;
  final String language;
  final String category;
  final String summary;
  final String transcript;
  final String audioUrl;
  final int durationSeconds;
  final String dateRecorded;
  final String recordedBy;
  final List<String> tags;
  final bool verified;

  const OralHistory({
    required this.id, required this.title, required this.storyteller, required this.community,
    required this.language, required this.category, required this.summary, required this.transcript,
    this.audioUrl = '', required this.durationSeconds, required this.dateRecorded,
    required this.recordedBy, this.tags = const [], this.verified = false,
  });
}

class HeritageSite {
  final String id;
  final String name;
  final String location;
  final String province;
  final String description;
  final String significance;
  final String category;
  final double lat;
  final double lng;
  final List<String> images;
  final bool isUnesco;

  const HeritageSite({
    required this.id, required this.name, required this.location, required this.province,
    required this.description, required this.significance, required this.category,
    required this.lat, required this.lng, this.images = const [], this.isUnesco = false,
  });
}

class IndigenousKnowledge {
  final String id;
  final String title;
  final String category;
  final String community;
  final String description;
  final String application;
  final String curriculumLink;
  final bool preserved;

  const IndigenousKnowledge({
    required this.id, required this.title, required this.category, required this.community,
    required this.description, required this.application, this.curriculumLink = '', this.preserved = false,
  });
}

class CulturalPractice {
  final String id;
  final String name;
  final String community;
  final String category;
  final String description;
  final String significance;
  final String season;
  final bool isActive;

  const CulturalPractice({required this.id, required this.name, required this.community, required this.category, required this.description, required this.significance, this.season = '', this.isActive = true});
}

class VirtualTour {
  final String id;
  final String siteName;
  final String description;
  final String imageUrl;
  final String narrationUrl;
  final int durationSeconds;
  final List<String> highlights;

  const VirtualTour({required this.id, required this.siteName, required this.description, this.imageUrl = '', this.narrationUrl = '', required this.durationSeconds, this.highlights = const []});
}
