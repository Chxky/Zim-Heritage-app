class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String gradeLevel;
  final String school;
  final int age;
  final bool isVerified;
  final bool hasFacialRecognition;
  final String authProvider;
  final String? paymentPlanId;
  final String? paymentStatus;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionEndDate;
  final String curriculum;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.gradeLevel,
    required this.school,
    this.age = 0,
    this.isVerified = false,
    this.hasFacialRecognition = false,
    this.authProvider = 'email',
    this.paymentPlanId,
    this.paymentStatus,
    this.subscriptionStartDate,
    this.subscriptionEndDate,
    this.curriculum = 'zimsec',
  });

  bool get isPaymentActive => paymentStatus == 'active';
  bool get hasActiveSubscription => paymentPlanId != null && paymentPlanId != 'free' && isPaymentActive;

  factory User.fromMap(Map<String, dynamic> map, String id) {
    return User(
      id: id,
      name: map['name'] as String? ?? '',
      email: map['email'] as String? ?? '',
      role: map['role'] as String? ?? 'student',
      gradeLevel: map['gradeLevel'] as String? ?? '',
      school: map['school'] as String? ?? '',
      age: map['age'] as int? ?? 0,
      isVerified: map['isVerified'] as bool? ?? false,
      hasFacialRecognition: map['hasFacialRecognition'] as bool? ?? false,
      authProvider: map['authProvider'] as String? ?? 'email',
      paymentPlanId: map['paymentPlanId'] as String?,
      paymentStatus: map['paymentStatus'] as String?,
      subscriptionStartDate: _parseDate(map['subscriptionStartDate']),
      subscriptionEndDate: _parseDate(map['subscriptionEndDate']),
      curriculum: map['curriculum'] as String? ?? 'zimsec',
    );
  }

  static DateTime? _parseDate(dynamic val) {
    if (val == null) return null;
    if (val is DateTime) return val;
    if (val is String) return DateTime.tryParse(val);
    try {
      return (val as dynamic).toDate();
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'gradeLevel': gradeLevel,
      'school': school,
      'age': age,
      'isVerified': isVerified,
      'hasFacialRecognition': hasFacialRecognition,
      'authProvider': authProvider,
      'paymentPlanId': paymentPlanId,
      'paymentStatus': paymentStatus,
      'subscriptionStartDate': subscriptionStartDate?.toIso8601String(),
      'subscriptionEndDate': subscriptionEndDate?.toIso8601String(),
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
    bool? isVerified,
    bool? hasFacialRecognition,
    String? authProvider,
    String? paymentPlanId,
    String? paymentStatus,
    DateTime? subscriptionStartDate,
    DateTime? subscriptionEndDate,
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
      isVerified: isVerified ?? this.isVerified,
      hasFacialRecognition: hasFacialRecognition ?? this.hasFacialRecognition,
      authProvider: authProvider ?? this.authProvider,
      paymentPlanId: paymentPlanId ?? this.paymentPlanId,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      subscriptionStartDate: subscriptionStartDate ?? this.subscriptionStartDate,
      subscriptionEndDate: subscriptionEndDate ?? this.subscriptionEndDate,
      curriculum: curriculum ?? this.curriculum,
    );
  }
}
