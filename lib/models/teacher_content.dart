class ContentTemplate {
  final String id;
  final String title;
  final String subjectId;
  final String gradeLevel;
  final String topic;
  final List<String> objectives;
  final List<ContentSection> sections;
  final int estimatedMinutes;
  final String authorId;
  final String authorName;
  final int downloads;
  final double rating;
  final bool isPublished;
  final bool isPremium;
  final double price;
  final DateTime createdAt;

  const ContentTemplate({
    required this.id, required this.title, required this.subjectId, required this.gradeLevel,
    required this.topic, required this.objectives, required this.sections,
    required this.estimatedMinutes, required this.authorId, required this.authorName,
    this.downloads = 0, this.rating = 0, this.isPublished = false, this.isPremium = false,
    this.price = 0, required this.createdAt,
  });
}

class ContentSection {
  final String heading;
  final String content;
  final List<String> activities;
  final String? resourceUrl;

  const ContentSection({required this.heading, required this.content, this.activities = const [], this.resourceUrl});
}

class LessonPlan {
  final String id;
  final String title;
  final String subjectId;
  final String gradeLevel;
  final int durationMinutes;
  final List<String> objectives;
  final List<String> materials;
  final List<LessonActivity> activities;
  final String assessmentMethod;
  final String authorName;

  const LessonPlan({
    required this.id, required this.title, required this.subjectId, required this.gradeLevel,
    required this.durationMinutes, required this.objectives, required this.materials,
    required this.activities, required this.assessmentMethod, required this.authorName,
  });
}

class LessonActivity {
  final int order;
  final String type;
  final String description;
  final int durationMinutes;
  final String? resourceUrl;

  const LessonActivity({required this.order, required this.type, required this.description, required this.durationMinutes, this.resourceUrl});
}

class CPDCourse {
  final String id;
  final String title;
  final String provider;
  final int hours;
  final String category;
  final double progress;
  final bool completed;
  final String? certificateId;

  const CPDCourse({required this.id, required this.title, required this.provider, required this.hours, required this.category, this.progress = 0, this.completed = false, this.certificateId});
}

class ResourceBundle {
  final String id;
  final String title;
  final String description;
  final String subjectId;
  final String gradeLevel;
  final List<String> fileTypes;
  final double rating;
  final int downloads;
  final bool isFree;

  const ResourceBundle({required this.id, required this.title, required this.description, required this.subjectId, required this.gradeLevel, required this.fileTypes, this.rating = 0, this.downloads = 0, this.isFree = true});
}
