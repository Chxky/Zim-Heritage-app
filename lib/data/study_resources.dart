import '../models/study_resource.dart';

final List<StudyResource> allStudyResources = [
  // ==========================================
  // MATHEMATICS (ZIMSEC & CAMBRIDGE)
  // ==========================================
  StudyResource(
    id: 'res_mat_01',
    subjectId: 'o1_mat',
    title: 'ZIMSEC & O-Level Mathematics Open Portal',
    description: 'Complete syllabus breakdown, algebra tutorials, geometry proofs, and exam revision guides.',
    url: 'https://openstax.org/subjects/math',
    category: 'open_textbook',
    provider: 'ZIMSEC Learning Portal & OpenStax',
    gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4'],
    curriculum: 'zimsec',
  ),
  StudyResource(
    id: 'res_mat_02',
    subjectId: 'o1_mat',
    title: 'Khan Academy Interactive Mathematics',
    description: 'Video lessons, step-by-step problem solvers, and practice exercises for Algebra, Geometry, and Trigonometry.',
    url: 'https://www.khanacademy.org/math',
    category: 'video_lesson',
    provider: 'Khan Academy',
    gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4'],
    curriculum: 'both',
  ),
  StudyResource(
    id: 'res_mat_03',
    subjectId: 'g1_mat',
    title: 'Primary Mathematics Open Learning Hub',
    description: 'Interactive counting games, addition/subtraction worksheets, and place value activities.',
    url: 'https://www.khanacademy.org/math/early-math',
    category: 'interactive_simulation',
    provider: 'UNESCO OER Hub',
    gradeLevels: ['Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5', 'Grade 6', 'Grade 7'],
    curriculum: 'both',
  ),
  StudyResource(
    id: 'res_mat_04',
    subjectId: 'a5_mat',
    title: 'Advanced Level Pure Mathematics & Statistics Portal',
    description: 'Calculus, differential equations, vectors, probability distributions, and past examination solutions.',
    url: 'https://ocw.mit.edu/courses/mathematics/',
    category: 'open_textbook',
    provider: 'MIT OpenCourseWare & Cambridge Portal',
    gradeLevels: ['Form 5', 'Form 6'],
    curriculum: 'both',
  ),
  StudyResource(
    id: 'res_mat_05',
    subjectId: 'cam_o3_mat',
    title: 'Cambridge IGCSE & O-Level Mathematics Revision',
    description: 'Targeted past paper solutions, mark scheme walkthroughs, and formula cheat sheets.',
    url: 'https://www.cambridgeinternational.org/programmes-and-qualifications/cambridge-igcse-mathematics-0580/',
    category: 'past_papers',
    provider: 'Cambridge Assessment International Education',
    gradeLevels: ['Form 3', 'Form 4'],
    curriculum: 'cambridge',
  ),

  // ==========================================
  // ENGLISH LANGUAGE & LITERATURE
  // ==========================================
  StudyResource(
    id: 'res_eng_01',
    subjectId: 'o1_eng',
    title: 'ZIMSEC English Language & Essay Writing Guide',
    description: 'Comprehension strategies, summary writing techniques, narrative composition tips, and grammar reference.',
    url: 'https://www.bbc.co.uk/bitesize/subjects/z3kw2hv',
    category: 'open_textbook',
    provider: 'ZIMSEC Open Portal & BBC Bitesize',
    gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4'],
    curriculum: 'both',
  ),
  StudyResource(
    id: 'res_eng_02',
    subjectId: 'a5_lit',
    title: 'African & World Literature Study Guides',
    description: 'In-depth analysis of African literature set books (Ngugi, Achebe, Marechera) and classical drama.',
    url: 'https://www.sparknotes.com/lit/',
    category: 'open_textbook',
    provider: 'African Literature Digital Archive',
    gradeLevels: ['Form 4', 'Form 5', 'Form 6'],
    curriculum: 'both',
  ),
  StudyResource(
    id: 'res_eng_03',
    subjectId: 'g1_eng',
    title: 'African Storybook Open Library',
    description: 'Multilingual storybooks in English, Shona, and Ndebele for early primary reading and fluency.',
    url: 'https://www.africanstorybook.org/',
    category: 'heritage_archive',
    provider: 'African Storybook Initiative',
    gradeLevels: ['Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5'],
    curriculum: 'both',
  ),

  // ==========================================
  // COMBINED SCIENCE, PHYSICS, CHEMISTRY & BIOLOGY
  // ==========================================
  StudyResource(
    id: 'res_sci_01',
    subjectId: 'o1_sci',
    title: 'PhET Interactive Science & Physics Simulations',
    description: 'Virtual labs for circuit building, chemical reactions, cell biology, and gravity experiments.',
    url: 'https://phet.colorado.edu/',
    category: 'interactive_simulation',
    provider: 'University of Colorado PhET',
    gradeLevels: ['Grade 6', 'Grade 7', 'Form 1', 'Form 2', 'Form 3', 'Form 4', 'Form 5', 'Form 6'],
    curriculum: 'both',
  ),
  StudyResource(
    id: 'res_sci_02',
    subjectId: 'o3_bio',
    title: 'OpenStax Biology & Combined Science Portal',
    description: 'Peer-reviewed open science textbooks covering genetics, human physiology, plant biology, and ecology.',
    url: 'https://openstax.org/details/books/concepts-biology',
    category: 'open_textbook',
    provider: 'OpenStax & ZIMSEC Science Hub',
    gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4', 'Form 5', 'Form 6'],
    curriculum: 'both',
  ),
  StudyResource(
    id: 'res_sci_03',
    subjectId: 'o3_che',
    title: 'Khan Academy Chemistry & Periodic Table Lab',
    description: 'Video tutorials on stoichiometry, chemical bonding, organic chemistry, and acid-base titrations.',
    url: 'https://www.khanacademy.org/science/chemistry',
    category: 'video_lesson',
    provider: 'Khan Academy',
    gradeLevels: ['Form 3', 'Form 4', 'Form 5', 'Form 6'],
    curriculum: 'both',
  ),
  StudyResource(
    id: 'res_sci_04',
    subjectId: 'o3_phy',
    title: 'Physics Classroom & Motion Simulations',
    description: 'Interactive physics tutorials covering mechanics, wave motion, electricity, and nuclear physics.',
    url: 'https://www.physicsclassroom.com/',
    category: 'interactive_simulation',
    provider: 'The Physics Classroom',
    gradeLevels: ['Form 3', 'Form 4', 'Form 5', 'Form 6'],
    curriculum: 'both',
  ),

  // ==========================================
  // HERITAGE-SOCIAL STUDIES & HISTORY
  // ==========================================
  StudyResource(
    id: 'res_his_01',
    subjectId: 'o1_his',
    title: 'Great Zimbabwe & African History Digital Archive',
    description: 'Primary sources, archaeological records, and historical essays on Great Zimbabwe, Rozvi, and Mutapa empires.',
    url: 'https://whc.unesco.org/en/list/364/',
    category: 'heritage_archive',
    provider: 'UNESCO World Heritage Archive & National Museums',
    gradeLevels: ['Grade 3', 'Grade 4', 'Grade 5', 'Grade 6', 'Grade 7', 'Form 1', 'Form 2', 'Form 3', 'Form 4', 'Form 5', 'Form 6'],
    curriculum: 'zimsec',
  ),
  StudyResource(
    id: 'res_his_02',
    subjectId: 'g1_hss',
    title: 'Heritage-Social Studies Primary Learning Portal',
    description: 'National symbols, Zimbabwean cultural practices, local government, and Ubuntu moral philosophy lessons.',
    url: 'https://mopse.ac.zw/',
    category: 'open_textbook',
    provider: 'Zimbabwe Ministry of Primary and Secondary Education',
    gradeLevels: ['Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5', 'Grade 6', 'Grade 7'],
    curriculum: 'zimsec',
  ),

  // ==========================================
  // GEOGRAPHY & ENVIRONMENTAL STUDIES
  // ==========================================
  StudyResource(
    id: 'res_geo_01',
    subjectId: 'o1_geo',
    title: 'National Geographic Education & GIS Map Portal',
    description: 'Interactive topographic maps, weather and climate monitoring, plate tectonics, and landform studies.',
    url: 'https://www.nationalgeographic.org/education/',
    category: 'interactive_simulation',
    provider: 'National Geographic Society',
    gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4', 'Form 5', 'Form 6'],
    curriculum: 'both',
  ),

  // ==========================================
  // INDIGENOUS LANGUAGES (SHONA & NDEBELE)
  // ==========================================
  StudyResource(
    id: 'res_sho_01',
    subjectId: 'g1_sho',
    title: 'ChiShona & IsiNdebele Cultural & Language Portal',
    description: 'Traditional proverbs (Tsumo/Izaga), riddles (Zvirahwe/Imfihlo), grammar rules, and oral folklore.',
    url: 'https://mopse.ac.zw/',
    category: 'heritage_archive',
    provider: 'African Languages Research Institute',
    gradeLevels: ['Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5', 'Grade 6', 'Grade 7', 'Form 1', 'Form 2', 'Form 3', 'Form 4'],
    curriculum: 'zimsec',
  ),

  // ==========================================
  // ICT & COMPUTER SCIENCE
  // ==========================================
  StudyResource(
    id: 'res_ict_01',
    subjectId: 'o1_ict',
    title: 'W3Schools & Python Programming for Computer Science',
    description: 'Hands-on coding lessons in Python, HTML/CSS, algorithm design, pseudocode, and database management.',
    url: 'https://www.w3schools.com/python/',
    category: 'interactive_simulation',
    provider: 'W3Schools & OpenCS Hub',
    gradeLevels: ['Grade 5', 'Grade 6', 'Grade 7', 'Form 1', 'Form 2', 'Form 3', 'Form 4', 'Form 5', 'Form 6'],
    curriculum: 'both',
  ),

  // ==========================================
  // AGRICULTURE & AGRIBUSINESS
  // ==========================================
  StudyResource(
    id: 'res_agr_01',
    subjectId: 'o1_agr',
    title: 'FAO Agribusiness & Tropical Agriculture Hub',
    description: 'Soil science, crop rotation, livestock husbandry, irrigation technologies, and sustainable farming.',
    url: 'https://www.fao.org/land-water/en/',
    category: 'open_textbook',
    provider: 'UN FAO & Ministry of Agriculture',
    gradeLevels: ['Grade 4', 'Grade 5', 'Grade 6', 'Grade 7', 'Form 1', 'Form 2', 'Form 3', 'Form 4'],
    curriculum: 'zimsec',
  ),

  // ==========================================
  // COMMERCE, ACCOUNTING & BUSINESS STUDIES
  // ==========================================
  StudyResource(
    id: 'res_bus_01',
    subjectId: 'o2_bus',
    title: 'Investopedia Business, Commerce & Accounting Guide',
    description: 'Financial literacy, ledger accounting, trade mechanisms, supply chain management, and entrepreneurship.',
    url: 'https://www.investopedia.com/financial-term-dictionary-4769738',
    category: 'open_textbook',
    provider: 'Investopedia Business Academy',
    gradeLevels: ['Form 2', 'Form 3', 'Form 4', 'Form 5', 'Form 6'],
    curriculum: 'both',
  ),

  // ==========================================
  // ECD (EARLY CHILDHOOD DEVELOPMENT)
  // ==========================================
  StudyResource(
    id: 'res_ecd_01',
    subjectId: 'ecda_lan',
    title: 'ECD Interactive Visual & Audio Learning Portal',
    description: 'Phonics songs, animal sounds, counting rhymes, and interactive coloring storybooks for ages 3-5.',
    url: 'https://www.starfall.com/h/index-kindergarten.php',
    category: 'interactive_simulation',
    provider: 'Starfall Early Education & UNESCO ECD',
    gradeLevels: ['ECD A', 'ECD B'],
    curriculum: 'both',
  ),
];

List<StudyResource> getResourcesForSubject(String subjectId, String gradeLevel) {
  final cleanSubject = subjectId.toLowerCase();
  final list = allStudyResources.where((r) {
    return (r.subjectId == cleanSubject || _subjectCategoryMatches(r.subjectId, cleanSubject)) &&
           (r.gradeLevels.isEmpty || r.gradeLevels.contains(gradeLevel) || _gradeMatchesCategory(r.gradeLevels, gradeLevel));
  }).toList();

  if (list.isNotEmpty) return list;

  // Fallback generic high-quality study resources for any subject
  return [
    StudyResource(
      id: '${subjectId}_gen_1',
      subjectId: subjectId,
      title: 'Open Educational Resources (OER) Learning Hub',
      description: 'Comprehensive open textbook modules, notes, and study guides curated for $gradeLevel.',
      url: 'https://openstax.org/subjects',
      category: 'open_textbook',
      provider: 'Global Open Educational Resources',
      gradeLevels: [gradeLevel],
    ),
    StudyResource(
      id: '${subjectId}_gen_2',
      subjectId: subjectId,
      title: 'ZIMSEC & National Curriculum Exam Revision Portal',
      description: 'Topic overviews, past paper practice questions, and exam preparation tips.',
      url: 'https://mopse.ac.zw/',
      category: 'past_papers',
      provider: 'Ministry of Education & Exam Portal',
      gradeLevels: [gradeLevel],
    ),
  ];
}

bool _subjectCategoryMatches(String rSubjectId, String targetSubjectId) {
  if (rSubjectId.contains('mat') && targetSubjectId.contains('mat')) return true;
  if (rSubjectId.contains('eng') && targetSubjectId.contains('eng')) return true;
  if (rSubjectId.contains('sci') && targetSubjectId.contains('sci')) return true;
  if (rSubjectId.contains('bio') && (targetSubjectId.contains('bio') || targetSubjectId.contains('sci'))) return true;
  if (rSubjectId.contains('che') && (targetSubjectId.contains('che') || targetSubjectId.contains('sci'))) return true;
  if (rSubjectId.contains('phy') && (targetSubjectId.contains('phy') || targetSubjectId.contains('sci'))) return true;
  if (rSubjectId.contains('his') && (targetSubjectId.contains('his') || targetSubjectId.contains('hss'))) return true;
  if (rSubjectId.contains('hss') && targetSubjectId.contains('hss')) return true;
  if (rSubjectId.contains('geo') && targetSubjectId.contains('geo')) return true;
  if (rSubjectId.contains('sho') && targetSubjectId.contains('sho')) return true;
  if (rSubjectId.contains('ict') && (targetSubjectId.contains('ict') || targetSubjectId.contains('cs'))) return true;
  if (rSubjectId.contains('agr') && targetSubjectId.contains('agr')) return true;
  if (rSubjectId.contains('bus') && (targetSubjectId.contains('bus') || targetSubjectId.contains('com') || targetSubjectId.contains('acc'))) return true;
  return false;
}

bool _gradeMatchesCategory(List<String> rGrades, String targetGrade) {
  if (targetGrade.startsWith('Grade') && rGrades.any((g) => g.startsWith('Grade'))) return true;
  if (targetGrade.startsWith('Form') && rGrades.any((g) => g.startsWith('Form'))) return true;
  if (targetGrade.startsWith('ECD') && rGrades.any((g) => g.startsWith('ECD'))) return true;
  return false;
}
