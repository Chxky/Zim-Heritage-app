import '../models/subject.dart';
import 'cambridge_curriculum.dart';

final Map<String, List<Subject>> curriculumByGrade = {
  // ========== ECD A (Ages 3-4) ==========
  'ECD A': [
    Subject(id: 'ecda_lan', name: 'Language and Communication', description: 'Early language skills, vocabulary building, and oral expression', gradeLevel: 'ECD A', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'ecda_mat', name: 'Early Numeracy', description: 'Number concepts, counting, shapes, and patterns', gradeLevel: 'ECD A', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'ecda_env', name: 'Environmental Science', description: 'Exploring nature, weather, living things, and the environment', gradeLevel: 'ECD A', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'ecda_sed', name: 'Social and Emotional Development', description: 'Self-awareness, relationships, emotions, and social skills', gradeLevel: 'ECD A', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'ecda_cre', name: 'Creative Arts', description: 'Drawing, painting, music, movement, and imaginative play', gradeLevel: 'ECD A', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'ecda_phy', name: 'Physical Development', description: 'Fine and gross motor skills, coordination, and outdoor play', gradeLevel: 'ECD A', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'ecda_ind', name: 'Indigenous Language Play', description: 'Shona/Ndebele songs, stories, and cultural play activities', gradeLevel: 'ECD A', color: '0xFF9C27B0', icon: 'translate'),
  ],
  // ========== ECD B (Ages 4-5) ==========
  'ECD B': [
    Subject(id: 'ecdb_lan', name: 'Language and Communication', description: 'Pre-reading, pre-writing, phonics, and storytelling', gradeLevel: 'ECD B', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'ecdb_mat', name: 'Early Numeracy', description: 'Number recognition 1-20, simple addition, sorting and classifying', gradeLevel: 'ECD B', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'ecdb_env', name: 'Environmental Science', description: 'Plants, animals, seasons, water, and basic scientific inquiry', gradeLevel: 'ECD B', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'ecdb_sed', name: 'Social and Emotional Development', description: 'Sharing, cooperation, cultural identity, and moral values', gradeLevel: 'ECD B', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'ecdb_cre', name: 'Creative Arts', description: 'Art projects, traditional crafts, singing, and dramatic play', gradeLevel: 'ECD B', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'ecdb_phy', name: 'Physical Development', description: 'Running, jumping, throwing, catching, and health habits', gradeLevel: 'ECD B', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'ecdb_ind', name: 'Indigenous Language Play', description: 'Shona/Ndebele vocabulary, proverbs, and cultural games', gradeLevel: 'ECD B', color: '0xFF9C27B0', icon: 'translate'),
  ],
  // ========== GRADE 1 ==========
  'Grade 1': [
    Subject(id: 'g1_eng', name: 'English Language', description: 'Foundational literacy: phonics, reading, writing, and oral communication skills', gradeLevel: 'Grade 1', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'g1_mat', name: 'Mathematics', description: 'Number recognition, counting, basic addition and subtraction, shapes', gradeLevel: 'Grade 1', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'g1_sho', name: 'Shona/Ndebele', description: 'Indigenous language literacy: reading, writing, and oral traditions', gradeLevel: 'Grade 1', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'g1_hss', name: 'Heritage-Social Studies', description: 'Family, community, cultural heritage, and national identity', gradeLevel: 'Grade 1', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'g1_sct', name: 'Science and Technology', description: 'Exploring the environment, basic scientific concepts, and technology awareness', gradeLevel: 'Grade 1', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'g1_vpa', name: 'Visual and Performing Arts', description: 'Creative expression through drawing, painting, music, and movement', gradeLevel: 'Grade 1', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'g1_frm', name: 'Family, Religion and Moral Education', description: 'Values, morals, family relationships, and religious education', gradeLevel: 'Grade 1', color: '0xFF795548', icon: 'church'),
    Subject(id: 'g1_pe', name: 'Physical Education, Sport and Mass Displays', description: 'Basic motor skills, games, sports, and physical fitness', gradeLevel: 'Grade 1', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'g1_ict', name: 'Information and Communication Technology', description: 'Introduction to computers, digital literacy, and safe technology use', gradeLevel: 'Grade 1', color: '0xFF3F51B5', icon: 'computer'),
  ],
  'Grade 2': [
    Subject(id: 'g2_eng', name: 'English Language', description: 'Reading comprehension, sentence construction, spelling, and oral expression', gradeLevel: 'Grade 2', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'g2_mat', name: 'Mathematics', description: 'Addition, subtraction, multiplication basics, place value, and measurement', gradeLevel: 'Grade 2', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'g2_sho', name: 'Shona/Ndebele', description: 'Indigenous language development: grammar, reading, and storytelling', gradeLevel: 'Grade 2', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'g2_hss', name: 'Heritage-Social Studies', description: 'Community roles, cultural practices, and Zimbabwean heritage', gradeLevel: 'Grade 2', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'g2_sct', name: 'Science and Technology', description: 'Living things, weather, simple machines, and technology in daily life', gradeLevel: 'Grade 2', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'g2_vpa', name: 'Visual and Performing Arts', description: 'Art techniques, rhythm, dance, and creative performance', gradeLevel: 'Grade 2', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'g2_frm', name: 'Family, Religion and Moral Education', description: 'Family values, respect, religious diversity, and moral decision-making', gradeLevel: 'Grade 2', color: '0xFF795548', icon: 'church'),
    Subject(id: 'g2_pe', name: 'Physical Education, Sport and Mass Displays', description: 'Coordination, teamwork, basic sports skills, and healthy habits', gradeLevel: 'Grade 2', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'g2_ict', name: 'Information and Communication Technology', description: 'Using educational software, typing skills, and digital citizenship', gradeLevel: 'Grade 2', color: '0xFF3F51B5', icon: 'computer'),
  ],
  'Grade 3': [
    Subject(id: 'g3_eng', name: 'English Language', description: 'Advanced reading, paragraph writing, grammar, and public speaking', gradeLevel: 'Grade 3', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'g3_mat', name: 'Mathematics', description: 'Multiplication, division, fractions, time, money, and data handling', gradeLevel: 'Grade 3', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'g3_sho', name: 'Shona/Ndebele', description: 'Proverbs, folktales, poetry, and advanced indigenous language skills', gradeLevel: 'Grade 3', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'g3_hss', name: 'Heritage-Social Studies', description: 'Zimbabwe provinces, map reading, cultural heritage sites', gradeLevel: 'Grade 3', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'g3_sci', name: 'General Science', description: 'Plants, animals, energy, water cycle, and environmental conservation', gradeLevel: 'Grade 3', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'g3_agr', name: 'Agriculture', description: 'Plant growth, crop cultivation, soil types, and garden projects', gradeLevel: 'Grade 3', color: '0xFF4CAF50', icon: 'agriculture'),
    Subject(id: 'g3_vpa', name: 'Visual and Performing Arts', description: 'Art appreciation, traditional crafts, music instruments, and drama', gradeLevel: 'Grade 3', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'g3_frm', name: 'Family, Religion and Moral Education', description: 'Community responsibility, ethical values, and religious knowledge', gradeLevel: 'Grade 3', color: '0xFF795548', icon: 'church'),
    Subject(id: 'g3_pe', name: 'Physical Education, Sport and Mass Displays', description: 'Athletics, ball games, traditional games, and fitness routines', gradeLevel: 'Grade 3', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'g3_ict', name: 'Information and Communication Technology', description: 'Word processing, internet basics, and educational software', gradeLevel: 'Grade 3', color: '0xFF3F51B5', icon: 'computer'),
  ],
  'Grade 4': [
    Subject(id: 'g4_eng', name: 'English Language', description: 'Composition writing, reading fluency, comprehension strategies, and vocabulary', gradeLevel: 'Grade 4', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'g4_mat', name: 'Mathematics', description: 'Decimals, percentages, geometry, area, perimeter, and problem-solving', gradeLevel: 'Grade 4', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'g4_sho', name: 'Shona/Ndebele', description: 'Creative writing, idioms, cultural narratives, and language structure', gradeLevel: 'Grade 4', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'g4_hss', name: 'Heritage-Social Studies', description: 'Zimbabwean history, governance, natural resources, and heritage preservation', gradeLevel: 'Grade 4', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'g4_sci', name: 'General Science', description: 'Human body, ecosystems, forces, light, sound, and scientific investigations', gradeLevel: 'Grade 4', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'g4_agr', name: 'Agriculture', description: 'Livestock management, vegetable production, farm tools, and food security', gradeLevel: 'Grade 4', color: '0xFF4CAF50', icon: 'agriculture'),
    Subject(id: 'g4_vpa', name: 'Visual and Performing Arts', description: 'Design principles, sculpture, traditional dance, and theatrical performance', gradeLevel: 'Grade 4', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'g4_frm', name: 'Family, Religion and Moral Education', description: 'Ethical leadership, religious texts, and community service', gradeLevel: 'Grade 4', color: '0xFF795548', icon: 'church'),
    Subject(id: 'g4_pe', name: 'Physical Education, Sport and Mass Displays', description: 'Sport skills, gymnastics, swimming basics, and nutrition awareness', gradeLevel: 'Grade 4', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'g4_ict', name: 'Information and Communication Technology', description: 'Spreadsheets, presentations, internet research, and cyber safety', gradeLevel: 'Grade 4', color: '0xFF3F51B5', icon: 'computer'),
  ],
  'Grade 5': [
    Subject(id: 'g5_eng', name: 'English Language', description: 'Essay writing, literary analysis, advanced grammar, and persuasive communication', gradeLevel: 'Grade 5', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'g5_mat', name: 'Mathematics', description: 'Ratio, proportion, algebra intro, angles, graphs, and statistical data', gradeLevel: 'Grade 5', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'g5_sho', name: 'Shona/Ndebele', description: 'Advanced literature, poetry analysis, formal writing, and oratory', gradeLevel: 'Grade 5', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'g5_hss', name: 'Heritage-Social Studies', description: 'African history, colonialism, liberation struggle, and continental heritage', gradeLevel: 'Grade 5', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'g5_sci', name: 'General Science', description: 'Matter, energy systems, electricity, astronomy, and scientific methods', gradeLevel: 'Grade 5', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'g5_agr', name: 'Agriculture', description: 'Crop rotation, pest control, irrigation, marketing, and agribusiness', gradeLevel: 'Grade 5', color: '0xFF4CAF50', icon: 'agriculture'),
    Subject(id: 'g5_vpa', name: 'Visual and Performing Arts', description: 'Advanced art techniques, choreography, composition, and art criticism', gradeLevel: 'Grade 5', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'g5_frm', name: 'Family, Religion and Moral Education', description: 'Global ethics, interfaith dialogue, and responsible citizenship', gradeLevel: 'Grade 5', color: '0xFF795548', icon: 'church'),
    Subject(id: 'g5_pe', name: 'Physical Education, Sport and Mass Displays', description: 'Competitive sports, fitness assessment, first aid, and sportsmanship', gradeLevel: 'Grade 5', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'g5_ict', name: 'Information and Communication Technology', description: 'Programming basics, multimedia creation, and digital collaboration', gradeLevel: 'Grade 5', color: '0xFF3F51B5', icon: 'computer'),
  ],
  'Grade 6': [
    Subject(id: 'g6_eng', name: 'English Language', description: 'Critical reading, research skills, debate, and advanced composition', gradeLevel: 'Grade 6', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'g6_mat', name: 'Mathematics', description: 'Advanced algebra, probability, transformations, and mathematical modeling', gradeLevel: 'Grade 6', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'g6_sho', name: 'Shona/Ndebele', description: 'Classical literature, language research, translation, and indigenous knowledge systems', gradeLevel: 'Grade 6', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'g6_hss', name: 'Heritage-Social Studies', description: 'Global citizenship, human rights, sustainable development, and heritage tourism', gradeLevel: 'Grade 6', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'g6_sci', name: 'General Science', description: 'Chemistry basics, genetics, ecology, technology innovations, and space science', gradeLevel: 'Grade 6', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'g6_agr', name: 'Agriculture', description: 'Commercial farming, value addition, agricultural policy, and entrepreneurship', gradeLevel: 'Grade 6', color: '0xFF4CAF50', icon: 'agriculture'),
    Subject(id: 'g6_vpa', name: 'Visual and Performing Arts', description: 'Portfolio development, cultural performances, exhibition, and arts entrepreneurship', gradeLevel: 'Grade 6', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'g6_frm', name: 'Family, Religion and Moral Education', description: 'Ethical dilemmas, social justice, and moral leadership', gradeLevel: 'Grade 6', color: '0xFF795548', icon: 'church'),
    Subject(id: 'g6_pe', name: 'Physical Education, Sport and Mass Displays', description: 'Sports leadership, event organization, coaching basics, and lifetime fitness', gradeLevel: 'Grade 6', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'g6_ict', name: 'Information and Communication Technology', description: 'Web design, databases, coding concepts, and digital entrepreneurship', gradeLevel: 'Grade 6', color: '0xFF3F51B5', icon: 'computer'),
  ],
  'Grade 7': [
    Subject(id: 'g7_eng', name: 'English Language', description: 'Exam preparation, literary criticism, advanced writing, and media literacy', gradeLevel: 'Grade 7', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'g7_mat', name: 'Mathematics', description: 'Pre-algebra, geometry proofs, statistics, and exam-level problem solving', gradeLevel: 'Grade 7', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'g7_sho', name: 'Shona/Ndebele', description: 'Advanced language mastery, literary appreciation, and cultural preservation', gradeLevel: 'Grade 7', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'g7_hss', name: 'Heritage-Social Studies', description: 'Zimbabwe in global context, heritage legislation, and civic responsibility', gradeLevel: 'Grade 7', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'g7_sci', name: 'General Science', description: 'Integrated science, environmental chemistry, and scientific literacy', gradeLevel: 'Grade 7', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'g7_agr', name: 'Agriculture', description: 'Sustainable agriculture, climate-smart farming, and food systems', gradeLevel: 'Grade 7', color: '0xFF4CAF50', icon: 'agriculture'),
    Subject(id: 'g7_vpa', name: 'Visual and Performing Arts', description: 'Mastery in chosen art form, arts leadership, and community arts projects', gradeLevel: 'Grade 7', color: '0xFFE91E63', icon: 'palette'),
    Subject(id: 'g7_frm', name: 'Family, Religion and Moral Education', description: 'Life skills, career guidance, and ethical decision-making for the future', gradeLevel: 'Grade 7', color: '0xFF795548', icon: 'church'),
    Subject(id: 'g7_pe', name: 'Physical Education, Sport and Mass Displays', description: 'Advanced sports, personal fitness plans, and health promotion', gradeLevel: 'Grade 7', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'g7_ict', name: 'Information and Communication Technology', description: 'Advanced computing, robotics concepts, and technology innovation', gradeLevel: 'Grade 7', color: '0xFF3F51B5', icon: 'computer'),
  ],
  // ========== ORDINARY LEVEL - FORM 1 ==========
  'Form 1': [
    Subject(id: 'o1_eng', name: 'English Language', description: 'Comprehensive English: grammar, composition, literature, and oral skills', gradeLevel: 'Form 1', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'o1_mat', name: 'Mathematics', description: 'Number theory, algebra, geometry, trigonometry, statistics and probability', gradeLevel: 'Form 1', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'o1_sho', name: 'Shona/Ndebele', description: 'Indigenous language: literature, grammar, oral traditions, and cultural studies', gradeLevel: 'Form 1', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'o1_sci', name: 'Combined Science', description: 'Integrated science: biology, chemistry, physics fundamentals', gradeLevel: 'Form 1', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'o1_his', name: 'History', description: 'Zimbabwean, African, and world history from ancient to modern times', gradeLevel: 'Form 1', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'o1_geo', name: 'Geography', description: 'Physical and human geography, map reading, and environmental studies', gradeLevel: 'Form 1', color: '0xFF795548', icon: 'explore'),
    Subject(id: 'o1_agr', name: 'Agriculture', description: 'Principles of agriculture, crop and livestock production, farm management', gradeLevel: 'Form 1', color: '0xFF4CAF50', icon: 'agriculture'),
    Subject(id: 'o1_frm', name: 'Family, Religion and Moral Education', description: 'Ethics, religious studies, family values, and life skills education', gradeLevel: 'Form 1', color: '0xFF795548', icon: 'church'),
    Subject(id: 'o1_pe', name: 'Physical Education, Sport and Mass Displays', description: 'Sports, physical fitness, health education, and mass displays', gradeLevel: 'Form 1', color: '0xFFF44336', icon: 'sports'),
    Subject(id: 'o1_ict', name: 'Computer Science', description: 'Computer fundamentals, programming basics, and digital literacy', gradeLevel: 'Form 1', color: '0xFF3F51B5', icon: 'computer'),
  ],
  'Form 2': [
    Subject(id: 'o2_eng', name: 'English Language', description: 'Advanced English: critical analysis, essay writing, and research skills', gradeLevel: 'Form 2', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'o2_mat', name: 'Mathematics', description: 'Sets, relations, functions, matrices, and advanced problem solving', gradeLevel: 'Form 2', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'o2_sho', name: 'Shona/Ndebele', description: 'Advanced indigenous language: prose, poetry, drama, and language structure', gradeLevel: 'Form 2', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'o2_sci', name: 'Combined Science', description: 'Scientific concepts: cell biology, chemical reactions, forces and energy', gradeLevel: 'Form 2', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'o2_his', name: 'History', description: 'Zimbabwe history 1890-1980, African nationalism, and liberation struggle', gradeLevel: 'Form 2', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'o2_geo', name: 'Geography', description: 'Climate, landforms, population studies, and economic geography', gradeLevel: 'Form 2', color: '0xFF795548', icon: 'explore'),
    Subject(id: 'o2_agr', name: 'Agriculture', description: 'Soil science, crop production, livestock management, and farm economics', gradeLevel: 'Form 2', color: '0xFF4CAF50', icon: 'agriculture'),
    Subject(id: 'o2_bus', name: 'Commerce', description: 'Business principles, trade, banking, insurance, and communication', gradeLevel: 'Form 2', color: '0xFFE91E63', icon: 'business'),
    Subject(id: 'o2_frm', name: 'Family, Religion and Moral Education', description: 'Moral philosophy, religious diversity, and community engagement', gradeLevel: 'Form 2', color: '0xFF795548', icon: 'church'),
    Subject(id: 'o2_pe', name: 'Physical Education', description: 'Advanced sports, coaching, fitness programming, and sports science', gradeLevel: 'Form 2', color: '0xFFF44336', icon: 'sports'),
  ],
  'Form 3': [
    Subject(id: 'o3_eng', name: 'English Language', description: 'Exam-focused English: comprehension, summary, and literary analysis', gradeLevel: 'Form 3', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'o3_mat', name: 'Mathematics', description: 'Calculus intro, coordinate geometry, transformations, and statistics', gradeLevel: 'Form 3', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'o3_sho', name: 'Shona/Ndebele', description: 'Set books, literary criticism, and advanced composition', gradeLevel: 'Form 3', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'o3_bio', name: 'Biology', description: 'Cell biology, genetics, ecology, human anatomy, and physiology', gradeLevel: 'Form 3', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'o3_che', name: 'Chemistry', description: 'Atomic structure, bonding, organic chemistry, and chemical analysis', gradeLevel: 'Form 3', color: '0xFFFF5722', icon: 'science'),
    Subject(id: 'o3_phy', name: 'Physics', description: 'Mechanics, waves, electricity, magnetism, and nuclear physics', gradeLevel: 'Form 3', color: '0xFF3F51B5', icon: 'science'),
    Subject(id: 'o3_his', name: 'History', description: 'International affairs, cold war, and contemporary global issues', gradeLevel: 'Form 3', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'o3_geo', name: 'Geography', description: 'Geomorphology, climatology, environmental management, and GIS', gradeLevel: 'Form 3', color: '0xFF795548', icon: 'explore'),
    Subject(id: 'o3_acc', name: 'Accounting', description: 'Financial accounting, bookkeeping, trial balance, and financial statements', gradeLevel: 'Form 3', color: '0xFF4CAF50', icon: 'account_balance'),
    Subject(id: 'o3_eco', name: 'Economics', description: 'Microeconomics, macroeconomics, markets, and economic development', gradeLevel: 'Form 3', color: '0xFFE91E63', icon: 'trending_up'),
  ],
  'Form 4': [
    Subject(id: 'o4_eng', name: 'English Language', description: 'O-Level exam preparation: past papers, exam techniques, and revision', gradeLevel: 'Form 4', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'o4_mat', name: 'Mathematics', description: 'O-Level mathematics: comprehensive revision and exam preparation', gradeLevel: 'Form 4', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'o4_sho', name: 'Shona/Ndebele', description: 'O-Level exam preparation: set books revision and language mastery', gradeLevel: 'Form 4', color: '0xFF9C27B0', icon: 'translate'),
    Subject(id: 'o4_bio', name: 'Biology', description: 'O-Level biology: revision, practical skills, and exam techniques', gradeLevel: 'Form 4', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'o4_che', name: 'Chemistry', description: 'O-Level chemistry: quantitative analysis, organic chemistry, and exams', gradeLevel: 'Form 4', color: '0xFFFF5722', icon: 'science'),
    Subject(id: 'o4_phy', name: 'Physics', description: 'O-Level physics: advanced topics, practical physics, and exam prep', gradeLevel: 'Form 4', color: '0xFF3F51B5', icon: 'science'),
    Subject(id: 'o4_his', name: 'History', description: 'O-Level history: comprehensive revision and exam strategies', gradeLevel: 'Form 4', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'o4_geo', name: 'Geography', description: 'O-Level geography: revision, map work, and exam preparation', gradeLevel: 'Form 4', color: '0xFF795548', icon: 'explore'),
    Subject(id: 'o4_agr', name: 'Agriculture', description: 'O-Level agriculture: revision, farm projects, and exam readiness', gradeLevel: 'Form 4', color: '0xFF4CAF50', icon: 'agriculture'),
    Subject(id: 'o4_acc', name: 'Accounting', description: 'O-Level accounting: final accounts, adjustments, and exam prep', gradeLevel: 'Form 4', color: '0xFF4CAF50', icon: 'account_balance'),
    Subject(id: 'o4_eco', name: 'Economics', description: 'O-Level economics: national income, trade, and exam preparation', gradeLevel: 'Form 4', color: '0xFFE91E63', icon: 'trending_up'),
    Subject(id: 'o4_com', name: 'Computer Science', description: 'O-Level computing: programming, databases, and exam preparation', gradeLevel: 'Form 4', color: '0xFF3F51B5', icon: 'computer'),
    Subject(id: 'o4_ftd', name: 'Food Technology and Design', description: 'Food science, nutrition, meal planning, and design projects', gradeLevel: 'Form 4', color: '0xFFFF9800', icon: 'restaurant'),
  ],
  // ========== ADVANCED LEVEL - FORM 5 ==========
  'Form 5': [
    Subject(id: 'a5_mat', name: 'Mathematics', description: 'Pure mathematics: calculus, algebra, trigonometry, and statistics', gradeLevel: 'Form 5', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'a5_bio', name: 'Biology', description: 'Advanced biology: molecular biology, genetics, ecology, and physiology', gradeLevel: 'Form 5', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'a5_che', name: 'Chemistry', description: 'Advanced chemistry: physical, inorganic, and organic chemistry', gradeLevel: 'Form 5', color: '0xFFFF5722', icon: 'science'),
    Subject(id: 'a5_phy', name: 'Physics', description: 'Advanced physics: mechanics, fields, thermodynamics, and quantum physics', gradeLevel: 'Form 5', color: '0xFF3F51B5', icon: 'science'),
    Subject(id: 'a5_his', name: 'History', description: 'Advanced history: themes in African and world history 1900-2000', gradeLevel: 'Form 5', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'a5_geo', name: 'Geography', description: 'Advanced geography: physical geography, climatology, and geospatial analysis', gradeLevel: 'Form 5', color: '0xFF795548', icon: 'explore'),
    Subject(id: 'a5_eco', name: 'Economics', description: 'Advanced economics: microeconomic and macroeconomic theory', gradeLevel: 'Form 5', color: '0xFFE91E63', icon: 'trending_up'),
    Subject(id: 'a5_bus', name: 'Business Studies', description: 'Advanced business: management, marketing, finance, and entrepreneurship', gradeLevel: 'Form 5', color: '0xFF4CAF50', icon: 'business'),
    Subject(id: 'a5_lit', name: 'Literature in English', description: 'Advanced literature: poetry, prose, drama, and literary criticism', gradeLevel: 'Form 5', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'a5_div', name: 'Divinity', description: 'Advanced divinity: biblical studies, ethics, and comparative religion', gradeLevel: 'Form 5', color: '0xFF795548', icon: 'church'),
    Subject(id: 'a5_acc', name: 'Accounting', description: 'Advanced accounting: financial accounting, costing, and auditing', gradeLevel: 'Form 5', color: '0xFF4CAF50', icon: 'account_balance'),
    Subject(id: 'a5_csc', name: 'Computer Science', description: 'Advanced computing: data structures, algorithms, and software development', gradeLevel: 'Form 5', color: '0xFF3F51B5', icon: 'computer'),
  ],
  'Form 6': [
    Subject(id: 'a6_mat', name: 'Mathematics', description: 'A-Level mathematics: advanced calculus, mechanics, and further pure maths', gradeLevel: 'Form 6', color: '0xFF4CAF50', icon: 'calculate'),
    Subject(id: 'a6_bio', name: 'Biology', description: 'A-Level biology: biotechnology, evolution, and advanced biological concepts', gradeLevel: 'Form 6', color: '0xFF00BCD4', icon: 'science'),
    Subject(id: 'a6_che', name: 'Chemistry', description: 'A-Level chemistry: advanced organic synthesis, spectroscopy, and electrochemistry', gradeLevel: 'Form 6', color: '0xFFFF5722', icon: 'science'),
    Subject(id: 'a6_phy', name: 'Physics', description: 'A-Level physics: particle physics, astrophysics, and advanced practical physics', gradeLevel: 'Form 6', color: '0xFF3F51B5', icon: 'science'),
    Subject(id: 'a6_his', name: 'History', description: 'A-Level history: historiographical debates, research, and exam preparation', gradeLevel: 'Form 6', color: '0xFFFF9800', icon: 'account_balance'),
    Subject(id: 'a6_geo', name: 'Geography', description: 'A-Level geography: environmental management, development, and field research', gradeLevel: 'Form 6', color: '0xFF795548', icon: 'explore'),
    Subject(id: 'a6_eco', name: 'Economics', description: 'A-Level economics: development economics, international trade, and economic policy', gradeLevel: 'Form 6', color: '0xFFE91E63', icon: 'trending_up'),
    Subject(id: 'a6_bus', name: 'Business Studies', description: 'A-Level business: strategic management, business policy, and case studies', gradeLevel: 'Form 6', color: '0xFF4CAF50', icon: 'business'),
    Subject(id: 'a6_lit', name: 'Literature in English', description: 'A-Level literature: advanced literary theory, comparative studies, and coursework', gradeLevel: 'Form 6', color: '0xFF2196F3', icon: 'abc'),
    Subject(id: 'a6_div', name: 'Divinity', description: 'A-Level divinity: theological studies, ethics, and philosophy of religion', gradeLevel: 'Form 6', color: '0xFF795548', icon: 'church'),
    Subject(id: 'a6_acc', name: 'Accounting', description: 'A-Level accounting: corporate accounting, financial reporting, and analysis', gradeLevel: 'Form 6', color: '0xFF4CAF50', icon: 'account_balance'),
    Subject(id: 'a6_csc', name: 'Computer Science', description: 'A-Level computing: AI, machine learning, networks, and cybersecurity', gradeLevel: 'Form 6', color: '0xFF3F51B5', icon: 'computer'),
  ],
};

List<Subject> getSubjectsForGrade(String grade) {
  return curriculumByGrade[grade] ?? [];
}

List<Subject> getAllSubjects() {
  return curriculumByGrade.values.expand((list) => list).toList();
}

List<String> getGradeLevels() {
  return curriculumByGrade.keys.toList();
}

// Curriculum-aware helper functions
List<Subject> getSubjectsForGradeAndCurriculum(String grade, String curriculum) {
  if (curriculum == 'cambridge') {
    return getCambridgeSubjectsForGrade(grade);
  }
  return curriculumByGrade[grade] ?? [];
}

List<Subject> getAllSubjectsForCurriculum(String curriculum) {
  if (curriculum == 'cambridge') {
    return getAllCambridgeSubjects();
  }
  return curriculumByGrade.values.expand((list) => list).toList();
}

List<Topic> getTopicsForSubjectAndCurriculum(String subjectId, String gradeLevel, String curriculum) {
  if (curriculum == 'cambridge') {
    return getCambridgeTopicsForSubject(subjectId, gradeLevel);
  }
  return _allTopics.where((t) => t.subjectId == subjectId && t.gradeLevel == gradeLevel).toList();
}

String getLevelCategory(String grade) {
  if (grade.startsWith('ECD')) return 'ECD';
  if (grade.startsWith('Grade')) return 'Primary';
  if (grade.startsWith('Form 1') || grade.startsWith('Form 2') || grade.startsWith('Form 3') || grade.startsWith('Form 4')) return 'O-Level';
  if (grade.startsWith('Form 5') || grade.startsWith('Form 6')) return 'A-Level';
  return 'Other';
}

String getAgeRange(String grade) {
  switch (grade) {
    case 'ECD A': return 'Ages 3-4';
    case 'ECD B': return 'Ages 4-5';
    case 'Grade 1': return 'Age 6';
    case 'Grade 2': return 'Age 7';
    case 'Grade 3': return 'Age 8';
    case 'Grade 4': return 'Age 9';
    case 'Grade 5': return 'Age 10';
    case 'Grade 6': return 'Age 11';
    case 'Grade 7': return 'Age 12';
    case 'Form 1': return 'Age 13-14';
    case 'Form 2': return 'Age 14-15';
    case 'Form 3': return 'Age 15-16';
    case 'Form 4': return 'Age 16-17';
    case 'Form 5': return 'Age 17-18';
    case 'Form 6': return 'Age 18-19';
    default: return '';
  }
}

int getMinAgeForGrade(String grade) {
  switch (grade) {
    case 'ECD A': return 3;
    case 'ECD B': return 4;
    case 'Grade 1': return 6;
    case 'Grade 2': return 7;
    case 'Grade 3': return 8;
    case 'Grade 4': return 9;
    case 'Grade 5': return 10;
    case 'Grade 6': return 11;
    case 'Grade 7': return 12;
    case 'Form 1': return 13;
    case 'Form 2': return 14;
    case 'Form 3': return 15;
    case 'Form 4': return 16;
    case 'Form 5': return 17;
    case 'Form 6': return 18;
    default: return 0;
  }
}

List<Topic> getTopicsForSubject(String subjectId, String gradeLevel) {
  final allTopics = _allTopics;
  return allTopics.where((t) => t.subjectId == subjectId && t.gradeLevel == gradeLevel).toList();
}

List<Topic> _allTopics = [
  // ========== ECD A ==========
  Topic(id: 'ecda_lan_1', subjectId: 'ecda_lan', name: 'Oral Language', description: 'Developing speaking and listening', subtopics: ['Greetings and introductions', 'Naming objects', 'Following instructions', 'Asking questions'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_lan_2', subjectId: 'ecda_lan', name: 'Vocabulary Building', description: 'Learning new words', subtopics: ['Body parts', 'Food items', 'Clothing', 'Animals'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_lan_3', subjectId: 'ecda_lan', name: 'Story Time', description: 'Listening and responding to stories', subtopics: ['Picture books', 'Traditional tales', 'Story sequencing', 'Character recognition'], gradeLevel: 'ECD A', term: 'Term 2'),
  Topic(id: 'ecda_lan_4', subjectId: 'ecda_lan', name: 'Pre-Writing Skills', description: 'Developing fine motor control', subtopics: ['Tracing lines', 'Colouring', 'Pattern making', 'Pencil grip'], gradeLevel: 'ECD A', term: 'Term 2'),
  Topic(id: 'ecda_mat_1', subjectId: 'ecda_mat', name: 'Number Concepts', description: 'Understanding numbers 1-10', subtopics: ['Counting 1-10', 'Number recognition', 'One-to-one correspondence', 'More and less'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_mat_2', subjectId: 'ecda_mat', name: 'Shapes and Colours', description: 'Identifying basic shapes and colours', subtopics: ['Circle, square, triangle', 'Red, blue, yellow, green', 'Sorting by colour', 'Shape matching'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_mat_3', subjectId: 'ecda_mat', name: 'Patterns and Sorting', description: 'Recognising patterns', subtopics: ['Pattern copying', 'Sorting objects', 'Size comparison (big/small)', 'Matching pairs'], gradeLevel: 'ECD A', term: 'Term 2'),
  Topic(id: 'ecda_env_1', subjectId: 'ecda_env', name: 'Exploring Nature', description: 'Discovering the natural world', subtopics: ['Plants and flowers', 'Garden creatures', 'Weather observation', 'Water play'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_env_2', subjectId: 'ecda_env', name: 'Living Things', description: 'Plants and animals around us', subtopics: ['Domestic animals', 'Wild animals', 'Animal sounds', 'Plant parts'], gradeLevel: 'ECD A', term: 'Term 2'),
  Topic(id: 'ecda_sed_1', subjectId: 'ecda_sed', name: 'Myself', description: 'Self-awareness and identity', subtopics: ['My name and age', 'My family', 'My feelings', 'What I like'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_sed_2', subjectId: 'ecda_sed', name: 'Social Skills', description: 'Learning to interact with others', subtopics: ['Sharing', 'Taking turns', 'Saying please and thank you', 'Making friends'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_sed_3', subjectId: 'ecda_sed', name: 'Cultural Identity', description: 'Who we are as Zimbabweans', subtopics: ['Our flag', 'Traditional greetings', 'Cultural songs', 'National pride'], gradeLevel: 'ECD A', term: 'Term 2'),
  Topic(id: 'ecda_cre_1', subjectId: 'ecda_cre', name: 'Art Exploration', description: 'Creative expression through art', subtopics: ['Finger painting', 'Crayon drawing', 'Paper tearing', 'Play dough'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_cre_2', subjectId: 'ecda_cre', name: 'Music and Movement', description: 'Rhythm and creative movement', subtopics: ['Action songs', 'Drumming', 'Dance', 'Musical instruments'], gradeLevel: 'ECD A', term: 'Term 2'),
  Topic(id: 'ecda_phy_1', subjectId: 'ecda_phy', name: 'Gross Motor Skills', description: 'Large muscle development', subtopics: ['Running', 'Jumping', 'Climbing', 'Balancing'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_phy_2', subjectId: 'ecda_phy', name: 'Fine Motor Skills', description: 'Small muscle development', subtopics: ['Threading beads', 'Cutting with scissors', 'Building blocks', 'Play dough manipulation'], gradeLevel: 'ECD A', term: 'Term 2'),
  Topic(id: 'ecda_ind_1', subjectId: 'ecda_ind', name: 'Traditional Songs', description: 'Learning songs in Shona/Ndebele', subtopics: ['Greeting songs', 'Animal songs', 'Game songs', 'Lullabies'], gradeLevel: 'ECD A', term: 'Term 1'),
  Topic(id: 'ecda_ind_2', subjectId: 'ecda_ind', name: 'Cultural Games', description: 'Traditional Zimbabwean children\'s games', subtopics: ['Nhodo intro', 'Pada', 'Clapping games', 'Circle games'], gradeLevel: 'ECD A', term: 'Term 2'),

  // ========== ECD B ==========
  Topic(id: 'ecdb_lan_1', subjectId: 'ecdb_lan', name: 'Pre-Reading Skills', description: 'Getting ready to read', subtopics: ['Letter recognition', 'Letter sounds', 'Picture reading', 'Left to right progression'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_lan_2', subjectId: 'ecdb_lan', name: 'Pre-Writing Skills', description: 'Preparing to write', subtopics: ['Letter tracing', 'Name writing', 'Simple words', 'Sentence copying'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_lan_3', subjectId: 'ecdb_lan', name: 'Phonics', description: 'Letter-sound relationships', subtopics: ['Consonant sounds', 'Vowel sounds', 'Blending', 'Simple CVC words'], gradeLevel: 'ECD B', term: 'Term 2'),
  Topic(id: 'ecdb_mat_1', subjectId: 'ecdb_mat', name: 'Numbers 1-20', description: 'Number recognition and counting', subtopics: ['Counting 1-20', 'Writing numbers', 'Number words', 'Counting objects'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_mat_2', subjectId: 'ecdb_mat', name: 'Simple Addition', description: 'Introduction to adding', subtopics: ['Adding 1 more', 'Adding 2 more', 'Number stories', 'Using fingers'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_mat_3', subjectId: 'ecdb_mat', name: 'Measurement', description: 'Basic measurement concepts', subtopics: ['Length comparison', 'Weight comparison', 'Capacity (full/empty)', 'Time (morning/night)'], gradeLevel: 'ECD B', term: 'Term 2'),
  Topic(id: 'ecdb_env_1', subjectId: 'ecdb_env', name: 'Seasons', description: 'Learning about weather and seasons', subtopics: ['Rainy season', 'Dry season', 'Winter and summer', 'Seasonal activities'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_env_2', subjectId: 'ecdb_env', name: 'Plant Growth', description: 'How plants grow', subtopics: ['Seeds', 'Planting', 'Watering', 'Watching plants grow'], gradeLevel: 'ECD B', term: 'Term 2'),
  Topic(id: 'ecdb_sed_1', subjectId: 'ecdb_sed', name: 'Emotions', description: 'Understanding feelings', subtopics: ['Happy, sad, angry', 'Expressing feelings', 'Calming down', 'Empathy'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_sed_2', subjectId: 'ecdb_sed', name: 'Cooperation', description: 'Working with others', subtopics: ['Group activities', 'Helping others', 'Classroom jobs', 'Sharing materials'], gradeLevel: 'ECD B', term: 'Term 2'),
  Topic(id: 'ecdb_cre_1', subjectId: 'ecdb_cre', name: 'Creative Art', description: 'Artistic expression', subtopics: ['Painting techniques', 'Collage', 'Printing', 'Model making'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_cre_2', subjectId: 'ecdb_cre', name: 'Dramatic Play', description: 'Imaginative play and performance', subtopics: ['Role play', 'Puppetry', 'Simple plays', 'Dress-up'], gradeLevel: 'ECD B', term: 'Term 2'),
  Topic(id: 'ecdb_phy_1', subjectId: 'ecdb_phy', name: 'Coordination', description: 'Body coordination skills', subtopics: ['Throwing and catching', 'Hopping and skipping', 'Obstacle courses', 'Ball games'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_phy_2', subjectId: 'ecdb_phy', name: 'Health and Hygiene', description: 'Personal care habits', subtopics: ['Hand washing', 'Tooth brushing', 'Healthy eating', 'Sleep and rest'], gradeLevel: 'ECD B', term: 'Term 2'),
  Topic(id: 'ecdb_ind_1', subjectId: 'ecdb_ind', name: 'Indigenous Language', description: 'Developing mother tongue vocabulary', subtopics: ['Simple greetings', 'Family names', 'Body parts in Shona/Ndebele', 'Animal names'], gradeLevel: 'ECD B', term: 'Term 1'),
  Topic(id: 'ecdb_ind_2', subjectId: 'ecdb_ind', name: 'Cultural Stories', description: 'Traditional folktales', subtopics: ['Tsuro stories (Shona)', 'Ugani tales (Ndebele)', 'Moral lessons', 'Story dramatisation'], gradeLevel: 'ECD B', term: 'Term 2'),

  // ========== GRADE 1 ==========
  Topic(id: 'g1_eng_1', subjectId: 'g1_eng', name: 'Phonics and Letter Sounds', description: 'Learning letter sounds and blending', subtopics: ['Consonant sounds', 'Vowel sounds', 'Blending sounds', 'Word families'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_eng_2', subjectId: 'g1_eng', name: 'Reading Readiness', description: 'Pre-reading skills and picture reading', subtopics: ['Picture interpretation', 'Left to right tracking', 'Sight words', 'Simple sentences'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_eng_3', subjectId: 'g1_eng', name: 'Writing Skills', description: 'Basic handwriting and letter formation', subtopics: ['Letter formation', 'Tracing', 'Copying words', 'Simple writing'], gradeLevel: 'Grade 1', term: 'Term 2'),

  // ========== FORM 1 (O-LEVEL) ==========
  Topic(id: 'o1_eng_1', subjectId: 'o1_eng', name: 'Grammar and Structure', description: 'Advanced English grammar', subtopics: ['Parts of speech', 'Sentence structure', 'Tenses', 'Active and passive voice'], gradeLevel: 'Form 1', term: 'Term 1'),
  Topic(id: 'o1_eng_2', subjectId: 'o1_eng', name: 'Composition Writing', description: 'Developing writing skills', subtopics: ['Narrative essays', 'Descriptive essays', 'Letter writing', 'Report writing'], gradeLevel: 'Form 1', term: 'Term 1'),
  Topic(id: 'o1_eng_3', subjectId: 'o1_eng', name: 'Comprehension', description: 'Reading and understanding texts', subtopics: ['Main idea', 'Supporting details', 'Inference', 'Vocabulary in context'], gradeLevel: 'Form 1', term: 'Term 2'),
  Topic(id: 'o1_mat_1', subjectId: 'o1_mat', name: 'Number Theory', description: 'Numbers and operations', subtopics: ['Sets', 'Number systems', 'Factors and multiples', 'Indices and standard form'], gradeLevel: 'Form 1', term: 'Term 1'),
  Topic(id: 'o1_mat_2', subjectId: 'o1_mat', name: 'Algebra', description: 'Introduction to algebra', subtopics: ['Algebraic expressions', 'Linear equations', 'Inequalities', 'Simultaneous equations'], gradeLevel: 'Form 1', term: 'Term 1'),
  Topic(id: 'o1_mat_3', subjectId: 'o1_mat', name: 'Geometry', description: 'Geometric concepts', subtopics: ['Angles and lines', 'Triangles', 'Quadrilaterals', 'Circles'], gradeLevel: 'Form 1', term: 'Term 2'),
  Topic(id: 'o1_sci_1', subjectId: 'o1_sci', name: 'Scientific Method', description: 'Introduction to scientific inquiry', subtopics: ['Observation', 'Hypothesis', 'Experimentation', 'Data analysis'], gradeLevel: 'Form 1', term: 'Term 1'),
  Topic(id: 'o1_sci_2', subjectId: 'o1_sci', name: 'Cell Biology', description: 'Basic unit of life', subtopics: ['Cell structure', 'Cell types', 'Cell division', 'Tissues and organs'], gradeLevel: 'Form 1', term: 'Term 1'),
  Topic(id: 'o1_sci_3', subjectId: 'o1_sci', name: 'Matter and Energy', description: 'Physical science fundamentals', subtopics: ['States of matter', 'Energy forms', 'Energy transfer', 'Simple machines'], gradeLevel: 'Form 1', term: 'Term 2'),
  Topic(id: 'o1_his_1', subjectId: 'o1_his', name: 'Introduction to History', description: 'Understanding history as a discipline', subtopics: ['What is history', 'Historical sources', 'Timelines', 'Historical interpretation'], gradeLevel: 'Form 1', term: 'Term 1'),
  Topic(id: 'o1_his_2', subjectId: 'o1_his', name: 'Early Zimbabwe', description: 'Pre-colonial Zimbabwe', subtopics: ['Early inhabitants', 'Great Zimbabwe', 'Mutapa State', 'Rozvi State'], gradeLevel: 'Form 1', term: 'Term 2'),
  Topic(id: 'o1_geo_1', subjectId: 'o1_geo', name: 'Map Reading', description: 'Interpreting maps', subtopics: ['Compass directions', 'Map scales', 'Grid references', 'Contour lines'], gradeLevel: 'Form 1', term: 'Term 1'),
  Topic(id: 'o1_geo_2', subjectId: 'o1_geo', name: 'Weather and Climate', description: 'Atmospheric processes', subtopics: ['Weather elements', 'Climate of Zimbabwe', 'Weather instruments', 'Climate change'], gradeLevel: 'Form 1', term: 'Term 2'),

  // ========== FORM 5 (A-LEVEL) ==========
  Topic(id: 'a5_mat_1', subjectId: 'a5_mat', name: 'Pure Mathematics', description: 'Advanced pure maths', subtopics: ['Functions', 'Calculus', 'Vectors', 'Complex numbers'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_mat_2', subjectId: 'a5_mat', name: 'Statistics and Probability', description: 'Statistical analysis', subtopics: ['Probability distributions', 'Hypothesis testing', 'Correlation', 'Regression'], gradeLevel: 'Form 5', term: 'Term 2'),
  Topic(id: 'a5_bio_1', subjectId: 'a5_bio', name: 'Molecular Biology', description: 'Biochemistry and molecular processes', subtopics: ['Biomolecules', 'Enzymes', 'DNA replication', 'Protein synthesis'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_bio_2', subjectId: 'a5_bio', name: 'Genetics and Evolution', description: 'Genetic principles and evolution', subtopics: ['Mendelian genetics', 'Gene expression', 'Natural selection', 'Speciation'], gradeLevel: 'Form 5', term: 'Term 2'),
  Topic(id: 'a5_che_1', subjectId: 'a5_che', name: 'Physical Chemistry', description: 'Chemical principles and calculations', subtopics: ['Atomic structure', 'Chemical bonding', 'Thermochemistry', 'Chemical kinetics'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_che_2', subjectId: 'a5_che', name: 'Organic Chemistry', description: 'Carbon compounds and reactions', subtopics: ['Hydrocarbons', 'Functional groups', 'Reaction mechanisms', 'Organic synthesis'], gradeLevel: 'Form 5', term: 'Term 2'),
  Topic(id: 'a5_phy_1', subjectId: 'a5_phy', name: 'Mechanics', description: 'Advanced mechanics', subtopics: ['Newtonian mechanics', 'Energy and momentum', 'Circular motion', 'Gravitation'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_phy_2', subjectId: 'a5_phy', name: 'Fields and Waves', description: 'Electromagnetic and wave phenomena', subtopics: ['Electric fields', 'Magnetic fields', 'Electromagnetic waves', 'Wave properties'], gradeLevel: 'Form 5', term: 'Term 2'),
  Topic(id: 'a5_eco_1', subjectId: 'a5_eco', name: 'Microeconomics', description: 'Individual economic decision-making', subtopics: ['Demand and supply', 'Market structures', 'Price determination', 'Elasticity'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_eco_2', subjectId: 'a5_eco', name: 'Macroeconomics', description: 'Economy-wide phenomena', subtopics: ['National income', 'Inflation', 'Unemployment', 'Fiscal and monetary policy'], gradeLevel: 'Form 5', term: 'Term 2'),
  Topic(id: 'a5_lit_1', subjectId: 'a5_lit', name: 'Poetry Analysis', description: 'Critical analysis of poetry', subtopics: ['Poetic devices', 'Themes', 'Structure and form', 'Comparative analysis'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_lit_2', subjectId: 'a5_lit', name: 'Prose Studies', description: 'Analysis of novels and short stories', subtopics: ['Plot structure', 'Character development', 'Narrative techniques', 'Critical essays'], gradeLevel: 'Form 5', term: 'Term 2'),
  Topic(id: 'a5_div_1', subjectId: 'a5_div', name: 'Biblical Studies', description: 'Old and New Testament studies', subtopics: ['Pentateuch', 'Prophets', 'Gospels', 'Pauline epistles'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_his_1', subjectId: 'a5_his', name: 'Africa in Global Context', description: 'Africa 1900-1945', subtopics: ['Colonial Africa', 'African nationalism', 'World Wars impact', 'Pan-Africanism'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_geo_1', subjectId: 'a5_geo', name: 'Geomorphology', description: 'Landform processes', subtopics: ['Plate tectonics', 'Weathering', 'River processes', 'Glacial landscapes'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_bus_1', subjectId: 'a5_bus', name: 'Business Environment', description: 'Understanding business context', subtopics: ['Business objectives', 'Stakeholders', 'External environment', 'Corporate culture'], gradeLevel: 'Form 5', term: 'Term 1'),
  Topic(id: 'a5_csc_1', subjectId: 'a5_csc', name: 'Data Structures', description: 'Organising and storing data', subtopics: ['Arrays and lists', 'Stacks and queues', 'Trees', 'Hash tables'], gradeLevel: 'Form 5', term: 'Term 1'),

  // ========== FORM 6 (A-LEVEL) ==========
  Topic(id: 'a6_mat_1', subjectId: 'a6_mat', name: 'Advanced Calculus', description: 'Higher-level calculus', subtopics: ['Integration techniques', 'Differential equations', 'Vector calculus', 'Numerical methods'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_mat_2', subjectId: 'a6_mat', name: 'Mechanics', description: 'Applied mathematics', subtopics: ['Kinematics', 'Dynamics', 'Projectiles', 'Circular motion'], gradeLevel: 'Form 6', term: 'Term 2'),
  Topic(id: 'a6_bio_1', subjectId: 'a6_bio', name: 'Ecology', description: 'Ecosystems and environment', subtopics: ['Population ecology', 'Community structure', 'Nutrient cycles', 'Conservation biology'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_bio_2', subjectId: 'a6_bio', name: 'Human Physiology', description: 'Advanced human biology', subtopics: ['Nervous system', 'Endocrine system', 'Immune system', 'Reproduction'], gradeLevel: 'Form 6', term: 'Term 2'),
  Topic(id: 'a6_che_1', subjectId: 'a6_che', name: 'Inorganic Chemistry', description: 'Inorganic chemical processes', subtopics: ['Transition metals', 'Coordination compounds', 'Periodicity', 'Group chemistry'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_che_2', subjectId: 'a6_che', name: 'Analytical Chemistry', description: 'Chemical analysis methods', subtopics: ['Spectroscopy', 'Chromatography', 'Titrimetric analysis', 'Data interpretation'], gradeLevel: 'Form 6', term: 'Term 2'),
  Topic(id: 'a6_phy_1', subjectId: 'a6_phy', name: 'Quantum and Nuclear', description: 'Modern physics', subtopics: ['Quantum theory', 'Nuclear physics', 'Particle physics', 'Radioactivity'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_phy_2', subjectId: 'a6_phy', name: 'Astrophysics', description: 'Space and the universe', subtopics: ['Stellar evolution', 'Cosmology', 'Space physics', 'Observational astronomy'], gradeLevel: 'Form 6', term: 'Term 2'),
  Topic(id: 'a6_eco_1', subjectId: 'a6_eco', name: 'Development Economics', description: 'Economic development', subtopics: ['Growth theories', 'Developing economies', 'Trade and development', 'Economic planning'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_eco_2', subjectId: 'a6_eco', name: 'International Economics', description: 'Global economic relations', subtopics: ['International trade', 'Exchange rates', 'Balance of payments', 'Global economic institutions'], gradeLevel: 'Form 6', term: 'Term 2'),
  Topic(id: 'a6_lit_1', subjectId: 'a6_lit', name: 'Drama Studies', description: 'Critical analysis of drama', subtopics: ['Dramatic structure', 'Character and dialogue', 'Theatre conventions', 'Performance analysis'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_lit_2', subjectId: 'a6_lit', name: 'Literary Theory', description: 'Critical approaches to literature', subtopics: ['Marxist criticism', 'Feminist criticism', 'Post-colonial theory', 'Reader response'], gradeLevel: 'Form 6', term: 'Term 2'),
  Topic(id: 'a6_his_1', subjectId: 'a6_his', name: 'International Affairs', description: 'Global history 1945-2000', subtopics: ['Cold War', 'Decolonisation', 'UN and global governance', 'Contemporary conflicts'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_his_2', subjectId: 'a6_his', name: 'Historiography', description: 'Writing and philosophy of history', subtopics: ['Historical schools', 'Historical methodology', 'Interpretation debates', 'Research project'], gradeLevel: 'Form 6', term: 'Term 2'),
  Topic(id: 'a6_bus_1', subjectId: 'a6_bus', name: 'Strategic Management', description: 'Business strategy', subtopics: ['Strategic analysis', 'Strategy formulation', 'Implementation', 'Performance evaluation'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_bus_2', subjectId: 'a6_bus', name: 'Business Case Studies', description: 'Applied business analysis', subtopics: ['Case analysis', 'Business plans', 'Corporate strategy', 'Crisis management'], gradeLevel: 'Form 6', term: 'Term 2'),
  Topic(id: 'a6_csc_1', subjectId: 'a6_csc', name: 'Artificial Intelligence', description: 'AI and machine learning', subtopics: ['Search algorithms', 'Knowledge representation', 'Machine learning basics', 'Neural networks'], gradeLevel: 'Form 6', term: 'Term 1'),
  Topic(id: 'a6_csc_2', subjectId: 'a6_csc', name: 'Networks and Security', description: 'Computer networks and cybersecurity', subtopics: ['Network protocols', 'Network security', 'Cryptography', 'Ethical hacking'], gradeLevel: 'Form 6', term: 'Term 2'),

  // ========== GRADE 1 - ADDITIONAL SUBJECTS ==========
  Topic(id: 'g1_mat_1', subjectId: 'g1_mat', name: 'Numbers 1-100', description: 'Number recognition and counting to 100', subtopics: ['Counting 1-100', 'Number names', 'Ordering numbers', 'Place value tens and ones'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_mat_2', subjectId: 'g1_mat', name: 'Addition and Subtraction', description: 'Basic operations within 20', subtopics: ['Adding 1-digit numbers', 'Subtraction within 20', 'Number bonds', 'Word problems'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_mat_3', subjectId: 'g1_mat', name: 'Shapes and Measurement', description: 'Geometry and measurement basics', subtopics: ['2D shapes', '3D objects', 'Length comparison', 'Telling time'], gradeLevel: 'Grade 1', term: 'Term 2'),
  Topic(id: 'g1_sho_1', subjectId: 'g1_sho', name: 'Oral Language', description: 'Speaking and listening in Shona/Ndebele', subtopics: ['Greetings', 'Classroom language', 'Simple conversations', ' Songs and rhymes'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_sho_2', subjectId: 'g1_sho', name: 'Emergent Reading', description: 'Reading readiness in indigenous language', subtopics: ['Letter recognition', 'Simple words', 'Picture reading', 'Story comprehension'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_sho_3', subjectId: 'g1_sho', name: 'Cultural Stories', description: 'Traditional tales and moral lessons', subtopics: ['Folktales', 'Fables', 'Story sequencing', ' Moral values'], gradeLevel: 'Grade 1', term: 'Term 2'),
  Topic(id: 'g1_hss_1', subjectId: 'g1_hss', name: 'My Family and Community', description: 'Understanding family and community roles', subtopics: ['Family members', 'Roles at home', 'Community helpers', 'Our neighbourhood'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_hss_2', subjectId: 'g1_hss', name: 'Our Zimbabwean Heritage', description: 'Introduction to Zimbabwean culture', subtopics: ['National flag', 'National symbols', 'Cultural practices', 'Traditional foods'], gradeLevel: 'Grade 1', term: 'Term 2'),
  Topic(id: 'g1_sct_1', subjectId: 'g1_sct', name: 'Living and Non-Living', description: 'Exploring living things', subtopics: ['Plants and animals', 'Human body parts', 'Living vs non-living', 'Our senses'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_sct_2', subjectId: 'g1_sct', name: 'Weather and Seasons', description: 'Understanding weather patterns', subtopics: ['Sun and rain', 'Wind and clouds', 'Seasonal changes', 'Dressing for weather'], gradeLevel: 'Grade 1', term: 'Term 2'),
  Topic(id: 'g1_vpa_1', subjectId: 'g1_vpa', name: 'Drawing and Painting', description: 'Creative visual expression', subtopics: ['Basic shapes drawing', 'Colour mixing', 'Nature drawing', 'Pattern making'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_vpa_2', subjectId: 'g1_vpa', name: 'Music and Movement', description: 'Rhythm and creative movement', subtopics: ['Action songs', 'Simple rhythms', 'Dance steps', 'Musical games'], gradeLevel: 'Grade 1', term: 'Term 2'),
  Topic(id: 'g1_frm_1', subjectId: 'g1_frm', name: 'Myself and Others', description: 'Understanding self and relationships', subtopics: ['Who I am', 'My feelings', 'Respecting others', 'Being kind'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_frm_2', subjectId: 'g1_frm', name: 'Values and Morals', description: 'Learning right from wrong', subtopics: ['Honesty', 'Sharing', 'Responsibility', 'Gratitude'], gradeLevel: 'Grade 1', term: 'Term 2'),
  Topic(id: 'g1_pe_1', subjectId: 'g1_pe', name: 'Basic Movement Skills', description: 'Fundamental motor skills', subtopics: ['Running and walking', 'Jumping and hopping', 'Throwing and catching', 'Balancing'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_pe_2', subjectId: 'g1_pe', name: 'Games and Sports', description: 'Introduction to games', subtopics: ['Simple ball games', 'Relay races', 'Traditional games', 'Following rules'], gradeLevel: 'Grade 1', term: 'Term 2'),
  Topic(id: 'g1_ict_1', subjectId: 'g1_ict', name: 'Introduction to Computers', description: 'Getting to know computers', subtopics: ['Computer parts', 'Turning on and off', 'Using a mouse', 'Keyboard basics'], gradeLevel: 'Grade 1', term: 'Term 1'),
  Topic(id: 'g1_ict_2', subjectId: 'g1_ict', name: 'Digital Literacy', description: 'Safe and responsible technology use', subtopics: ['Educational games', 'Drawing on computer', 'Internet safety basics', 'Screen time awareness'], gradeLevel: 'Grade 1', term: 'Term 2'),

  // ========== GRADE 2 ==========
  Topic(id: 'g2_eng_1', subjectId: 'g2_eng', name: 'Reading Comprehension', description: 'Understanding written texts', subtopics: ['Simple passages', 'Main idea', 'Answering questions', 'Making predictions'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_eng_2', subjectId: 'g2_eng', name: 'Grammar and Punctuation', description: 'Sentence construction and punctuation', subtopics: ['Capital letters', 'Full stops and commas', 'Nouns and verbs', 'Sentence building'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_eng_3', subjectId: 'g2_eng', name: 'Creative Writing', description: 'Writing stories and descriptions', subtopics: ['Simple stories', 'Picture descriptions', 'Diary entries', 'Poems'], gradeLevel: 'Grade 2', term: 'Term 2'),
  Topic(id: 'g2_mat_1', subjectId: 'g2_mat', name: 'Multiplication and Division', description: 'Introduction to multiplication and division', subtopics: ['Repeated addition', 'Multiplication tables 1-5', 'Sharing equally', 'Division facts'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_mat_2', subjectId: 'g2_mat', name: 'Place Value and Money', description: 'Understanding place value and currency', subtopics: ['Hundreds tens ones', 'Comparing numbers', 'Zimbabwean currency', 'Money calculations'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_mat_3', subjectId: 'g2_mat', name: 'Measurement and Data', description: 'Measuring and organizing information', subtopics: ['Length in metres', 'Mass in kilograms', 'Capacity in litres', 'Simple graphs'], gradeLevel: 'Grade 2', term: 'Term 2'),
  Topic(id: 'g2_sho_1', subjectId: 'g2_sho', name: 'Language Development', description: 'Building indigenous language skills', subtopics: ['Vocabulary expansion', 'Simple sentences', 'Reading practice', 'Listening comprehension'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_sho_2', subjectId: 'g2_sho', name: 'Storytelling and Folktales', description: 'Oral traditions and narratives', subtopics: ['Traditional stories', 'Proverbs', 'Riddles', 'Dramatisation'], gradeLevel: 'Grade 2', term: 'Term 2'),
  Topic(id: 'g2_hss_1', subjectId: 'g2_hss', name: 'Our Community', description: 'Community roles and responsibilities', subtopics: ['Community workers', 'Places in community', 'Cooperation', 'Rules and laws'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_hss_2', subjectId: 'g2_hss', name: 'Cultural Heritage', description: 'Celebrating Zimbabwean culture', subtopics: ['Traditional ceremonies', 'Cultural attire', 'Indigenous foods', 'Heritage sites'], gradeLevel: 'Grade 2', term: 'Term 2'),
  Topic(id: 'g2_sct_1', subjectId: 'g2_sct', name: 'Living Things', description: 'Plants animals and habitats', subtopics: ['Plant parts and growth', 'Animal groups', 'Habitats', 'Life cycles'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_sct_2', subjectId: 'g2_sct', name: 'Simple Machines', description: 'Everyday machines and technology', subtopics: ['Levers', 'Wheels and axles', 'Pulleys', 'Tools at home'], gradeLevel: 'Grade 2', term: 'Term 2'),
  Topic(id: 'g2_vpa_1', subjectId: 'g2_vpa', name: 'Art Techniques', description: 'Developing artistic skills', subtopics: ['Painting techniques', 'Collage', 'Printing', 'Paper crafts'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_vpa_2', subjectId: 'g2_vpa', name: 'Performance Arts', description: 'Dance drama and music', subtopics: ['Traditional dance', 'Drama games', 'Singing in harmony', 'Rhythm instruments'], gradeLevel: 'Grade 2', term: 'Term 2'),
  Topic(id: 'g2_frm_1', subjectId: 'g2_frm', name: 'Family Values', description: 'Strengthening family bonds', subtopics: ['Family relationships', 'Helping at home', 'Respecting elders', 'Family traditions'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_frm_2', subjectId: 'g2_frm', name: 'Religious Education', description: 'Introduction to religious diversity', subtopics: ['Places of worship', 'Religious festivals', 'Prayer and meditation', 'Religious stories'], gradeLevel: 'Grade 2', term: 'Term 2'),
  Topic(id: 'g2_pe_1', subjectId: 'g2_pe', name: 'Coordination and Agility', description: 'Movement and coordination', subtopics: ['Obstacle courses', 'Skipping and hopping', 'Ball handling', 'Balance exercises'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_pe_2', subjectId: 'g2_pe', name: 'Health and Nutrition', description: 'Healthy habits for growing children', subtopics: ['Food groups', 'Hygiene practices', 'Exercise benefits', 'Rest and sleep'], gradeLevel: 'Grade 2', term: 'Term 2'),
  Topic(id: 'g2_ict_1', subjectId: 'g2_ict', name: 'Using Software', description: 'Introduction to educational software', subtopics: ['Typing practice', 'Educational apps', 'Drawing software', 'Simple presentations'], gradeLevel: 'Grade 2', term: 'Term 1'),
  Topic(id: 'g2_ict_2', subjectId: 'g2_ict', name: 'Digital Citizenship', description: 'Responsible technology use', subtopics: ['Online safety', 'Cyberbullying awareness', 'Privacy basics', 'Positive online behaviour'], gradeLevel: 'Grade 2', term: 'Term 2'),

  // ========== GRADE 3 - ADDITIONAL SUBJECTS ==========
  Topic(id: 'g3_eng_1', subjectId: 'g3_eng', name: 'Advanced Reading', description: 'Developing reading fluency', subtopics: ['Reading aloud', 'Reading comprehension', 'Vocabulary building', 'Reading for information'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_eng_2', subjectId: 'g3_eng', name: 'Paragraph Writing', description: 'Structured writing skills', subtopics: ['Topic sentences', 'Supporting details', 'Paragraph organisation', 'Descriptive writing'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_eng_3', subjectId: 'g3_eng', name: 'Public Speaking', description: 'Oral communication and presentation', subtopics: ['Show and tell', 'Reciting poems', 'Simple speeches', 'Group discussions'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_mat_1', subjectId: 'g3_mat', name: 'Fractions and Decimals', description: 'Understanding parts of a whole', subtopics: ['Halves and quarters', 'Unit fractions', 'Decimal basics', 'Fraction equivalence'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_mat_2', subjectId: 'g3_mat', name: 'Time and Money', description: 'Telling time and handling money', subtopics: ['Reading clocks', 'Time calculations', 'Money operations', 'Budgeting basics'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_mat_3', subjectId: 'g3_mat', name: 'Data Handling', description: 'Collecting and interpreting data', subtopics: ['Pictographs', 'Bar graphs', 'Data collection', 'Interpreting results'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_sho_1', subjectId: 'g3_sho', name: 'Language and Grammar', description: 'Indigenous language structure', subtopics: ['Nouns and pronouns', 'Verbs and tenses', 'Sentence construction', 'Spelling rules'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_sho_2', subjectId: 'g3_sho', name: 'Poetry and Proverbs', description: 'Appreciating indigenous literary forms', subtopics: ['Traditional poems', 'Proverbs and meanings', 'Idioms', 'Creating poems'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_hss_1', subjectId: 'g3_hss', name: 'Zimbabwe Provinces', description: 'Geography of Zimbabwe', subtopics: ['10 provinces', 'Provincial capitals', 'Physical features', 'Natural resources'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_hss_2', subjectId: 'g3_hss', name: 'Heritage Sites', description: 'Zimbabwean heritage and tourism', subtopics: ['Great Zimbabwe', 'Victoria Falls', 'Eastern Highlands', 'National parks'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_sci_1', subjectId: 'g3_sci', name: 'Plants and Animals', description: 'Understanding living organisms', subtopics: ['Plant classification', 'Animal classification', 'Habitats', 'Food chains'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_sci_2', subjectId: 'g3_sci', name: 'Energy and Forces', description: 'Basic physical science', subtopics: ['Forms of energy', 'Forces and motion', 'Magnets', 'Sound and light'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_agr_1', subjectId: 'g3_agr', name: 'Plant Growth', description: 'How plants grow and develop', subtopics: ['Seed germination', 'Planting techniques', 'Watering and care', 'Harvesting'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_agr_2', subjectId: 'g3_agr', name: 'Soil and Environment', description: 'Understanding soil and conservation', subtopics: ['Soil types', 'Soil preparation', 'Compost making', 'Environmental care'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_vpa_1', subjectId: 'g3_vpa', name: 'Art Appreciation', description: 'Understanding and creating art', subtopics: ['Colour theory', 'Drawing techniques', 'Traditional crafts', 'Art exhibition'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_vpa_2', subjectId: 'g3_vpa', name: 'Music Instruments', description: 'Learning musical instruments', subtopics: ['Traditional instruments', 'Marimba basics', 'Percussion', 'Group performance'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_frm_1', subjectId: 'g3_frm', name: 'Community Responsibility', description: 'Being part of a community', subtopics: ['Community service', 'Environmental care', 'Helping others', 'Being a good citizen'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_frm_2', subjectId: 'g3_frm', name: 'Ethical Values', description: 'Making good choices', subtopics: ['Honesty and integrity', 'Fairness', 'Compassion', 'Forgiveness'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_pe_1', subjectId: 'g3_pe', name: 'Athletics', description: 'Track and field fundamentals', subtopics: ['Sprinting', 'Long jump', 'Relay races', 'Throwing events'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_pe_2', subjectId: 'g3_pe', name: 'Ball Games', description: 'Introduction to team sports', subtopics: ['Soccer basics', 'Netball basics', 'Handball', 'Teamwork skills'], gradeLevel: 'Grade 3', term: 'Term 2'),
  Topic(id: 'g3_ict_1', subjectId: 'g3_ict', name: 'Word Processing', description: 'Creating and formatting documents', subtopics: ['Typing skills', 'Formatting text', 'Inserting images', 'Saving and printing'], gradeLevel: 'Grade 3', term: 'Term 1'),
  Topic(id: 'g3_ict_2', subjectId: 'g3_ict', name: 'Internet Basics', description: 'Using the internet safely', subtopics: ['Web browsing', 'Online search', 'Email basics', 'Internet safety'], gradeLevel: 'Grade 3', term: 'Term 2'),

  // ========== GRADE 4 ==========
  Topic(id: 'g4_eng_1', subjectId: 'g4_eng', name: 'Composition Writing', description: 'Developing essay writing skills', subtopics: ['Essay structure', 'Narrative essays', 'Descriptive essays', 'Editing and revision'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_eng_2', subjectId: 'g4_eng', name: 'Reading Fluency', description: 'Advanced reading strategies', subtopics: ['Reading speed', 'Understanding inference', 'Critical reading', 'Book reports'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_eng_3', subjectId: 'g4_eng', name: 'Vocabulary Expansion', description: 'Building rich vocabulary', subtopics: ['Synonyms and antonyms', 'Homophones', 'Prefixes and suffixes', 'Dictionary skills'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_mat_1', subjectId: 'g4_mat', name: 'Decimals and Percentages', description: 'Working with decimals and percentages', subtopics: ['Decimal place value', 'Converting fractions to decimals', 'Percentage concepts', 'Real-world applications'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_mat_2', subjectId: 'g4_mat', name: 'Geometry', description: 'Shapes angles and space', subtopics: ['Angles and measurement', 'Triangles and quadrilaterals', 'Area and perimeter', 'Symmetry'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_mat_3', subjectId: 'g4_mat', name: 'Problem Solving', description: 'Mathematical reasoning', subtopics: ['Word problems', 'Multi-step problems', 'Estimation', 'Logical reasoning'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_sho_1', subjectId: 'g4_sho', name: 'Creative Writing', description: 'Writing in indigenous language', subtopics: ['Story writing', 'Letter writing', 'Poetry writing', 'Descriptive essays'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_sho_2', subjectId: 'g4_sho', name: 'Idioms and Figurative Language', description: 'Understanding figurative expressions', subtopics: ['Common idioms', 'Similes and metaphors', 'Cultural sayings', 'Using idioms in writing'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_hss_1', subjectId: 'g4_hss', name: 'Zimbabwean History', description: 'History of Zimbabwe', subtopics: ['Early societies', 'Great Zimbabwe civilization', 'Colonial period', 'Independence'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_hss_2', subjectId: 'g4_hss', name: 'Governance and Citizenship', description: 'How Zimbabwe is governed', subtopics: ['Government structure', 'Rights and responsibilities', 'The constitution', 'Voting and democracy'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_sci_1', subjectId: 'g4_sci', name: 'Human Body', description: 'Understanding the human body', subtopics: ['Body systems', 'Digestive system', 'Respiratory system', 'Circulatory system'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_sci_2', subjectId: 'g4_sci', name: 'Ecosystems', description: 'Understanding ecosystems and environments', subtopics: ['Habitats', 'Food webs', 'Adaptations', 'Conservation'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_sci_3', subjectId: 'g4_sci', name: 'Forces and Light', description: 'Physical phenomena', subtopics: ['Types of forces', 'Light and shadows', 'Reflection and refraction', 'Simple circuits'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_agr_1', subjectId: 'g4_agr', name: 'Livestock Management', description: 'Caring for farm animals', subtopics: ['Cattle care', 'Goat and sheep keeping', 'Poultry farming', 'Animal health'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_agr_2', subjectId: 'g4_agr', name: 'Vegetable Production', description: 'Growing vegetables', subtopics: ['Bed preparation', 'Seed selection', 'Crop care', 'Pest management'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_vpa_1', subjectId: 'g4_vpa', name: 'Design and Sculpture', description: 'Three-dimensional art', subtopics: ['Clay modeling', 'Wire sculpture', 'Beadwork', 'Design principles'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_vpa_2', subjectId: 'g4_vpa', name: 'Traditional Dance', description: 'Zimbabwean traditional dance', subtopics: ['Mbira dance', 'Jerusarema', 'Amabhiza', 'Dance performance'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_frm_1', subjectId: 'g4_frm', name: 'Ethical Leadership', description: 'Learning about leadership and ethics', subtopics: ['Qualities of a leader', 'Making ethical decisions', 'Religious teachings on ethics', 'Community leadership'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_frm_2', subjectId: 'g4_frm', name: 'Religious Texts', description: 'Sacred texts and teachings', subtopics: ['Biblical stories', 'African traditional religion', 'Sacred writings', 'Moral lessons from scriptures'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_pe_1', subjectId: 'g4_pe', name: 'Gymnastics', description: 'Body control and flexibility', subtopics: ['Forward rolls', 'Balancing', 'Stretching routines', 'Floor exercises'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_pe_2', subjectId: 'g4_pe', name: 'Swimming Basics', description: 'Water safety and swimming', subtopics: ['Water confidence', 'Floating', 'Basic strokes', 'Water safety rules'], gradeLevel: 'Grade 4', term: 'Term 2'),
  Topic(id: 'g4_ict_1', subjectId: 'g4_ict', name: 'Spreadsheets', description: 'Introduction to spreadsheets', subtopics: ['Cells and ranges', 'Data entry', 'Simple formulas', 'Creating charts'], gradeLevel: 'Grade 4', term: 'Term 1'),
  Topic(id: 'g4_ict_2', subjectId: 'g4_ict', name: 'Presentations', description: 'Creating effective presentations', subtopics: ['Slide design', 'Adding content', 'Animations', 'Presentation skills'], gradeLevel: 'Grade 4', term: 'Term 2'),

  // ========== GRADE 5 ==========
  Topic(id: 'g5_eng_1', subjectId: 'g5_eng', name: 'Essay Writing', description: 'Advanced composition skills', subtopics: ['Argumentative essays', 'Expository writing', 'Persuasive writing', 'Essay planning'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_eng_2', subjectId: 'g5_eng', name: 'Literary Analysis', description: 'Analyzing literature', subtopics: ['Story elements', 'Character analysis', 'Theme identification', 'Literary devices'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_eng_3', subjectId: 'g5_eng', name: 'Advanced Grammar', description: 'Mastering English grammar', subtopics: ['Complex sentences', 'Clauses and phrases', 'Direct and indirect speech', 'Punctuation mastery'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_mat_1', subjectId: 'g5_mat', name: 'Ratio and Proportion', description: 'Understanding proportional relationships', subtopics: ['Ratio concepts', 'Equivalent ratios', 'Direct proportion', 'Scale drawings'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_mat_2', subjectId: 'g5_mat', name: 'Introduction to Algebra', description: 'Basic algebraic concepts', subtopics: ['Using variables', 'Simple equations', 'Number patterns', 'Function machines'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_mat_3', subjectId: 'g5_mat', name: 'Angles and Graphs', description: 'Geometry and data representation', subtopics: ['Angle types', 'Measuring angles', 'Coordinate graphs', 'Interpreting graphs'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_sho_1', subjectId: 'g5_sho', name: 'Advanced Literature', description: 'Studying indigenous literature', subtopics: ['Novel studies', 'Poetry analysis', 'Drama scripts', 'Literary appreciation'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_sho_2', subjectId: 'g5_sho', name: 'Formal Writing', description: 'Academic writing in indigenous language', subtopics: ['Report writing', 'Letter writing formal', 'Essay structure', 'Grammar refinement'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_hss_1', subjectId: 'g5_hss', name: 'African History', description: 'African civilizations and heritage', subtopics: ['Ancient Africa', 'Kingdom of Zimbabwe', 'Trans-Atlantic slave trade', 'Scramble for Africa'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_hss_2', subjectId: 'g5_hss', name: 'Liberation Struggle', description: 'Zimbabwe liberation history', subtopics: ['Colonial rule', 'Nationalist movements', 'Chimurenga', 'Independence 1980'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_sci_1', subjectId: 'g5_sci', name: 'Matter and Materials', description: 'Properties and changes of matter', subtopics: ['States of matter', 'Changing states', 'Mixtures and solutions', 'Material properties'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_sci_2', subjectId: 'g5_sci', name: 'Energy Systems', description: 'Understanding energy', subtopics: ['Forms of energy', 'Energy transfer', 'Electricity', 'Renewable energy'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_sci_3', subjectId: 'g5_sci', name: 'Astronomy', description: 'Exploring space and the universe', subtopics: ['Solar system', 'Earth and moon', 'Stars and constellations', 'Space exploration'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_agr_1', subjectId: 'g5_agr', name: 'Crop Production', description: 'Advanced crop cultivation', subtopics: ['Crop rotation', 'Soil fertility', 'Irrigation methods', 'Pest and disease control'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_agr_2', subjectId: 'g5_agr', name: 'Agribusiness', description: 'Farming as a business', subtopics: ['Marketing produce', 'Record keeping', 'Farm budgeting', 'Value addition'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_vpa_1', subjectId: 'g5_vpa', name: 'Advanced Art', description: 'Refining artistic techniques', subtopics: ['Perspective drawing', 'Watercolour painting', 'Mixed media', 'Art criticism'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_vpa_2', subjectId: 'g5_vpa', name: 'Choreography', description: 'Creating dance performances', subtopics: ['Dance composition', 'Movement sequences', 'Choreographic devices', 'Group performance'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_frm_1', subjectId: 'g5_frm', name: 'Global Ethics', description: 'Ethical issues in global context', subtopics: ['Human rights', 'Social justice', 'Environmental ethics', 'Peace and conflict'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_frm_2', subjectId: 'g5_frm', name: 'Interfaith Dialogue', description: 'Understanding different religions', subtopics: ['Christianity', 'Islam', 'African Traditional Religion', 'Religious tolerance'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_pe_1', subjectId: 'g5_pe', name: 'Competitive Sports', description: 'Team sports and competition', subtopics: ['Soccer skills', 'Netball skills', 'Athletics events', 'Sportsmanship'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_pe_2', subjectId: 'g5_pe', name: 'Fitness and First Aid', description: 'Physical fitness and emergency care', subtopics: ['Fitness assessment', 'Exercise programmes', 'Basic first aid', 'Injury prevention'], gradeLevel: 'Grade 5', term: 'Term 2'),
  Topic(id: 'g5_ict_1', subjectId: 'g5_ict', name: 'Programming Basics', description: 'Introduction to coding', subtopics: ['Block-based coding', 'Sequences', 'Loops and conditionals', 'Simple animations'], gradeLevel: 'Grade 5', term: 'Term 1'),
  Topic(id: 'g5_ict_2', subjectId: 'g5_ict', name: 'Multimedia Creation', description: 'Creating digital content', subtopics: ['Digital photography', 'Video editing', 'Audio recording', 'Digital storytelling'], gradeLevel: 'Grade 5', term: 'Term 2'),

  // ========== GRADE 6 ==========
  Topic(id: 'g6_eng_1', subjectId: 'g6_eng', name: 'Critical Reading', description: 'Advanced reading and analysis', subtopics: ['Critical thinking', 'Bias and perspective', 'Fact vs opinion', 'Evaluating sources'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_eng_2', subjectId: 'g6_eng', name: 'Research Skills', description: 'Academic research and writing', subtopics: ['Finding information', 'Note taking', 'Organizing ideas', 'Research reports'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_eng_3', subjectId: 'g6_eng', name: 'Debate and Persuasion', description: 'Articulating arguments effectively', subtopics: ['Debate structure', 'Persuasive techniques', 'Rebuttal skills', 'Public speaking'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_mat_1', subjectId: 'g6_mat', name: 'Advanced Algebra', description: 'Complex algebraic concepts', subtopics: ['Linear equations', 'Inequalities', 'Simultaneous equations', 'Factorisation'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_mat_2', subjectId: 'g6_mat', name: 'Probability', description: 'Understanding chance and probability', subtopics: ['Probability scale', 'Experimental probability', 'Theoretical probability', 'Tree diagrams'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_mat_3', subjectId: 'g6_mat', name: 'Transformations', description: 'Geometric transformations', subtopics: ['Reflection', 'Rotation', 'Translation', 'Enlargement'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_sho_1', subjectId: 'g6_sho', name: 'Classical Literature', description: 'Studying classic indigenous texts', subtopics: ['Classic novels', 'Epic poetry', 'Traditional drama', 'Literary criticism'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_sho_2', subjectId: 'g6_sho', name: 'Indigenous Knowledge', description: 'Traditional knowledge systems', subtopics: ['Traditional medicine', 'Indigenous technologies', 'Cultural practices', 'Knowledge preservation'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_hss_1', subjectId: 'g6_hss', name: 'Global Citizenship', description: 'Being a global citizen', subtopics: ['Global issues', 'Cultural diversity', 'Sustainable development', 'International cooperation'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_hss_2', subjectId: 'g6_hss', name: 'Heritage Tourism', description: 'Zimbabwe heritage and tourism', subtopics: ['Tourism industry', 'Heritage promotion', 'Ecotourism', 'Career opportunities'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_sci_1', subjectId: 'g6_sci', name: 'Chemistry Basics', description: 'Introduction to chemistry', subtopics: ['Elements and compounds', 'Chemical reactions', 'Acids and bases', 'Metals and non-metals'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_sci_2', subjectId: 'g6_sci', name: 'Genetics and Ecology', description: 'Heredity and environment', subtopics: ['Inherited traits', 'Adaptation', 'Ecosystem dynamics', 'Biodiversity'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_sci_3', subjectId: 'g6_sci', name: 'Space Science', description: 'Advanced space concepts', subtopics: ['Earth in space', 'Gravity', 'Satellites', 'Space exploration technology'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_agr_1', subjectId: 'g6_agr', name: 'Commercial Farming', description: 'Large-scale agriculture', subtopics: ['Farm planning', 'Mechanisation', 'Crop marketing', 'Export standards'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_agr_2', subjectId: 'g6_agr', name: 'Agricultural Policy', description: 'Food systems and policy', subtopics: ['Food security', 'Agricultural policies', 'Climate-smart agriculture', 'Entrepreneurship'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_vpa_1', subjectId: 'g6_vpa', name: 'Portfolio Development', description: 'Building an art portfolio', subtopics: ['Art collection', 'Theme development', 'Technique mastery', 'Portfolio presentation'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_vpa_2', subjectId: 'g6_vpa', name: 'Arts Entrepreneurship', description: 'Monetising artistic skills', subtopics: ['Art business', 'Exhibition planning', 'Arts marketing', 'Creative careers'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_frm_1', subjectId: 'g6_frm', name: 'Social Justice', description: 'Understanding fairness and equality', subtopics: ['Equality and equity', 'Human dignity', 'Advocacy', 'Community action'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_frm_2', subjectId: 'g6_frm', name: 'Moral Leadership', description: 'Leading with integrity', subtopics: ['Ethical decision-making', 'Servant leadership', 'Role models', 'Influence and impact'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_pe_1', subjectId: 'g6_pe', name: 'Sports Leadership', description: 'Leading sports teams', subtopics: ['Team captaincy', 'Coaching basics', 'Event organisation', 'Sports administration'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_pe_2', subjectId: 'g6_pe', name: 'Lifetime Fitness', description: 'Health and fitness for life', subtopics: ['Personal fitness plans', 'Lifestyle diseases', 'Nutrition science', 'Mental wellness'], gradeLevel: 'Grade 6', term: 'Term 2'),
  Topic(id: 'g6_ict_1', subjectId: 'g6_ict', name: 'Web Design', description: 'Creating websites', subtopics: ['HTML basics', 'CSS styling', 'Web structure', 'Publishing sites'], gradeLevel: 'Grade 6', term: 'Term 1'),
  Topic(id: 'g6_ict_2', subjectId: 'g6_ict', name: 'Databases', description: 'Organizing and managing data', subtopics: ['Database concepts', 'Tables and records', 'Queries', 'Data management'], gradeLevel: 'Grade 6', term: 'Term 2'),

  // ========== GRADE 7 ==========
  Topic(id: 'g7_eng_1', subjectId: 'g7_eng', name: 'Exam Preparation', description: 'Grade 7 exam readiness', subtopics: ['Past paper practice', 'Exam techniques', 'Time management', 'Common errors'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_eng_2', subjectId: 'g7_eng', name: 'Literary Criticism', description: 'Evaluating literature', subtopics: ['Critical analysis', 'Comparative essays', 'Literary theories', 'Textual evidence'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_eng_3', subjectId: 'g7_eng', name: 'Media Literacy', description: 'Understanding media and communication', subtopics: ['News analysis', 'Advertising techniques', 'Digital media', 'Media ethics'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_mat_1', subjectId: 'g7_mat', name: 'Pre-Algebra', description: 'Algebraic foundations', subtopics: ['Algebraic expressions', 'Linear equations', 'Inequalities', 'Patterns and sequences'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_mat_2', subjectId: 'g7_mat', name: 'Geometry Proofs', description: 'Geometric reasoning', subtopics: ['Angles in polygons', 'Pythagoras theorem', 'Circle geometry', 'Geometric proofs'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_mat_3', subjectId: 'g7_mat', name: 'Statistics', description: 'Data analysis and interpretation', subtopics: ['Mean median mode', 'Data distribution', 'Probability', 'Statistical reports'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_sho_1', subjectId: 'g7_sho', name: 'Language Mastery', description: 'Advanced indigenous language skills', subtopics: ['Complex grammar', 'Advanced composition', 'Translation skills', 'Language research'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_sho_2', subjectId: 'g7_sho', name: 'Cultural Preservation', description: 'Preserving Zimbabwean heritage', subtopics: ['Oral traditions documentation', 'Cultural festivals', 'Heritage projects', 'Community engagement'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_hss_1', subjectId: 'g7_hss', name: 'Zimbabwe in the World', description: 'Zimbabwe global context', subtopics: ['International relations', 'Global economy', 'Diplomacy', 'Zimbabwe in Africa'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_hss_2', subjectId: 'g7_hss', name: 'Civic Responsibility', description: 'Active citizenship', subtopics: ['Civic duties', 'Volunteerism', 'Environmental stewardship', 'Community development'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_sci_1', subjectId: 'g7_sci', name: 'Integrated Science', description: 'Comprehensive science review', subtopics: ['Scientific inquiry', 'Biology review', 'Chemistry review', 'Physics review'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_sci_2', subjectId: 'g7_sci', name: 'Environmental Chemistry', description: 'Chemistry in the environment', subtopics: ['Water quality', 'Air pollution', 'Soil chemistry', 'Green chemistry'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_agr_1', subjectId: 'g7_agr', name: 'Sustainable Agriculture', description: 'Farming for the future', subtopics: ['Conservation farming', 'Organic farming', 'Water harvesting', 'Climate resilience'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_agr_2', subjectId: 'g7_agr', name: 'Food Systems', description: 'From farm to table', subtopics: ['Food processing', 'Food safety', 'Nutrition', 'Food supply chains'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_vpa_1', subjectId: 'g7_vpa', name: 'Art Mastery', description: 'Mastering artistic expression', subtopics: ['Advanced techniques', 'Artistic voice', 'Exhibition preparation', 'Art portfolio'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_vpa_2', subjectId: 'g7_vpa', name: 'Arts Leadership', description: 'Leading creative projects', subtopics: ['Community arts', 'Event production', 'Mentorship', 'Arts advocacy'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_frm_1', subjectId: 'g7_frm', name: 'Life Skills', description: 'Essential life skills', subtopics: ['Decision making', 'Goal setting', 'Conflict resolution', 'Financial literacy'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_frm_2', subjectId: 'g7_frm', name: 'Career Guidance', description: 'Planning for the future', subtopics: ['Career exploration', 'Subject choices', 'Further education', 'Entrepreneurship'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_pe_1', subjectId: 'g7_pe', name: 'Advanced Sports', description: 'Specialised sport skills', subtopics: ['Sport-specific training', 'Tactics and strategy', 'Performance analysis', 'Competition preparation'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_pe_2', subjectId: 'g7_pe', name: 'Health Promotion', description: 'Promoting health and wellness', subtopics: ['Public health', 'Disease prevention', 'Reproductive health', 'Healthy communities'], gradeLevel: 'Grade 7', term: 'Term 2'),
  Topic(id: 'g7_ict_1', subjectId: 'g7_ict', name: 'Advanced Computing', description: 'Advanced computer concepts', subtopics: ['Robotics basics', 'Programming fundamentals', 'System analysis', 'IT project management'], gradeLevel: 'Grade 7', term: 'Term 1'),
  Topic(id: 'g7_ict_2', subjectId: 'g7_ict', name: 'Technology Innovation', description: 'Innovating with technology', subtopics: ['Design thinking', 'Prototyping', 'Tech entrepreneurship', 'Emerging technologies'], gradeLevel: 'Grade 7', term: 'Term 2'),

  // ========== FORM 2 ==========
  Topic(id: 'o2_eng_1', subjectId: 'o2_eng', name: 'Critical Analysis', description: 'Analysing texts critically', subtopics: ['Critical reading strategies', 'Argument analysis', 'Comparative analysis', 'Evaluating evidence'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_eng_2', subjectId: 'o2_eng', name: 'Essay Writing', description: 'Advanced essay techniques', subtopics: ['Thesis statements', 'Essay structure', 'Persuasive essays', 'Research essays'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_eng_3', subjectId: 'o2_eng', name: 'Research Skills', description: 'Academic research methods', subtopics: ['Research methods', 'Source evaluation', 'Referencing', 'Research project'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_mat_1', subjectId: 'o2_mat', name: 'Sets and Relations', description: 'Mathematical sets and relations', subtopics: ['Set notation', 'Venn diagrams', 'Relations and functions', 'Mapping diagrams'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_mat_2', subjectId: 'o2_mat', name: 'Matrices', description: 'Introduction to matrices', subtopics: ['Matrix operations', 'Matrix multiplication', 'Determinants', 'Applications of matrices'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_mat_3', subjectId: 'o2_mat', name: 'Advanced Problem Solving', description: 'Complex mathematical problems', subtopics: ['Problem-solving strategies', 'Mathematical modeling', 'Past paper practice', 'Olympiad problems'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_sho_1', subjectId: 'o2_sho', name: 'Prose and Poetry', description: 'Indigenous literary forms', subtopics: ['Novel analysis', 'Poetry appreciation', 'Prose techniques', 'Literary devices'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_sho_2', subjectId: 'o2_sho', name: 'Drama Studies', description: 'Indigenous drama and theatre', subtopics: ['Play analysis', 'Character development', 'Theatre conventions', 'Performance skills'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_sci_1', subjectId: 'o2_sci', name: 'Cell Biology', description: 'Advanced cellular biology', subtopics: ['Cell structure and function', 'Cell division mitosis', 'Cell specialisation', 'Tissues and organs'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_sci_2', subjectId: 'o2_sci', name: 'Chemical Reactions', description: 'Types of chemical reactions', subtopics: ['Chemical equations', 'Types of reactions', 'Rates of reaction', 'Energy in reactions'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_sci_3', subjectId: 'o2_sci', name: 'Forces and Energy', description: 'Advanced physical science', subtopics: ['Newton laws of motion', 'Work energy power', 'Pressure', 'Heat transfer'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_his_1', subjectId: 'o2_his', name: 'Colonial Zimbabwe', description: 'Zimbabwe under colonial rule', subtopics: ['British colonisation', 'Early resistance', 'Land alienation', 'Colonial administration'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_his_2', subjectId: 'o2_his', name: 'Liberation Struggle', description: 'The fight for independence', subtopics: ['Nationalist movements', 'Armed struggle', 'International solidarity', 'Lancaster House'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_geo_1', subjectId: 'o2_geo', name: 'Climate Studies', description: 'Climate and weather patterns', subtopics: ['Climate of Zimbabwe', 'Climate factors', 'Weather systems', 'Climate change impacts'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_geo_2', subjectId: 'o2_geo', name: 'Population Studies', description: 'Human geography and population', subtopics: ['Population distribution', 'Population growth', 'Urbanisation', 'Migration'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_agr_1', subjectId: 'o2_agr', name: 'Soil Science', description: 'Understanding soil', subtopics: ['Soil formation', 'Soil types', 'Soil fertility', 'Soil conservation'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_agr_2', subjectId: 'o2_agr', name: 'Crop and Livestock', description: 'Production management', subtopics: ['Crop production systems', 'Livestock breeding', 'Animal nutrition', 'Farm records'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_bus_1', subjectId: 'o2_bus', name: 'Business Principles', description: 'Foundations of commerce', subtopics: ['Nature of business', 'Business objectives', 'Types of businesses', 'Business ethics'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_bus_2', subjectId: 'o2_bus', name: 'Trade and Banking', description: 'Commerce and financial services', subtopics: ['Retail and wholesale', 'International trade', 'Banking services', 'Insurance'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_frm_1', subjectId: 'o2_frm', name: 'Moral Philosophy', description: 'Ethical thinking and philosophy', subtopics: ['Moral theories', 'Ethical dilemmas', 'Philosophical inquiry', 'Applied ethics'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_frm_2', subjectId: 'o2_frm', name: 'Religious Diversity', description: 'Understanding world religions', subtopics: ['World religions', 'Religious practices', 'Interfaith understanding', 'Religious harmony'], gradeLevel: 'Form 2', term: 'Term 2'),
  Topic(id: 'o2_pe_1', subjectId: 'o2_pe', name: 'Advanced Sports', description: 'Developing sports excellence', subtopics: ['Sport coaching', 'Training programmes', 'Sports psychology', 'Competition'], gradeLevel: 'Form 2', term: 'Term 1'),
  Topic(id: 'o2_pe_2', subjectId: 'o2_pe', name: 'Sports Science', description: 'Scientific principles of sport', subtopics: ['Exercise physiology', 'Biomechanics', 'Sports nutrition', 'Injury management'], gradeLevel: 'Form 2', term: 'Term 2'),

  // ========== FORM 3 ==========
  Topic(id: 'o3_eng_1', subjectId: 'o3_eng', name: 'Comprehension Skills', description: 'Advanced comprehension', subtopics: ['Passage analysis', 'Summary writing', 'Inference skills', 'Vocabulary in context'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_eng_2', subjectId: 'o3_eng', name: 'Set Books Analysis', description: 'Studying O-Level set books', subtopics: ['Novel analysis', 'Drama analysis', 'Poetry anthology', 'Exam questions'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_eng_3', subjectId: 'o3_eng', name: 'Exam Techniques', description: 'O-Level exam strategies', subtopics: ['Past paper practice', 'Timed essays', 'Marking schemes', 'Common pitfalls'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_mat_1', subjectId: 'o3_mat', name: 'Coordinate Geometry', description: 'Graphs and coordinates', subtopics: ['Gradient and intercept', 'Equation of a line', 'Parallel and perpendicular', 'Graphical solutions'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_mat_2', subjectId: 'o3_mat', name: 'Calculus Introduction', description: 'Basic calculus concepts', subtopics: ['Rate of change', 'Differentiation', 'Gradient of curves', 'Stationary points'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_mat_3', subjectId: 'o3_mat', name: 'Transformations', description: 'Geometric transformations', subtopics: ['Translation vectors', 'Reflection matrices', 'Rotation', 'Enlargement scale factor'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_sho_1', subjectId: 'o3_sho', name: 'Set Books', description: 'O-Level set book studies', subtopics: ['Novel study', 'Play study', 'Poetry study', 'Exam preparation'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_sho_2', subjectId: 'o3_sho', name: 'Advanced Composition', description: 'Mastering written expression', subtopics: ['Creative writing', 'Formal writing', 'Argumentative essays', 'Language precision'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_bio_1', subjectId: 'o3_bio', name: 'Cell Biology', description: 'Advanced cell structure and function', subtopics: ['Cell organelles', 'Cell transport', 'Enzyme biology', 'Cell division meiosis'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_bio_2', subjectId: 'o3_bio', name: 'Genetics', description: 'Principles of heredity', subtopics: ['DNA structure', 'Gene expression', 'Inheritance patterns', 'Genetic engineering'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_bio_3', subjectId: 'o3_bio', name: 'Ecology', description: 'Ecosystems and environment', subtopics: ['Ecosystem structure', 'Energy flow', 'Nutrient cycles', 'Conservation'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_che_1', subjectId: 'o3_che', name: 'Atomic Structure', description: 'Understanding the atom', subtopics: ['Atomic models', 'Electron configuration', 'Periodic table', 'Chemical bonding'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_che_2', subjectId: 'o3_che', name: 'Organic Chemistry', description: 'Carbon chemistry basics', subtopics: ['Hydrocarbons', 'Functional groups', 'Alkanes and alkenes', 'Organic reactions'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_che_3', subjectId: 'o3_che', name: 'Chemical Analysis', description: 'Analytical chemistry', subtopics: ['Qualitative analysis', 'Quantitative analysis', 'Titration', 'Instrumentation'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_phy_1', subjectId: 'o3_phy', name: 'Mechanics', description: 'Laws of motion and forces', subtopics: ['Scalars and vectors', 'Newton laws', 'Momentum', 'Energy conservation'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_phy_2', subjectId: 'o3_phy', name: 'Waves', description: 'Wave phenomena', subtopics: ['Wave properties', 'Sound waves', 'Light waves', 'Electromagnetic spectrum'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_phy_3', subjectId: 'o3_phy', name: 'Electricity and Magnetism', description: 'Electrical and magnetic phenomena', subtopics: ['Electric circuits', 'Ohm law', 'Magnetic fields', 'Electromagnetism'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_his_1', subjectId: 'o3_his', name: 'International Affairs', description: 'Global history 1900-1945', subtopics: ['World War I', 'League of Nations', 'World War II', 'Cold War origins'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_his_2', subjectId: 'o3_his', name: 'Contemporary Issues', description: 'Modern global developments', subtopics: ['UN and global governance', 'Human rights', 'Globalisation', 'Conflict resolution'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_geo_1', subjectId: 'o3_geo', name: 'Geomorphology', description: 'Landform processes', subtopics: ['Weathering and erosion', 'River processes', 'Glacial landscapes', 'Coastal processes'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_geo_2', subjectId: 'o3_geo', name: 'Environmental Management', description: 'Managing the environment', subtopics: ['Resource management', 'Pollution control', 'Environmental policy', 'Sustainable development'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_acc_1', subjectId: 'o3_acc', name: 'Financial Accounting', description: 'Accounting fundamentals', subtopics: ['Double entry', 'Ledger accounts', 'Trial balance', 'Financial statements'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_acc_2', subjectId: 'o3_acc', name: 'Bookkeeping', description: 'Bookkeeping principles', subtopics: ['Cash book', 'Sales and purchases', 'Returns and discounts', 'Bank reconciliation'], gradeLevel: 'Form 3', term: 'Term 2'),
  Topic(id: 'o3_eco_1', subjectId: 'o3_eco', name: 'Microeconomics', description: 'Individual economic agents', subtopics: ['Demand and supply', 'Market equilibrium', 'Price elasticity', 'Production costs'], gradeLevel: 'Form 3', term: 'Term 1'),
  Topic(id: 'o3_eco_2', subjectId: 'o3_eco', name: 'Macroeconomics', description: 'Economy-wide phenomena', subtopics: ['National income', 'Inflation', 'Unemployment', 'Economic growth'], gradeLevel: 'Form 3', term: 'Term 2'),

  // ========== FORM 4 ==========
  Topic(id: 'o4_eng_1', subjectId: 'o4_eng', name: 'Exam Preparation', description: 'O-Level English exam readiness', subtopics: ['Past paper practice', 'Exam strategies', 'Time management', 'Common mistakes'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_eng_2', subjectId: 'o4_eng', name: 'Revision', description: 'Comprehensive English revision', subtopics: ['Grammar revision', 'Essay revision', 'Comprehension revision', 'Summary writing'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_eng_3', subjectId: 'o4_eng', name: 'Final Preparation', description: 'Final exam preparation', subtopics: ['Mock exams', 'Feedback review', 'Weakness improvement', 'Confidence building'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_mat_1', subjectId: 'o4_mat', name: 'Comprehensive Revision', description: 'Complete O-Level math revision', subtopics: ['Number revision', 'Algebra revision', 'Geometry revision', 'Statistics revision'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_mat_2', subjectId: 'o4_mat', name: 'Exam Techniques', description: 'O-Level math exam strategies', subtopics: ['Past paper analysis', 'Problem-solving strategies', 'Mark scheme understanding', 'Speed and accuracy'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_sho_1', subjectId: 'o4_sho', name: 'Set Books Revision', description: 'O-Level set book mastery', subtopics: ['Novel revision', 'Play revision', 'Poetry revision', 'Exam questions'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_sho_2', subjectId: 'o4_sho', name: 'Language Mastery', description: 'Advanced language preparation', subtopics: ['Grammar mastery', 'Essay techniques', 'Comprehension skills', 'Oral exam prep'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_bio_1', subjectId: 'o4_bio', name: 'Biology Revision', description: 'O-Level biology revision', subtopics: ['Cell biology revision', 'Genetics revision', 'Ecology revision', 'Human biology'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_bio_2', subjectId: 'o4_bio', name: 'Practical Skills', description: 'Biology practical exam prep', subtopics: ['Lab techniques', 'Microscopy', 'Experiments', 'Data analysis'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_che_1', subjectId: 'o4_che', name: 'Chemistry Revision', description: 'O-Level chemistry revision', subtopics: ['Physical chemistry', 'Inorganic chemistry', 'Organic chemistry', 'Calculations'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_che_2', subjectId: 'o4_che', name: 'Quantitative Analysis', description: 'Chemical calculations and analysis', subtopics: ['Mole concept', 'Concentration', 'Titration calculations', 'Empirical formulas'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_phy_1', subjectId: 'o4_phy', name: 'Physics Revision', description: 'O-Level physics revision', subtopics: ['Mechanics revision', 'Waves revision', 'Electricity revision', 'Modern physics'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_phy_2', subjectId: 'o4_phy', name: 'Practical Physics', description: 'Physics practical exam prep', subtopics: ['Measurement techniques', 'Circuit construction', 'Graph analysis', 'Experimental errors'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_his_1', subjectId: 'o4_his', name: 'History Revision', description: 'O-Level history revision', subtopics: ['Zimbabwe history', 'African history', 'World history', 'Source analysis'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_his_2', subjectId: 'o4_his', name: 'Exam Strategies', description: 'History exam techniques', subtopics: ['Essay writing techniques', 'Source interpretation', 'Past papers', 'Revision strategies'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_geo_1', subjectId: 'o4_geo', name: 'Geography Revision', description: 'O-Level geography revision', subtopics: ['Physical geography', 'Human geography', 'Map work', 'Case studies'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_geo_2', subjectId: 'o4_geo', name: 'Map Work Skills', description: 'Advanced map reading and interpretation', subtopics: ['Topographic maps', 'Cross sections', 'Landform identification', 'Settlement patterns'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_agr_1', subjectId: 'o4_agr', name: 'Agriculture Revision', description: 'O-Level agriculture revision', subtopics: ['Crop production revision', 'Livestock revision', 'Farm management', 'Agricultural economics'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_agr_2', subjectId: 'o4_agr', name: 'Farm Projects', description: 'Practical farm projects', subtopics: ['Project planning', 'Record keeping', 'Project evaluation', 'Reports'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_acc_1', subjectId: 'o4_acc', name: 'Final Accounts', description: 'Advanced financial statements', subtopics: ['Trading account', 'Profit and loss', 'Balance sheet', 'Adjustments'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_acc_2', subjectId: 'o4_acc', name: 'Exam Preparation', description: 'O-Level accounting exam prep', subtopics: ['Past papers', 'Accounting ratios', 'Interpretation', 'Exam techniques'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_eco_1', subjectId: 'o4_eco', name: 'Economics Revision', description: 'O-Level economics revision', subtopics: ['Micro revision', 'Macro revision', 'Case studies', 'Data response'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_eco_2', subjectId: 'o4_eco', name: 'Exam Preparation', description: 'Economics exam preparation', subtopics: ['Essay techniques', 'Calculations', 'Policy analysis', 'Past papers'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_com_1', subjectId: 'o4_com', name: 'Programming Revision', description: 'O-Level computer science revision', subtopics: ['Algorithms', 'Programming concepts', 'Data representation', 'Exam practice'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_com_2', subjectId: 'o4_com', name: 'Database Systems', description: 'Database design and management', subtopics: ['Database models', 'SQL basics', 'Data integrity', 'Database applications'], gradeLevel: 'Form 4', term: 'Term 2'),
  Topic(id: 'o4_ftd_1', subjectId: 'o4_ftd', name: 'Food Science', description: 'Science of food and cooking', subtopics: ['Food nutrients', 'Cooking methods', 'Food preservation', 'Food spoilage'], gradeLevel: 'Form 4', term: 'Term 1'),
  Topic(id: 'o4_ftd_2', subjectId: 'o4_ftd', name: 'Meal Planning', description: 'Nutrition and meal design', subtopics: ['Balanced diets', 'Meal planning', 'Special diets', 'Menu design'], gradeLevel: 'Form 4', term: 'Term 2'),
];
