class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String gradeLevel;
  final String school;
  final int age;
  final String? dateOfBirth;
  final bool isAgeVerified;
  final String? guardianName;
  final String? guardianContact;
  final bool isVerified;
  final bool hasFacialRecognition;
  final String authProvider;
  final String? schoolMotto;
  final String curriculum;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.gradeLevel,
    required this.school,
    this.age = 0,
    this.dateOfBirth,
    this.isAgeVerified = false,
    this.guardianName,
    this.guardianContact,
    this.isVerified = false,
    this.hasFacialRecognition = false,
    this.authProvider = 'email',
    this.schoolMotto,
    this.curriculum = 'zimsec',
  });


  factory User.fromMap(Map<String, dynamic> map, String id) {
    final mapId = map['id'] as String?;
    final email = (map['email'] as String? ?? '').toLowerCase();
    final effectiveId = (mapId != null && mapId.isNotEmpty)
        ? mapId
        : ((email.contains('mazvita') || id.contains('mazvita')) ? 'student_mazvita' : id);
    return User(
      id: effectiveId,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      role: map['role'] as String? ?? 'student',
      gradeLevel: map['gradeLevel'] as String? ?? '',
      school: map['school'] as String? ?? '',
      age: (map['age'] as num?)?.toInt() ?? 0,
      dateOfBirth: map['dateOfBirth'] as String?,
      isAgeVerified: map['isAgeVerified'] as bool? ?? (map['age'] != null && (map['age'] as num) > 0),
      guardianName: map['guardianName'] as String?,
      guardianContact: map['guardianContact'] as String?,
      isVerified: map['isVerified'] as bool? ?? false,
      hasFacialRecognition: map['hasFacialRecognition'] as bool? ?? false,
      authProvider: map['authProvider'] as String? ?? 'email',
      schoolMotto: map['schoolMotto'] as String?,
      curriculum: map['curriculum'] as String? ?? 'zimsec',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'gradeLevel': gradeLevel,
      'school': school,
      'age': age,
      'dateOfBirth': dateOfBirth,
      'isAgeVerified': isAgeVerified,
      'guardianName': guardianName,
      'guardianContact': guardianContact,
      'isVerified': isVerified,
      'hasFacialRecognition': hasFacialRecognition,
      'authProvider': authProvider,
      'schoolMotto': schoolMotto,
      'curriculum': curriculum,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? gradeLevel,
    String? school,
    int? age,
    String? dateOfBirth,
    bool? isAgeVerified,
    String? guardianName,
    String? guardianContact,
    bool? isVerified,
    bool? hasFacialRecognition,
    String? authProvider,
    String? schoolMotto,
    String? curriculum,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      school: school ?? this.school,
      age: age ?? this.age,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isAgeVerified: isAgeVerified ?? this.isAgeVerified,
      guardianName: guardianName ?? this.guardianName,
      guardianContact: guardianContact ?? this.guardianContact,
      isVerified: isVerified ?? this.isVerified,
      hasFacialRecognition: hasFacialRecognition ?? this.hasFacialRecognition,
      authProvider: authProvider ?? this.authProvider,
      schoolMotto: schoolMotto ?? this.schoolMotto,
      curriculum: curriculum ?? this.curriculum,
    );
  }
}
