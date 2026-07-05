class VisualAid {
  final String id;
  final String category;
  final String title;
  final String description;
  final String assetPath;
  final List<String> labels;
  final String gradeLevel;

  const VisualAid({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    this.assetPath = '',
    required this.labels,
    required this.gradeLevel,
  });
}

final List<VisualAid> ecdVisualAids = [
  // ECD A - Language
  const VisualAid(id: 'va_ecda_greeting', category: 'Language', title: 'Greetings Chart',
    description: 'Children learning to greet with a smile and wave',
    labels: ['Hello', 'Good morning', 'Wave', 'Smile'], gradeLevel: 'ECD A'),
  const VisualAid(id: 'va_ecda_body', category: 'Language', title: 'My Body Parts',
    description: 'Labeled diagram showing head, eyes, nose, mouth, ears, hands, feet',
    labels: ['Head', 'Eyes', 'Nose', 'Mouth', 'Ears', 'Hands', 'Feet'], gradeLevel: 'ECD A'),
  const VisualAid(id: 'va_ecda_family', category: 'Social', title: 'My Family',
    description: 'A happy family with mother, father, and children',
    labels: ['Mother', 'Father', 'Sister', 'Brother', 'Baby'], gradeLevel: 'ECD A'),
  const VisualAid(id: 'va_ecda_animals', category: 'Environmental Science', title: 'Farm Animals',
    description: 'Common farm animals with names',
    labels: ['Cow', 'Goat', 'Sheep', 'Chicken', 'Donkey'], gradeLevel: 'ECD A'),

  // ECD B - Pre-Reading
  const VisualAid(id: 'va_ecdb_alphabet', category: 'Language', title: 'Alphabet Chart',
    description: 'Letters A-Z with matching pictures (A for Apple, B for Ball, etc.)',
    labels: ['A', 'B', 'C', 'D', 'E', 'F', 'G'], gradeLevel: 'ECD B'),
  const VisualAid(id: 'va_ecdb_numbers', category: 'Numeracy', title: 'Numbers 1-20',
    description: 'Number chart showing numbers 1-20 with objects to count',
    labels: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'], gradeLevel: 'ECD B'),
  const VisualAid(id: 'va_ecdb_colours', category: 'Numeracy', title: 'Colours and Shapes',
    description: 'Basic colours (red, blue, yellow, green) and shapes (circle, square, triangle)',
    labels: ['Red', 'Blue', 'Yellow', 'Green', 'Circle', 'Square', 'Triangle'], gradeLevel: 'ECD B'),
  const VisualAid(id: 'va_ecdb_seasons', category: 'Environmental Science', title: 'Seasons of the Year',
    description: 'Rainy season, dry season, winter, summer with corresponding activities',
    labels: ['Rainy', 'Dry', 'Winter', 'Summer', 'Planting', 'Harvest'], gradeLevel: 'ECD B'),

  // Grade 1
  const VisualAid(id: 'va_g1_phonics', category: 'English', title: 'Phonics Sound Chart',
    description: 'Letter sounds with example words and pictures',
    labels: ['b - ball', 'c - cat', 'd - dog', 'f - fish', 'g - goat'], gradeLevel: 'Grade 1'),
  const VisualAid(id: 'va_g1_numbers', category: 'Mathematics', title: 'Numbers 1-100 Chart',
    description: 'Hundred chart showing all numbers from 1 to 100 in rows',
    labels: ['1-10', '11-20', '21-30', '31-40', '41-50', '51-100'], gradeLevel: 'Grade 1'),
  const VisualAid(id: 'va_g1_shapes', category: 'Mathematics', title: '2D Shapes',
    description: 'Basic shapes: circle, square, triangle, rectangle, oval, star, diamond',
    labels: ['Circle', 'Square', 'Triangle', 'Rectangle', 'Oval', 'Star', 'Diamond'], gradeLevel: 'Grade 1'),
  const VisualAid(id: 'va_g1_flag', category: 'Heritage', title: 'Zimbabwe National Flag',
    description: 'The Zimbabwe national flag with its colours and symbols explained',
    labels: ['Green', 'Gold', 'Red', 'Black', 'White', 'Zimbabwe Bird', 'Star'], gradeLevel: 'Grade 1'),

  // Grade 2
  const VisualAid(id: 'va_g2_multiplication', category: 'Mathematics', title: 'Multiplication Table 1-5',
    description: 'Multiplication tables with arrays showing groups of objects',
    labels: ['1x', '2x', '3x', '4x', '5x', 'Arrays'], gradeLevel: 'Grade 2'),
  const VisualAid(id: 'va_g2_community', category: 'Heritage', title: 'Community Helpers',
    description: 'Different community helpers: teacher, nurse, farmer, police officer, shopkeeper',
    labels: ['Teacher', 'Nurse', 'Farmer', 'Police', 'Shopkeeper'], gradeLevel: 'Grade 2'),
  const VisualAid(id: 'va_g2_plants', category: 'Science', title: 'Parts of a Plant',
    description: 'A flowering plant with labeled parts: roots, stem, leaves, flowers, fruit',
    labels: ['Roots', 'Stem', 'Leaves', 'Flower', 'Fruit'], gradeLevel: 'Grade 2'),
  const VisualAid(id: 'va_g2_time', category: 'Mathematics', title: 'Telling the Time',
    description: 'Analogue clock face showing hours and minutes',
    labels: ['Hour hand', 'Minute hand', 'o\'clock', 'half past', 'quarter past', 'quarter to'], gradeLevel: 'Grade 2'),
];

List<VisualAid> getVisualAidsForGrade(String gradeLevel) {
  return ecdVisualAids.where((v) => v.gradeLevel == gradeLevel).toList();
}

List<VisualAid> getVisualAidsForCategory(String category) {
  return ecdVisualAids.where((v) => v.category == category).toList();
}
