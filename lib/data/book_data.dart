import '../models/book.dart';

final List<Book> allBooks = [
  // ===== ENGLISH LANGUAGE =====
  Book(id: 'eng_step_1', subjectId: 'g1_eng', title: 'Step In English Grade 1', author: 'Zimbabwe Ministry of Education', description: 'Foundational English textbook with phonics, reading passages, and writing exercises for Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: ['Phonics and Letter Sounds', 'Reading Readiness', 'Writing Skills']),
  Book(id: 'eng_step_2', subjectId: 'g2_eng', title: 'Step In English Grade 2', author: 'Zimbabwe Ministry of Education', description: 'English language development with comprehension passages, grammar exercises, and creative writing prompts', type: 'textbook', url: '', gradeLevels: ['Grade 2'], topics: []),
  Book(id: 'eng_step_3', subjectId: 'g3_eng', title: 'Step In English Grade 3', author: 'Zimbabwe Ministry of Education', description: 'Advanced primary English with paragraph writing, grammar, and public speaking activities', type: 'textbook', url: '', gradeLevels: ['Grade 3'], topics: []),
  Book(id: 'eng_step_4', subjectId: 'g4_eng', title: 'Step In English Grade 4', author: 'Zimbabwe Ministry of Education', description: 'Composition writing, reading fluency, comprehension strategies and vocabulary building', type: 'textbook', url: '', gradeLevels: ['Grade 4'], topics: []),
  Book(id: 'eng_step_5', subjectId: 'g5_eng', title: 'Step In English Grade 5', author: 'Zimbabwe Ministry of Education', description: 'Essay writing, literary analysis, advanced grammar and persuasive communication', type: 'textbook', url: '', gradeLevels: ['Grade 5'], topics: []),
  Book(id: 'eng_step_6', subjectId: 'g6_eng', title: 'Step In English Grade 6', author: 'Zimbabwe Ministry of Education', description: 'Critical reading, research skills, debate techniques and advanced composition', type: 'textbook', url: '', gradeLevels: ['Grade 6'], topics: []),
  Book(id: 'eng_step_7', subjectId: 'g7_eng', title: 'Step In English Grade 7', author: 'Zimbabwe Ministry of Education', description: 'Exam preparation with literary criticism, advanced writing and media literacy', type: 'textbook', url: '', gradeLevels: ['Grade 7'], topics: []),
  Book(id: 'eng_o1', subjectId: 'o1_eng', title: 'New Express English Form 1', author: 'College Press Publishers', description: 'Comprehensive O-Level English covering grammar, composition, literature and oral skills for Form 1', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: ['Grammar and Structure', 'Composition Writing', 'Comprehension']),
  Book(id: 'eng_o2', subjectId: 'o2_eng', title: 'New Express English Form 2', author: 'College Press Publishers', description: 'Advanced English with critical analysis, essay writing and research skills', type: 'textbook', url: '', gradeLevels: ['Form 2'], topics: []),
  Book(id: 'eng_o3', subjectId: 'o3_eng', title: 'New Express English Form 3', author: 'College Press Publishers', description: 'Exam-focused English with comprehension, summary and literary analysis', type: 'textbook', url: '', gradeLevels: ['Form 3'], topics: []),
  Book(id: 'eng_o4', subjectId: 'o4_eng', title: 'New Express English Form 4', author: 'College Press Publishers', description: 'O-Level exam preparation with past papers, exam techniques and revision exercises', type: 'textbook', url: '', gradeLevels: ['Form 4'], topics: []),
  Book(id: 'eng_read_1', subjectId: 'o1_eng', title: 'The River Between', author: 'Ngugi wa Thiong\'o', description: 'Set book novel exploring themes of culture, tradition and change in colonial Kenya', type: 'set_book', url: '', gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4'], topics: []),
  Book(id: 'eng_read_2', subjectId: 'o1_eng', title: 'Animal Farm', author: 'George Orwell', description: 'Political allegory exploring power, corruption and revolution through a farmyard tale', type: 'set_book', url: '', gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4'], topics: []),
  Book(id: 'eng_grammar', subjectId: 'o1_eng', title: 'English Grammar in Use', author: 'Raymond Murphy', description: 'Comprehensive grammar reference with clear explanations and practice exercises for intermediate learners', type: 'reference', url: '', gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4', 'Form 5', 'Form 6'], topics: []),
  Book(id: 'eng_a5', subjectId: 'a5_lit', title: 'A-Level English Literature Guide', author: 'ZIMSEC', description: 'Advanced literature covering poetry, prose, drama and literary criticism for Forms 5 & 6', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== MATHEMATICS =====
  Book(id: 'mat_g1', subjectId: 'g1_mat', title: 'Step In Mathematics Grade 1', author: 'Zimbabwe Ministry of Education', description: 'Early mathematics with number recognition, counting, shapes and basic operations', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: []),
  Book(id: 'mat_g2', subjectId: 'g2_mat', title: 'Step In Mathematics Grade 2', author: 'Zimbabwe Ministry of Education', description: 'Addition, subtraction, multiplication basics, place value and measurement', type: 'textbook', url: '', gradeLevels: ['Grade 2'], topics: []),
  Book(id: 'mat_g3', subjectId: 'g3_mat', title: 'Step In Mathematics Grade 3', author: 'Zimbabwe Ministry of Education', description: 'Multiplication, division, fractions, time, money and data handling', type: 'textbook', url: '', gradeLevels: ['Grade 3'], topics: []),
  Book(id: 'mat_g4', subjectId: 'g4_mat', title: 'Step In Mathematics Grade 4', author: 'Zimbabwe Ministry of Education', description: 'Decimals, percentages, geometry, area, perimeter and problem-solving', type: 'textbook', url: '', gradeLevels: ['Grade 4'], topics: []),
  Book(id: 'mat_g5', subjectId: 'g5_mat', title: 'Step In Mathematics Grade 5', author: 'Zimbabwe Ministry of Education', description: 'Ratio, proportion, introductory algebra, angles, graphs and statistics', type: 'textbook', url: '', gradeLevels: ['Grade 5'], topics: []),
  Book(id: 'mat_g6', subjectId: 'g6_mat', title: 'Step In Mathematics Grade 6', author: 'Zimbabwe Ministry of Education', description: 'Advanced algebra, probability, transformations and mathematical modeling', type: 'textbook', url: '', gradeLevels: ['Grade 6'], topics: []),
  Book(id: 'mat_g7', subjectId: 'g7_mat', title: 'Step In Mathematics Grade 7', author: 'Zimbabwe Ministry of Education', description: 'Pre-algebra, geometry proofs, statistics and exam-level problem solving', type: 'textbook', url: '', gradeLevels: ['Grade 7'], topics: []),
  Book(id: 'mat_o1', subjectId: 'o1_mat', title: 'Complete Mathematics for Form 1', author: 'College Press Publishers', description: 'Comprehensive Form 1 mathematics covering number theory, algebra, geometry and trigonometry', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: ['Number Theory', 'Algebra', 'Geometry']),
  Book(id: 'mat_o2', subjectId: 'o2_mat', title: 'Complete Mathematics for Form 2', author: 'College Press Publishers', description: 'Sets, relations, functions, matrices and advanced problem-solving for Form 2', type: 'textbook', url: '', gradeLevels: ['Form 2'], topics: []),
  Book(id: 'mat_o3', subjectId: 'o3_mat', title: 'Complete Mathematics for Form 3', author: 'College Press Publishers', description: 'Introductory calculus, coordinate geometry, transformations and statistics', type: 'textbook', url: '', gradeLevels: ['Form 3'], topics: []),
  Book(id: 'mat_o4', subjectId: 'o4_mat', title: 'Complete Mathematics for Form 4', author: 'College Press Publishers', description: 'O-Level mathematics revision with comprehensive coverage and exam preparation', type: 'textbook', url: '', gradeLevels: ['Form 4'], topics: []),
  Book(id: 'mat_a5', subjectId: 'a5_mat', title: 'Advanced Level Mathematics: Pure Mathematics', author: 'Cambridge University Press', description: 'Pure mathematics covering calculus, algebra, trigonometry and vectors for Form 5', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== SCIENCE =====
  Book(id: 'sci_g1', subjectId: 'g1_sct', title: 'Science and Technology Grade 1', author: 'Zimbabwe Ministry of Education', description: 'Exploring the environment, basic scientific concepts and technology awareness', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: []),
  Book(id: 'sci_g3', subjectId: 'g3_sci', title: 'General Science Grade 3', author: 'Zimbabwe Ministry of Education', description: 'Plants, animals, energy, water cycle and environmental conservation', type: 'textbook', url: '', gradeLevels: ['Grade 3'], topics: []),
  Book(id: 'sci_g4', subjectId: 'g4_sci', title: 'General Science Grade 4', author: 'Zimbabwe Ministry of Education', description: 'Human body, ecosystems, forces, light, sound and scientific investigations', type: 'textbook', url: '', gradeLevels: ['Grade 4'], topics: []),
  Book(id: 'sci_g5', subjectId: 'g5_sci', title: 'General Science Grade 5', author: 'Zimbabwe Ministry of Education', description: 'Matter, energy systems, electricity, astronomy and scientific methods', type: 'textbook', url: '', gradeLevels: ['Grade 5'], topics: []),
  Book(id: 'sci_g6', subjectId: 'g6_sci', title: 'General Science Grade 6', author: 'Zimbabwe Ministry of Education', description: 'Chemistry basics, genetics, ecology, technology innovations and space science', type: 'textbook', url: '', gradeLevels: ['Grade 6'], topics: []),
  Book(id: 'sci_g7', subjectId: 'g7_sci', title: 'General Science Grade 7', author: 'Zimbabwe Ministry of Education', description: 'Integrated science, environmental chemistry and scientific literacy', type: 'textbook', url: '', gradeLevels: ['Grade 7'], topics: []),
  Book(id: 'sci_o1', subjectId: 'o1_sci', title: 'Combined Science Form 1', author: 'Longman Zimbabwe', description: 'Integrated biology, chemistry and physics fundamentals for Form 1 Combined Science', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: ['Scientific Method', 'Cell Biology', 'Matter and Energy']),
  Book(id: 'sci_o2', subjectId: 'o2_sci', title: 'Combined Science Form 2', author: 'Longman Zimbabwe', description: 'Cell biology, chemical reactions, forces and energy for Form 2', type: 'textbook', url: '', gradeLevels: ['Form 2'], topics: []),
  Book(id: 'bio_o3', subjectId: 'o3_bio', title: 'Biology Form 3', author: 'College Press Publishers', description: 'Cell biology, genetics, ecology, human anatomy and physiology for O-Level Biology', type: 'textbook', url: '', gradeLevels: ['Form 3'], topics: []),
  Book(id: 'che_o3', subjectId: 'o3_che', title: 'Chemistry Form 3', author: 'College Press Publishers', description: 'Atomic structure, bonding, organic chemistry and chemical analysis for O-Level Chemistry', type: 'textbook', url: '', gradeLevels: ['Form 3'], topics: []),
  Book(id: 'phy_o3', subjectId: 'o3_phy', title: 'Physics Form 3', author: 'College Press Publishers', description: 'Mechanics, waves, electricity, magnetism and nuclear physics for O-Level Physics', type: 'textbook', url: '', gradeLevels: ['Form 3'], topics: []),
  Book(id: 'bio_o4', subjectId: 'o4_bio', title: 'Biology Form 4', author: 'College Press Publishers', description: 'O-Level Biology revision with practical skills and exam techniques', type: 'textbook', url: '', gradeLevels: ['Form 4'], topics: []),
  Book(id: 'bio_a5', subjectId: 'a5_bio', title: 'Advanced Level Biology', author: 'Cambridge University Press', description: 'Molecular biology, genetics, ecology and physiology for Form 5 Biology', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),
  Book(id: 'che_a5', subjectId: 'a5_che', title: 'Advanced Level Chemistry', author: 'Cambridge University Press', description: 'Physical, inorganic and organic chemistry for Form 5', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),
  Book(id: 'phy_a5', subjectId: 'a5_phy', title: 'Advanced Level Physics', author: 'Cambridge University Press', description: 'Mechanics, fields, thermodynamics and quantum physics for Form 5', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== SHONA/NDEBELE =====
  Book(id: 'sho_g1', subjectId: 'g1_sho', title: 'ChiShona Gwaro 1', author: 'Zimbabwe Ministry of Education', description: 'Foundational Shona literacy: reading, writing and oral traditions for Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1', 'Grade 2', 'Grade 3'], topics: []),
  Book(id: 'ndb_g1', subjectId: 'g1_sho', title: 'IsiNdebele Incwadi 1', author: 'Zimbabwe Ministry of Education', description: 'Foundational Ndebele literacy: reading, writing and oral traditions for Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1', 'Grade 2', 'Grade 3'], topics: []),
  Book(id: 'sho_o1', subjectId: 'o1_sho', title: 'ChiShona Gwaro reForma 1', author: 'College Press Publishers', description: 'Indigenous language literature, grammar, oral traditions and cultural studies for Form 1', type: 'textbook', url: '', gradeLevels: ['Form 1', 'Form 2', 'Form 3', 'Form 4'], topics: []),

  // ===== HERITAGE-SOCIAL STUDIES =====
  Book(id: 'hss_g1', subjectId: 'g1_hss', title: 'Heritage-Social Studies Grade 1', author: 'Zimbabwe Ministry of Education', description: 'Family, community, cultural heritage and national identity for Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: []),
  Book(id: 'hss_g3', subjectId: 'g3_hss', title: 'Heritage-Social Studies Grade 3', author: 'Zimbabwe Ministry of Education', description: 'Zimbabwe provinces, map reading and cultural heritage sites', type: 'textbook', url: '', gradeLevels: ['Grade 3'], topics: []),
  Book(id: 'hss_g4', subjectId: 'g4_hss', title: 'Heritage-Social Studies Grade 4', author: 'Zimbabwe Ministry of Education', description: 'Zimbabwean history, governance, natural resources and heritage preservation', type: 'textbook', url: '', gradeLevels: ['Grade 4'], topics: []),
  Book(id: 'hss_g5', subjectId: 'g5_hss', title: 'Heritage-Social Studies Grade 5', author: 'Zimbabwe Ministry of Education', description: 'African history, colonialism, liberation struggle and continental heritage', type: 'textbook', url: '', gradeLevels: ['Grade 5'], topics: []),
  Book(id: 'hss_o1', subjectId: 'o1_his', title: 'History Form 1', author: 'College Press Publishers', description: 'Zimbabwean, African and world history from ancient to modern times', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: ['Introduction to History', 'Early Zimbabwe']),
  Book(id: 'hss_o2', subjectId: 'o2_his', title: 'History Form 2', author: 'College Press Publishers', description: 'Zimbabwe history 1890-1980, African nationalism and liberation struggle', type: 'textbook', url: '', gradeLevels: ['Form 2'], topics: []),

  // ===== AGRICULTURE =====
  Book(id: 'agr_g3', subjectId: 'g3_agr', title: 'Agriculture Grade 3', author: 'Zimbabwe Ministry of Education', description: 'Plant growth, crop cultivation, soil types and garden projects', type: 'textbook', url: '', gradeLevels: ['Grade 3'], topics: []),
  Book(id: 'agr_g4', subjectId: 'g4_agr', title: 'Agriculture Grade 4', author: 'Zimbabwe Ministry of Education', description: 'Livestock management, vegetable production, farm tools and food security', type: 'textbook', url: '', gradeLevels: ['Grade 4'], topics: []),
  Book(id: 'agr_g5', subjectId: 'g5_agr', title: 'Agriculture Grade 5', author: 'Zimbabwe Ministry of Education', description: 'Crop rotation, pest control, irrigation, marketing and agribusiness', type: 'textbook', url: '', gradeLevels: ['Grade 5'], topics: []),
  Book(id: 'agr_o1', subjectId: 'o1_agr', title: 'Agriculture Form 1', author: 'College Press Publishers', description: 'Principles of agriculture, crop and livestock production, farm management', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: []),

  // ===== GEOGRAPHY =====
  Book(id: 'geo_o1', subjectId: 'o1_geo', title: 'Geography Form 1', author: 'College Press Publishers', description: 'Physical and human geography, map reading and environmental studies for Form 1', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: ['Map Reading', 'Weather and Climate']),
  Book(id: 'geo_o2', subjectId: 'o2_geo', title: 'Geography Form 2', author: 'College Press Publishers', description: 'Climate, landforms, population studies and economic geography', type: 'textbook', url: '', gradeLevels: ['Form 2'], topics: []),
  Book(id: 'geo_a5', subjectId: 'a5_geo', title: 'Advanced Level Geography', author: 'Cambridge University Press', description: 'Physical geography, climatology and geospatial analysis for Form 5', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== HISTORY =====
  Book(id: 'his_a5', subjectId: 'a5_his', title: 'Advanced Level History', author: 'Cambridge University Press', description: 'African and world history 1900-2000 with historiographical analysis', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== ECONOMICS =====
  Book(id: 'eco_o3', subjectId: 'o3_eco', title: 'Economics Form 3', author: 'College Press Publishers', description: 'Microeconomics, macroeconomics, markets and economic development', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: []),
  Book(id: 'eco_a5', subjectId: 'a5_eco', title: 'Advanced Level Economics', author: 'Cambridge University Press', description: 'Microeconomic and macroeconomic theory for Form 5', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== COMPUTER SCIENCE =====
  Book(id: 'ict_g1', subjectId: 'g1_ict', title: 'ICT Grade 1', author: 'Zimbabwe Ministry of Education', description: 'Introduction to computers, digital literacy and safe technology use', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: []),
  Book(id: 'csc_o1', subjectId: 'o1_ict', title: 'Computer Science Form 1', author: 'College Press Publishers', description: 'Computer fundamentals, programming basics and digital literacy for Form 1', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: []),
  Book(id: 'csc_a5', subjectId: 'a5_csc', title: 'Advanced Level Computer Science', author: 'Cambridge University Press', description: 'Data structures, algorithms and software development for Form 5', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== COMMERCE & ACCOUNTING =====
  Book(id: 'bus_o2', subjectId: 'o2_bus', title: 'Commerce Form 2', author: 'College Press Publishers', description: 'Business principles, trade, banking, insurance and communication', type: 'textbook', url: '', gradeLevels: ['Form 2'], topics: []),
  Book(id: 'acc_o3', subjectId: 'o3_acc', title: 'Accounting Form 3', author: 'College Press Publishers', description: 'Financial accounting, bookkeeping, trial balance and financial statements', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: []),
  Book(id: 'bus_a5', subjectId: 'a5_bus', title: 'Advanced Level Business Studies', author: 'Cambridge University Press', description: 'Business management, marketing, finance and entrepreneurship for Form 5', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),
  Book(id: 'acc_a5', subjectId: 'a5_acc', title: 'Advanced Level Accounting', author: 'Cambridge University Press', description: 'Financial accounting, costing and auditing for Form 5', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== FAMILY AND RELIGIOUS STUDIES (FRS / FRM) =====
  Book(id: 'frs_o1', subjectId: 'o1_frs', title: 'Step Ahead Family & Religious Studies Form 1', author: 'Secondary Book Press', description: 'Foundational FRS covering African Indigenous Religion, Abrahamic faiths, Unhu/Ubuntu, and family heritage', type: 'textbook', url: 'https://openstax.org/subjects', gradeLevels: ['Form 1'], topics: ['Foundations of Family & Religion', 'Judaism and Christianity Foundations', 'Unhu/Ubuntu and Social Ethics']),
  Book(id: 'frs_o2', subjectId: 'o2_frs', title: 'Step Ahead Family & Religious Studies Form 2', author: 'Secondary Book Press', description: 'African Traditional Religion rites of passage, Islam, world religions, and family ethics', type: 'textbook', url: 'https://openstax.org/subjects', gradeLevels: ['Form 2'], topics: ['African Traditional Religion (AIR) & Rites of Passage', 'Islam & Comparative Religious Practices', 'Family Dynamics & Contemporary Moral Issues']),
  Book(id: 'frs_o3', subjectId: 'o3_frs', title: 'Focus on Family & Religious Studies Form 3', author: 'College Press Publishers', description: 'Comprehensive O-Level FRS covering ATR theology, Old & New Testament prophecy, and world religions', type: 'textbook', url: 'https://openstax.org/subjects', gradeLevels: ['Form 3'], topics: ['Indigenous Religion', 'World Religions', 'Biblical Studies & Prophecy']),
  Book(id: 'frs_o4', subjectId: 'o4_frs', title: 'Pass Your O-Level FRS: Exam Revision Guide Form 4', author: 'College Press Publishers', description: 'O-Level FRS past exam paper analysis, essay structuring, moral dilemmas, and peacebuilding', type: 'textbook', url: 'https://openstax.org/subjects', gradeLevels: ['Form 4'], topics: ['Ethics and Morality', 'Exam Preparation', 'Religion, Peace & National Reconciliation']),
  Book(id: 'frs_a5', subjectId: 'a5_frs', title: 'Advanced Level Family & Religious Studies: ATR & Biblical Hermeneutics', author: 'Secondary Book Press', description: 'A-Level FRS covering ATR cosmology, Old/New Testament exegesis, and Christian theology', type: 'textbook', url: 'https://ocw.mit.edu/courses/humanities/', gradeLevels: ['Form 5'], topics: ['Advanced Indigenous Religion', 'Advanced Christian Theology', 'Old & New Testament Hermeneutics']),
  Book(id: 'frs_a6', subjectId: 'a6_frs', title: 'Advanced Level FRS: Comparative Religion & Moral Philosophy Form 6', author: 'Secondary Book Press', description: 'A-Level FRS Paper 1 & Paper 2 master guide: bioethics, interfaith dialogue, and thesis essay writing', type: 'textbook', url: 'https://ocw.mit.edu/courses/humanities/', gradeLevels: ['Form 6'], topics: ['Comparative Religion', 'Advanced Moral Philosophy', 'A-Level FRS & Divinity Exam Mastery']),
  Book(id: 'frs_set_1', subjectId: 'o3_frs', title: 'African Traditional Religion in Zimbabwe: Heritage & Practice', author: 'M. Aschwanden & MoPSE', description: 'Core set book on Zimbabwean traditional religion, Mwari cult, ancestors, and sacred shrines', type: 'set_book', url: 'https://whc.unesco.org/en/list/364/', gradeLevels: ['Form 3', 'Form 4', 'Form 5', 'Form 6'], topics: ['Indigenous Religion']),
  Book(id: 'frs_set_2', subjectId: 'o4_frs', title: 'Social Justice in the Old Testament Prophets', author: 'Cambridge University Press', description: 'Thematic study guide on Amos, Hosea, Isaiah and contemporary moral ethics', type: 'reference', url: 'https://openstax.org/subjects', gradeLevels: ['Form 3', 'Form 4', 'Form 5', 'Form 6'], topics: ['Biblical Studies & Prophecy']),

  // ===== DIVINITY =====
  Book(id: 'div_a5', subjectId: 'a5_div', title: 'Advanced Level Divinity', author: 'Cambridge University Press', description: 'Biblical studies, ethics and comparative religion for Form 5', type: 'textbook', url: 'https://ocw.mit.edu/courses/humanities/', gradeLevels: ['Form 5', 'Form 6'], topics: []),

  // ===== VPA & CREATIVE ARTS =====
  Book(id: 'vpa_g1', subjectId: 'g1_vpa', title: 'Visual and Performing Arts Grade 1', author: 'Zimbabwe Ministry of Education', description: 'Creative expression through drawing, painting, music and movement', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: []),
  Book(id: 'frm_g1', subjectId: 'g1_frm', title: 'Family, Religion and Moral Education Grade 1', author: 'Zimbabwe Ministry of Education', description: 'Values, morals, family relationships and religious education for Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: []),
  Book(id: 'pe_g1', subjectId: 'g1_pe', title: 'Physical Education Grade 1', author: 'Zimbabwe Ministry of Education', description: 'Basic motor skills, games, sports and physical fitness for Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: []),

  // ===== ECD BOOKS =====
  Book(id: 'ecd_act_1', subjectId: 'ecda_lan', title: 'ECD A Activity Book: Language', author: 'Zimbabwe Ministry of Education', description: 'Language and communication activities for ECD A learners aged 3-4', type: 'activity_book', url: '', gradeLevels: ['ECD A'], topics: []),
  Book(id: 'ecd_act_2', subjectId: 'ecda_mat', title: 'ECD A Activity Book: Numeracy', author: 'Zimbabwe Ministry of Education', description: 'Early numeracy activities: counting, shapes and patterns for ages 3-4', type: 'activity_book', url: '', gradeLevels: ['ECD A'], topics: []),
  Book(id: 'ecd_act_3', subjectId: 'ecdb_lan', title: 'ECD B Activity Book: Language', author: 'Zimbabwe Ministry of Education', description: 'Pre-reading and pre-writing activities for ECD B learners aged 4-5', type: 'activity_book', url: '', gradeLevels: ['ECD B'], topics: []),
  Book(id: 'ecd_act_4', subjectId: 'ecdb_mat', title: 'ECD B Activity Book: Numeracy', author: 'Zimbabwe Ministry of Education', description: 'Number recognition 1-20 and simple addition for ages 4-5', type: 'activity_book', url: '', gradeLevels: ['ECD B'], topics: []),
  Book(id: 'ecd_story', subjectId: 'ecda_lan', title: 'Zimbabwean Folktales for ECD', author: 'Zimbabwe Ministry of Education', description: 'Collection of traditional folktales for storytelling and moral education', type: 'storybook', url: '', gradeLevels: ['ECD A', 'ECD B'], topics: []),

  // ===== CAMBRIDGE PRIMARY - ENGLISH =====
  Book(id: 'cam_eng_g1', subjectId: 'cam_g1_eng', title: 'Cambridge Primary English Learner\'s Book 1', author: 'Cambridge University Press', description: 'Phonics, reading, writing and speaking skills for Cambridge Primary English Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: ['Phonics and Reading', 'Writing Skills']),
  Book(id: 'cam_eng_g3', subjectId: 'cam_g3_eng', title: 'Cambridge Primary English Learner\'s Book 3', author: 'Cambridge University Press', description: 'Reading comprehension, creative writing and grammar for Cambridge Primary English Grade 3', type: 'textbook', url: '', gradeLevels: ['Grade 3'], topics: ['Reading Comprehension', 'Creative Writing']),
  Book(id: 'cam_eng_g5', subjectId: 'cam_g5_eng', title: 'Cambridge Primary English Learner\'s Book 5', author: 'Cambridge University Press', description: 'Persuasive writing, literary analysis and advanced grammar for Cambridge Primary English Grade 5', type: 'textbook', url: '', gradeLevels: ['Grade 5'], topics: ['Persuasive Writing', 'Literary Analysis']),
  Book(id: 'cam_eng_g6', subjectId: 'cam_g6_eng', title: 'Cambridge Primary English Checkpoint', author: 'Cambridge University Press', description: 'Cambridge Primary Checkpoint English preparation with practice tests and revision', type: 'textbook', url: '', gradeLevels: ['Grade 6'], topics: ['Checkpoint Preparation']),

  // ===== CAMBRIDGE PRIMARY - MATHEMATICS =====
  Book(id: 'cam_mat_g1', subjectId: 'cam_g1_mat', title: 'Cambridge Primary Mathematics Learner\'s Book 1', author: 'Cambridge University Press', description: 'Numbers, shapes, measures and data handling for Cambridge Primary Mathematics Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: ['Numbers and Counting', 'Addition and Subtraction']),
  Book(id: 'cam_mat_g3', subjectId: 'cam_g3_mat', title: 'Cambridge Primary Mathematics Learner\'s Book 3', author: 'Cambridge University Press', description: 'Multiplication, division, fractions and geometry for Cambridge Primary Mathematics Grade 3', type: 'textbook', url: '', gradeLevels: ['Grade 3'], topics: ['Multiplication and Division', 'Fractions and Decimals']),
  Book(id: 'cam_mat_g5', subjectId: 'cam_g5_mat', title: 'Cambridge Primary Mathematics Learner\'s Book 5', author: 'Cambridge University Press', description: 'Ratio, proportion, algebra and graphs for Cambridge Primary Mathematics Grade 5', type: 'textbook', url: '', gradeLevels: ['Grade 5'], topics: ['Ratio and Proportion', 'Algebra and Graphs']),
  Book(id: 'cam_mat_g6', subjectId: 'cam_g6_mat', title: 'Cambridge Primary Mathematics Checkpoint', author: 'Cambridge University Press', description: 'Cambridge Primary Checkpoint Mathematics preparation with practice tests', type: 'textbook', url: '', gradeLevels: ['Grade 6'], topics: ['Checkpoint Preparation']),

  // ===== CAMBRIDGE PRIMARY - SCIENCE =====
  Book(id: 'cam_sci_g1', subjectId: 'cam_g1_sci', title: 'Cambridge Primary Science Learner\'s Book 1', author: 'Cambridge University Press', description: 'Living things, materials and physical processes for Cambridge Primary Science Grade 1', type: 'textbook', url: '', gradeLevels: ['Grade 1'], topics: ['Living Things', 'Materials']),
  Book(id: 'cam_sci_g3', subjectId: 'cam_g3_sci', title: 'Cambridge Primary Science Learner\'s Book 3', author: 'Cambridge University Press', description: 'Forces, magnets, light and sound for Cambridge Primary Science Grade 3', type: 'textbook', url: '', gradeLevels: ['Grade 3'], topics: ['Forces and Magnets', 'Light and Sound']),
  Book(id: 'cam_sci_g5', subjectId: 'cam_g5_sci', title: 'Cambridge Primary Science Learner\'s Book 5', author: 'Cambridge University Press', description: 'Matter, energy, electricity and astronomy for Cambridge Primary Science Grade 5', type: 'textbook', url: '', gradeLevels: ['Grade 5'], topics: ['Matter and Materials', 'Earth and Space']),

  // ===== CAMBRIDGE LOWER SECONDARY =====
  Book(id: 'cam_eng_o1', subjectId: 'cam_o1_eng', title: 'Cambridge Lower Secondary English Learner\'s Book 1', author: 'Cambridge University Press', description: 'Grammar, composition, literature and oral skills for Cambridge Lower Secondary Form 1', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: ['Grammar and Structure', 'Composition Writing']),
  Book(id: 'cam_mat_o1', subjectId: 'cam_o1_mat', title: 'Cambridge Lower Secondary Mathematics Learner\'s Book 1', author: 'Cambridge University Press', description: 'Number theory, algebra, geometry and trigonometry for Cambridge Lower Secondary Form 1', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: ['Number Theory', 'Algebra']),
  Book(id: 'cam_sci_o1', subjectId: 'cam_o1_sci', title: 'Cambridge Lower Secondary Science Learner\'s Book 1', author: 'Cambridge University Press', description: 'Biology, chemistry and physics fundamentals for Cambridge Lower Secondary Form 1', type: 'textbook', url: '', gradeLevels: ['Form 1'], topics: ['Biology Basics', 'Chemistry Basics', 'Physics Basics']),

  // ===== CAMBRIDGE IGCSE =====
  Book(id: 'cam_eng_o3', subjectId: 'cam_o3_eng', title: 'Cambridge IGCSE English First Language Coursebook', author: 'Cambridge University Press', description: 'Comprehensive IGCSE English First Language preparation with exam practice', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Reading and Comprehension', 'Writing']),
  Book(id: 'cam_mat_o3', subjectId: 'cam_o3_mat', title: 'Cambridge IGCSE Mathematics Coursebook', author: 'Cambridge University Press', description: 'Complete IGCSE Mathematics covering number, algebra, geometry and statistics', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Number and Algebra', 'Geometry and Measure']),
  Book(id: 'cam_bio_o3', subjectId: 'cam_o3_bio', title: 'Cambridge IGCSE Biology Coursebook', author: 'Cambridge University Press', description: 'Cell biology, genetics, ecology and human biology for IGCSE Biology', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Cell Biology', 'Genetics and Evolution']),
  Book(id: 'cam_che_o3', subjectId: 'cam_o3_che', title: 'Cambridge IGCSE Chemistry Coursebook', author: 'Cambridge University Press', description: 'Atomic structure, bonding, organic chemistry and chemical analysis for IGCSE Chemistry', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Atomic Structure', 'Chemical Reactions']),
  Book(id: 'cam_phy_o3', subjectId: 'cam_o3_phy', title: 'Cambridge IGCSE Physics Coursebook', author: 'Cambridge University Press', description: 'Mechanics, waves, electricity and nuclear physics for IGCSE Physics', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Mechanics', 'Waves and Electricity']),
  Book(id: 'cam_eco_o3', subjectId: 'cam_o3_eco', title: 'Cambridge IGCSE Economics Coursebook', author: 'Cambridge University Press', description: 'Microeconomics, macroeconomics and development economics for IGCSE Economics', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Basic Economic Ideas']),
  Book(id: 'cam_bus_o3', subjectId: 'cam_o3_bus', title: 'Cambridge IGCSE Business Studies Coursebook', author: 'Cambridge University Press', description: 'Business activity, marketing, finance and operations for IGCSE Business Studies', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Business Activity']),
  Book(id: 'cam_cs_o3', subjectId: 'cam_o3_cs', title: 'Cambridge IGCSE Computer Science Coursebook', author: 'Cambridge University Press', description: 'Programming, algorithms, data representation and hardware for IGCSE Computer Science', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Programming']),
  Book(id: 'cam_his_o3', subjectId: 'cam_o3_his', title: 'Cambridge IGCSE History Coursebook', author: 'Cambridge University Press', description: 'International relations and modern world history for IGCSE History', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['International Relations']),
  Book(id: 'cam_geo_o3', subjectId: 'cam_o3_geo', title: 'Cambridge IGCSE Geography Coursebook', author: 'Cambridge University Press', description: 'Physical and human geography with fieldwork skills for IGCSE Geography', type: 'textbook', url: '', gradeLevels: ['Form 3', 'Form 4'], topics: ['Physical Geography', 'Human Geography']),

  // ===== CAMBRIDGE A-LEVEL =====
  Book(id: 'cam_mat_a5', subjectId: 'cam_a5_mat', title: 'Cambridge International AS & A Level Mathematics Coursebook', author: 'Cambridge University Press', description: 'Pure mathematics, mechanics and statistics for Cambridge A-Level Mathematics', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Pure Mathematics 1', 'Mechanics']),
  Book(id: 'cam_bio_a5', subjectId: 'cam_a5_bio', title: 'Cambridge International AS & A Level Biology Coursebook', author: 'Cambridge University Press', description: 'Cell biology, molecular biology, genetics and ecology for Cambridge A-Level Biology', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Cell Structure', 'Molecular Biology']),
  Book(id: 'cam_che_a5', subjectId: 'cam_a5_che', title: 'Cambridge International AS & A Level Chemistry Coursebook', author: 'Cambridge University Press', description: 'Physical, inorganic and organic chemistry for Cambridge A-Level Chemistry', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Physical Chemistry', 'Inorganic Chemistry']),
  Book(id: 'cam_phy_a5', subjectId: 'cam_a5_phy', title: 'Cambridge International AS & A Level Physics Coursebook', author: 'Cambridge University Press', description: 'Mechanics, waves, electricity and modern physics for Cambridge A-Level Physics', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Mechanics', 'Waves and Electricity']),
  Book(id: 'cam_eco_a5', subjectId: 'cam_a5_eco', title: 'Cambridge International AS & A Level Economics Coursebook', author: 'Cambridge University Press', description: 'Microeconomics and macroeconomics for Cambridge A-Level Economics', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Microeconomics', 'Macroeconomics']),
  Book(id: 'cam_bus_a5', subjectId: 'cam_a5_bus', title: 'Cambridge International AS & A Level Business Studies Coursebook', author: 'Cambridge University Press', description: 'Business environment, strategy and case studies for Cambridge A-Level Business Studies', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Business Environment']),
  Book(id: 'cam_cs_a5', subjectId: 'cam_a5_cs', title: 'Cambridge International AS & A Level Computer Science Coursebook', author: 'Cambridge University Press', description: 'Programming, algorithms, data structures and theory for Cambridge A-Level Computer Science', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Programming Fundamentals']),
  Book(id: 'cam_his_a5', subjectId: 'cam_a5_his', title: 'Cambridge International AS & A Level History Coursebook', author: 'Cambridge University Press', description: 'African and world history with historiographical analysis for Cambridge A-Level History', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['African History']),
  Book(id: 'cam_geo_a5', subjectId: 'cam_a5_geo', title: 'Cambridge International AS & A Level Geography Coursebook', author: 'Cambridge University Press', description: 'Physical geography, human geography and field research for Cambridge A-Level Geography', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Physical Geography']),
  Book(id: 'cam_lit_a5', subjectId: 'cam_a5_lit', title: 'Cambridge International AS & A Level English Literature Coursebook', author: 'Cambridge University Press', description: 'Poetry, prose, drama and literary criticism for Cambridge A-Level English Literature', type: 'textbook', url: '', gradeLevels: ['Form 5', 'Form 6'], topics: ['Poetry Analysis']),
];

List<Book> getBooksForSubject(String subjectId, String gradeLevel) {
  final books = allBooks.where((b) =>
    b.subjectId == subjectId && b.gradeLevels.contains(gradeLevel)
  ).toList();
  
  if (books.isEmpty) {
    // Provide some mock reading material if none exist
    return [
      Book(
        id: '${subjectId}_mock_1',
        subjectId: subjectId,
        title: 'Core Principles of $subjectId',
        author: 'Education Board',
        description: 'Essential reading material for $gradeLevel covering fundamental concepts.',
        type: 'textbook',
        url: '',
        gradeLevels: [gradeLevel],
        topics: [],
      ),
      Book(
        id: '${subjectId}_mock_2',
        subjectId: subjectId,
        title: 'Practice & Activity Book',
        author: 'Education Board',
        description: 'Interactive exercises and extra reading material.',
        type: 'activity_book',
        url: '',
        gradeLevels: [gradeLevel],
        topics: [],
      )
    ];
  }
  return books;
}

List<Book> getBooksForTopic(String subjectId, String gradeLevel, String topicName) {
  return allBooks.where((b) =>
    b.subjectId == subjectId &&
    b.gradeLevels.contains(gradeLevel) &&
    (b.topics.isEmpty || b.topics.contains(topicName))
  ).toList();
}
