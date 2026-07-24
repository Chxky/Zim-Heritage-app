class StudyResource {
  final String id;
  final String subjectId;
  final String title;
  final String description;
  final String url;
  final String category; // 'open_textbook', 'video_lesson', 'interactive_simulation', 'past_papers', 'heritage_archive'
  final String provider;
  final List<String> gradeLevels;
  final String curriculum; // 'zimsec', 'cambridge', 'both'

  StudyResource({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.description,
    required this.url,
    required this.category,
    required this.provider,
    required this.gradeLevels,
    this.curriculum = 'both',
  });

  factory StudyResource.fromMap(Map<String, dynamic> map, String id) {
    return StudyResource(
      id: id,
      subjectId: map['subjectId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      description: map['description'] as String? ?? '',
      url: map['url'] as String? ?? '',
      category: map['category'] as String? ?? 'open_textbook',
      provider: map['provider'] as String? ?? 'Open Educational Resources',
      gradeLevels: List<String>.from(map['gradeLevels'] as List? ?? []),
      curriculum: map['curriculum'] as String? ?? 'both',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'subjectId': subjectId,
      'title': title,
      'description': description,
      'url': url,
      'category': category,
      'provider': provider,
      'gradeLevels': gradeLevels,
      'curriculum': curriculum,
    };
  }
}
