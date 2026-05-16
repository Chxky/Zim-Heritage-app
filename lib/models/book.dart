class Book {
  final String id;
  final String subjectId;
  final String title;
  final String author;
  final String description;
  final String type;
  final String url;
  final List<String> gradeLevels;
  final List<String> topics;

  Book({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.author,
    required this.description,
    required this.type,
    required this.url,
    required this.gradeLevels,
    required this.topics,
  });

  factory Book.fromMap(Map<String, dynamic> map, String id) {
    return Book(
      id: id,
      subjectId: map['subjectId'] as String? ?? '',
      title: map['title'] as String? ?? '',
      author: map['author'] as String? ?? '',
      description: map['description'] as String? ?? '',
      type: map['type'] as String? ?? 'textbook',
      url: map['url'] as String? ?? '',
      gradeLevels: List<String>.from(map['gradeLevels'] as List? ?? []),
      topics: List<String>.from(map['topics'] as List? ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectId': subjectId,
      'title': title,
      'author': author,
      'description': description,
      'type': type,
      'url': url,
      'gradeLevels': gradeLevels,
      'topics': topics,
    };
  }
}
