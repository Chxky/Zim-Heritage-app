class PaymentPlan {
  final String id;
  final String name;
  final double price;
  final String currency;
  final String description;
  final List<String> features;
  final String duration;
  final bool isPopular;
  final int maxChildren;

  const PaymentPlan({
    required this.id,
    required this.name,
    required this.price,
    this.currency = 'USD',
    required this.description,
    required this.features,
    this.duration = 'monthly',
    this.isPopular = false,
    this.maxChildren = 1,
  });

  factory PaymentPlan.fromMap(Map<String, dynamic> map) {
    return PaymentPlan(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      currency: map['currency'] as String? ?? 'USD',
      description: map['description'] as String? ?? '',
      features: (map['features'] as List<dynamic>?)?.cast<String>() ?? [],
      duration: map['duration'] as String? ?? 'monthly',
      isPopular: map['isPopular'] as bool? ?? false,
      maxChildren: map['maxChildren'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'description': description,
      'features': features,
      'duration': duration,
      'isPopular': isPopular,
      'maxChildren': maxChildren,
    };
  }

  String get priceFormatted => price == 0 ? 'Free' : '\$${price.toStringAsFixed(0)}';
  String get periodText => price == 0 ? '' : '/$duration';

  static const List<PaymentPlan> defaultPlans = [
    PaymentPlan(
      id: 'free',
      name: 'Free',
      price: 0,
      description: 'Basic access to track your child\'s education',
      features: [
        'View your child\'s progress',
        'See homework assignments',
        'Basic school updates',
        '1 child profile',
      ],
      maxChildren: 1,
    ),
    PaymentPlan(
      id: 'basic',
      name: 'Basic',
      price: 4.99,
      description: 'Enhanced tracking for one child',
      features: [
        'Everything in Free',
        'Detailed progress reports',
        'Homework reminders',
        'AI-powered learning insights',
        'Up to 2 children',
      ],
      isPopular: false,
      maxChildren: 2,
    ),
    PaymentPlan(
      id: 'premium',
      name: 'Premium',
      price: 9.99,
      description: 'Full access for the whole family',
      features: [
        'Everything in Basic',
        'Unlimited children',
        'AI tutor access for children',
        'Parent-teacher messaging',
        'Monthly progress reports PDF',
        'Priority support',
      ],
      isPopular: true,
      maxChildren: 10,
    ),
    PaymentPlan(
      id: 'family',
      name: 'Family',
      price: 14.99,
      description: 'Complete family education package',
      features: [
        'Everything in Premium',
        'Up to 6 children',
        'Personalized learning plans',
        'Career guidance insights',
        'Exam preparation tools',
        'Exclusive webinars',
      ],
      isPopular: false,
      maxChildren: 6,
    ),
  ];

  PaymentPlan copyWith({
    String? id,
    String? name,
    double? price,
    String? currency,
    String? description,
    List<String>? features,
    String? duration,
    bool? isPopular,
    int? maxChildren,
  }) {
    return PaymentPlan(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      features: features ?? this.features,
      duration: duration ?? this.duration,
      isPopular: isPopular ?? this.isPopular,
      maxChildren: maxChildren ?? this.maxChildren,
    );
  }
}
