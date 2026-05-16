import '../models/lesson.dart';

final Map<String, List<PastExamQuestion>> pastExamQuestions = {
  // ======================== GRADE 5 ========================
  'g5_eng': [
    PastExamQuestion(id: 'pe_g5_eng_1', subjectId: 'g5_eng', gradeLevel: 'Grade 5', year: '2023', term: 'Term 1', paper: '1', 
      question: 'Write a composition of about 200 words on the topic: "A Day I Will Never Forget"', marks: 30,
      answer: 'A well-structured essay with introduction, body, and conclusion. Uses descriptive language and correct grammar.',
      explanation: 'Marked on: Content (10), Organisation (8), Language (7), Accuracy (5)', topic: 'Essay Writing'),
    PastExamQuestion(id: 'pe_g5_eng_2', subjectId: 'g5_eng', gradeLevel: 'Grade 5', year: '2023', term: 'Term 1', paper: '2',
      question: 'Read the passage below and answer the questions that follow.\n\n[Passage about Zimbabwean wildlife]\n\na) What is the main idea of the passage? (2 marks)\nb) Explain why rhinos are endangered. (3 marks)\nc) Find a word in the passage that means "protected area for animals". (1 mark)',
      marks: 6, answer: 'a) The main idea is about protecting Zimbabwean wildlife and their habitats.\nb) Rhinos are endangered because of poaching for their horns and habitat loss.\nc) "Sanctuary" or "conservancy"',
      explanation: 'Read each question carefully. For (a), look for the overall message. For (b), find specific reasons. For (c), scan for the correct word.', topic: 'Comprehension'),
  ],
  'g5_mat': [
    PastExamQuestion(id: 'pe_g5_mat_1', subjectId: 'g5_mat', gradeLevel: 'Grade 5', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Express the ratio 8:12 in its simplest form. (2 marks)\nb) If 5 oranges cost \$2.50, how much do 8 oranges cost? (3 marks)',
      marks: 5, answer: 'a) 8:12 = 2:3 (divide both by 4)\nb) One orange = \$2.50/5 = \$0.50. 8 oranges = 8 x \$0.50 = \$4.00',
      explanation: 'For ratios, divide by the highest common factor. For proportion, find the unit cost first.', topic: 'Ratio and Proportion'),
    PastExamQuestion(id: 'pe_g5_mat_2', subjectId: 'g5_mat', gradeLevel: 'Grade 5', year: '2023', term: 'Term 2', paper: '1',
      question: 'Solve for x: 2x + 7 = 15', marks: 3,
      answer: '2x + 7 = 15\n2x = 15 - 7\n2x = 8\nx = 4', explanation: 'Subtract 7 from both sides, then divide by 2.', topic: 'Introduction to Algebra'),
  ],
  'g5_sci': [
    PastExamQuestion(id: 'pe_g5_sci_1', subjectId: 'g5_sci', gradeLevel: 'Grade 5', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Name the three states of matter. (3 marks)\nb) What happens to water when it is heated to 100°C? (2 marks)\nc) Explain why you can smell a cooking sadza from another room. (3 marks)',
      marks: 8, answer: 'a) Solid, liquid, gas\nb) It boils and turns into steam (gas)\nc) The particles of the cooking food turn into gas and spread through the air by diffusion.',
      explanation: 'Remember: heating gives particles energy to move faster and spread out.', topic: 'States of Matter'),
  ],
  'g5_hss': [
    PastExamQuestion(id: 'pe_g5_hss_1', subjectId: 'g5_hss', gradeLevel: 'Grade 5', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) What was Great Zimbabwe? (2 marks)\nb) When was it built? (1 mark)\nc) Why was it important as a trading centre? (3 marks)',
      marks: 6, answer: 'a) Great Zimbabwe was a medieval city and capital of the Kingdom of Zimbabwe, known for its stone structures.\nb) Between the 11th and 15th centuries (1100-1450 AD)\nc) It was located along trade routes connecting the gold mines to the coast. It traded gold, ivory, and copper for cloth, beads, and ceramics.',
      explanation: 'Great Zimbabwe is a UNESCO World Heritage site and symbol of African achievement.', topic: 'African History'),
  ],

  // ======================== GRADE 6 ========================
  'g6_eng': [
    PastExamQuestion(id: 'pe_g6_eng_1', subjectId: 'g6_eng', gradeLevel: 'Grade 6', year: '2023', term: 'Term 1', paper: '1',
      question: 'Write a persuasive essay on the topic: "Why Every Child Should Go to School" Write at least 250 words.', marks: 30,
      answer: 'Introduction: State your position. Body: Give 3-4 reasons (education leads to better jobs, helps develop the country, teaches important skills, builds character). Conclusion: Restate your position strongly.',
      explanation: 'Use persuasive techniques: rhetorical questions, emotive language, facts and statistics.', topic: 'Persuasive Writing'),
    PastExamQuestion(id: 'pe_g6_eng_2', subjectId: 'g6_eng', gradeLevel: 'Grade 6', year: '2023', term: 'Term 2', paper: '2',
      question: 'Read the passage and answer: \na) What is the writer\'s main argument? (3 marks)\nb) Identify two persuasive techniques used. (2 marks)\nc) Do you agree with the writer? Give a reason. (3 marks)',
      marks: 8, answer: 'a) [Based on passage]\nb) [Rhetorical questions, emotive language, statistics, expert opinion]\nc) Personal opinion with valid justification',
      explanation: 'When asked for your opinion, always support it with a reason.', topic: 'Critical Reading'),
  ],
  'g6_mat': [
    PastExamQuestion(id: 'pe_g6_mat_1', subjectId: 'g6_mat', gradeLevel: 'Grade 6', year: '2023', term: 'Term 1', paper: '1',
      question: 'Solve the simultaneous equations:\n2x + y = 10\nx - y = 2', marks: 5,
      answer: 'Adding: (2x + y) + (x - y) = 10 + 2\n3x = 12\nx = 4\nSubstitute: 2(4) + y = 10\n8 + y = 10\ny = 2\nAnswer: x = 4, y = 2',
      explanation: 'Since the y terms cancel when added, use the elimination method.', topic: 'Advanced Algebra'),
    PastExamQuestion(id: 'pe_g6_mat_2', subjectId: 'g6_mat', gradeLevel: 'Grade 6', year: '2023', term: 'Term 2', paper: '1',
      question: 'A bag contains 3 red balls, 2 blue balls, and 5 green balls. What is the probability of picking:\na) A red ball? (2 marks)\nb) A blue or green ball? (3 marks)',
      marks: 5, answer: 'a) P(red) = 3/10 = 0.3\nb) P(blue or green) = (2+5)/10 = 7/10 = 0.7',
      explanation: 'Probability = number of favourable outcomes / total outcomes. For "or", add the favourable outcomes.', topic: 'Probability'),
  ],
  'g6_sci': [
    PastExamQuestion(id: 'pe_g6_sci_1', subjectId: 'g6_sci', gradeLevel: 'Grade 6', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) What is an element? (2 marks)\nb) Give three examples of elements. (3 marks)\nc) What is the difference between a compound and a mixture? (4 marks)',
      marks: 9, answer: 'a) An element is a pure substance made of only one type of atom.\nb) Oxygen (O), Hydrogen (H), Carbon (C), Iron (Fe), Gold (Au) - any three valid elements.\nc) A compound has elements chemically bonded in fixed proportions. A mixture has substances physically combined that can be separated easily.',
      explanation: 'Elements are on the periodic table. Compounds have chemical bonds, mixtures do not.', topic: 'Chemistry Basics'),
  ],

  // ======================== GRADE 7 ========================
  'g7_eng': [
    PastExamQuestion(id: 'pe_g7_eng_1', subjectId: 'g7_eng', gradeLevel: 'Grade 7', year: '2023', term: 'Term 1', paper: '1',
      question: 'Write a composition of about 300 words on: "The Importance of Preserving Zimbabwean Culture."', marks: 30,
      answer: 'Introduction: Define culture and its importance. Body: Discuss traditions, language, ceremonies, values. Conclusion: Call to action for young people.',
      explanation: 'Grade 7 examiners expect clear structure, good vocabulary, and relevant examples from Zimbabwe.', topic: 'Exam Preparation'),
    PastExamQuestion(id: 'pe_g7_eng_2', subjectId: 'g7_eng', gradeLevel: 'Grade 7', year: '2023', term: 'Term 2', paper: '2',
      question: 'Summarise the following passage in about 100 words. [Passage about wildlife conservation].\nAlso answer: \na) What does "conservation" mean? (2 marks)\nb) Give two reasons why we should protect wildlife. (4 marks)',
      marks: 10, answer: 'Summary should capture: importance of wildlife, threats (poaching, habitat loss), solutions (laws, education).\na) Conservation means protecting and preserving natural resources.\nb) Wildlife maintains ecological balance and supports tourism.',
      explanation: 'For summary: identify key points, use your own words, stay within word limit.', topic: 'Exam Preparation'),
  ],
  'g7_mat': [
    PastExamQuestion(id: 'pe_g7_mat_1', subjectId: 'g7_mat', gradeLevel: 'Grade 7', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Find the mean of: 5, 8, 12, 7, 3 (2 marks)\nb) What is the median? (2 marks)\nc) What is the mode? (1 mark)',
      marks: 5, answer: 'a) Mean = (5+8+12+7+3)/5 = 35/5 = 7\nb) Ordered: 3,5,7,8,12. Median = 7\nc) No mode (all numbers appear once)',
      explanation: 'Mean = sum/count. Median = middle value when ordered. Mode = most frequent.', topic: 'Statistics'),
    PastExamQuestion(id: 'pe_g7_mat_2', subjectId: 'g7_mat', gradeLevel: 'Grade 7', year: '2023', term: 'Term 2', paper: '1',
      question: 'A triangle has sides of length 3 cm, 4 cm, and 5 cm.\na) Show that it is a right-angled triangle. (3 marks)\nb) Calculate its area. (2 marks)',
      marks: 5, answer: 'a) 3² + 4² = 9 + 16 = 25 = 5². So by Pythagoras theorem, it is right-angled.\nb) Area = ½ × 3 × 4 = 6 cm²',
      explanation: 'Pythagoras theorem: a² + b² = c² for right-angled triangles. Area of triangle = ½ × base × height.', topic: 'Geometry'),
  ],
  'g7_hss': [
    PastExamQuestion(id: 'pe_g7_hss_1', subjectId: 'g7_hss', gradeLevel: 'Grade 7', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) When did Zimbabwe gain independence? (1 mark)\nb) Who was the first Prime Minister of Zimbabwe? (1 mark)\nc) Explain three challenges faced by Zimbabwe after independence. (6 marks)',
      marks: 8, answer: 'a) 18 April 1980\nb) Robert Mugabe\nc) Land reform challenges, economic sanctions, reconciliation after war, building infrastructure, education for all, healthcare improvement. Any three valid points with explanation.',
      explanation: 'Post-independence challenges included land redistribution, economic transformation, and national healing.', topic: 'Zimbabwe in the World'),
  ],

  // ======================== FORM 1 ========================
  'o1_mat': [
    PastExamQuestion(id: 'pe_o1_mat_1', subjectId: 'o1_mat', gradeLevel: 'Form 1', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) List the elements of set A = {x: x is an odd number between 2 and 10}. (2 marks)\nb) If B = {3, 5, 7, 9}, find A ∩ B. (2 marks)\nc) Find A ∪ B. (2 marks)',
      marks: 6, answer: 'a) A = {3, 5, 7, 9}\nb) A ∩ B = {3, 5, 7, 9} (all of B, all of A)\nc) A ∪ B = {3, 5, 7, 9}',
      explanation: '∩ means elements in both sets. ∪ means all elements from both sets.', topic: 'Number Theory'),
    PastExamQuestion(id: 'pe_o1_mat_2', subjectId: 'o1_mat', gradeLevel: 'Form 1', year: '2022', term: 'Term 2', paper: '2',
      question: 'Simplify:\na) 3² × 3⁴ (2 marks)\nb) (2³)² (2 marks)\nc) Write 0.00045 in standard form. (2 marks)',
      marks: 6, answer: 'a) 3⁶ = 729\nb) 2⁶ = 64\nc) 4.5 × 10⁻⁴',
      explanation: 'When multiplying indices, add powers. When raising to a power, multiply powers. For standard form, move decimal point.', topic: 'Indices and Standard Form'),
  ],
  'o1_eng': [
    PastExamQuestion(id: 'pe_o1_eng_1', subjectId: 'o1_eng', gradeLevel: 'Form 1', year: '2023', term: 'Term 1', paper: '1',
      question: 'Write a narrative essay of about 350 words on: "The Most Exciting Day of My Life."', marks: 30,
      answer: 'A well-told personal story with clear sequence of events, vivid descriptions, and a satisfying conclusion.',
      explanation: 'Narrative essays tell a story. Use first person, describe feelings, build suspense, and end with a reflection.', topic: 'Composition Writing'),
  ],
  'o1_sci': [
    PastExamQuestion(id: 'pe_o1_sci_1', subjectId: 'o1_sci', gradeLevel: 'Form 1', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Label the parts of a microscope. (4 marks)\nb) What is the function of the objective lens? (2 marks)\nc) How should you carry a microscope? (2 marks)',
      marks: 8, answer: 'a) Eyepiece, objective lens, stage, mirror/light source, coarse adjustment, fine adjustment, arm, base\nb) The objective lens magnifies the specimen\nc) Hold the arm with one hand and support the base with the other hand',
      explanation: 'The microscope is a key scientific instrument. Always carry it with both hands.', topic: 'Scientific Method'),
  ],
  'o1_his': [
    PastExamQuestion(id: 'pe_o1_his_1', subjectId: 'o1_his', gradeLevel: 'Form 1', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) What is a primary source in history? (2 marks)\nb) Give two examples of primary sources. (2 marks)\nc) Why are primary sources important? (3 marks)',
      marks: 7, answer: 'a) A primary source is a firsthand account created during the time being studied.\nb) Diaries, letters, photographs, official documents, artefacts (any two)\nc) They provide direct evidence of past events and help historians understand what really happened.',
      explanation: 'Primary sources are original materials. Secondary sources analyse primary sources.', topic: 'Introduction to History'),
  ],
  'o1_geo': [
    PastExamQuestion(id: 'pe_o1_geo_1', subjectId: 'o1_geo', gradeLevel: 'Form 1', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Name the four cardinal points. (2 marks)\nb) What is the scale of a map? (2 marks)\nc) If the scale is 1:50,000, how many km is 10 cm on the map? (3 marks)',
      marks: 7, answer: 'a) North, South, East, West\nb) The scale shows the relationship between distance on the map and distance on the ground\nc) 10 cm × 50,000 = 500,000 cm = 5,000 m = 5 km',
      explanation: 'Map scales can be expressed as ratios (1:50,000), in words (1 cm = 0.5 km), or as a bar scale.', topic: 'Map Reading'),
  ],

  // ======================== FORM 2 ========================
  'o2_mat': [
    PastExamQuestion(id: 'pe_o2_mat_1', subjectId: 'o2_mat', gradeLevel: 'Form 2', year: '2023', term: 'Term 1', paper: '1',
      question: 'Given A = {1, 2, 3, 4, 5} and B = {4, 5, 6, 7, 8}:\na) Find A ∩ B (1 mark)\nb) Find A ∪ B (2 marks)\nc) Draw a Venn diagram to show these sets. (3 marks)',
      marks: 6, answer: 'a) A ∩ B = {4, 5}\nb) A ∪ B = {1, 2, 3, 4, 5, 6, 7, 8}\nc) Venn diagram with overlapping circles showing elements in correct regions.',
      explanation: 'Venn diagrams visually represent set relationships. Overlapping region = intersection.', topic: 'Sets and Relations'),
    PastExamQuestion(id: 'pe_o2_mat_2', subjectId: 'o2_mat', gradeLevel: 'Form 2', year: '2022', term: 'Term 2', paper: '1',
      question: 'Given matrix A = [3 2; 1 4] and matrix B = [1 0; 2 3]:\na) Find A + B (2 marks)\nb) Find 2A (2 marks)\nc) Find A × B (4 marks)',
      marks: 8, answer: 'a) A + B = [4 2; 3 7]\nb) 2A = [6 4; 2 8]\nc) A × B = [3×1+2×2, 3×0+2×3; 1×1+4×2, 1×0+4×3] = [7, 6; 9, 12]',
      explanation: 'Add corresponding elements. Multiply by scalar. For multiplication: rows × columns.', topic: 'Matrices'),
  ],
  'o2_sci': [
    PastExamQuestion(id: 'pe_o2_sci_1', subjectId: 'o2_sci', gradeLevel: 'Form 2', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) What is a cell? (2 marks)\nb) Name three parts of a plant cell that are not found in an animal cell. (3 marks)\nc) What is the function of mitochondria? (2 marks)',
      marks: 7, answer: 'a) The cell is the basic unit of life.\nb) Cell wall, chloroplasts, large permanent vacuole\nc) Mitochondria are the powerhouse of the cell - they release energy through respiration.',
      explanation: 'Plant cells have extra structures because they need to make their own food and support themselves.', topic: 'Cell Biology'),
  ],
  'o2_his': [
    PastExamQuestion(id: 'pe_o2_his_1', subjectId: 'o2_his', gradeLevel: 'Form 2', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) When did Britain colonise Zimbabwe? (1 mark)\nb) What was the name of the country during colonial rule? (1 mark)\nc) Explain three effects of colonial rule on the African population. (6 marks)',
      marks: 8, answer: 'a) 1890\nb) Rhodesia (later Southern Rhodesia)\nc) Land alienation (Africans moved to less fertile land), forced labour, loss of political power, introduction of taxes, destruction of traditional economy, racial discrimination. Any three.',
      explanation: 'Colonial rule had profound and lasting effects on Zimbabwean society, economy, and politics.', topic: 'Colonial Zimbabwe'),
  ],

  // ======================== FORM 3 ========================
  'o3_bio': [
    PastExamQuestion(id: 'pe_o3_bio_1', subjectId: 'o3_bio', gradeLevel: 'Form 3', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Describe the structure of DNA. (5 marks)\nb) Explain the process of DNA replication. (5 marks)',
      marks: 10, answer: 'a) DNA is a double helix. Each strand has a sugar-phosphate backbone. The two strands are connected by nitrogenous base pairs: Adenine-Thymine and Cytosine-Guanine.\nb) DNA replication is semi-conservative. The double helix unwinds, each strand serves as a template, complementary nucleotides are added by DNA polymerase, resulting in two identical DNA molecules.',
      explanation: 'DNA structure was discovered by Watson and Crick. Base pairing is specific: A-T and C-G.', topic: 'Genetics'),
    PastExamQuestion(id: 'pe_o3_bio_2', subjectId: 'o3_bio', gradeLevel: 'Form 3', year: '2022', term: 'Term 2', paper: '2',
      question: 'a) What is an ecosystem? (2 marks)\nb) Draw and label a food chain with four organisms. (4 marks)\nc) Explain what would happen if the producer was removed. (4 marks)',
      marks: 10, answer: 'a) An ecosystem is a community of living organisms interacting with each other and their physical environment.\nb) Grass → Grasshopper → Frog → Snake (or similar valid chain)\nc) If the producer (grass) is removed, all organisms above would die because there would be no energy entering the food chain.',
      explanation: 'Producers (plants) capture energy from the sun. Without them, the ecosystem collapses.', topic: 'Ecology'),
  ],
  'o3_che': [
    PastExamQuestion(id: 'pe_o3_che_1', subjectId: 'o3_che', gradeLevel: 'Form 3', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) What is the atomic number of an element? (2 marks)\nb) Draw the electron arrangement of oxygen (atomic number 8). (3 marks)\nc) Explain why noble gases are unreactive. (3 marks)',
      marks: 8, answer: 'a) The atomic number is the number of protons in the nucleus of an atom.\nb) Oxygen: 2 electrons in the first shell, 6 in the second shell (2,6)\nc) Noble gases have a full outer electron shell (8 electrons), making them stable and unreactive.',
      explanation: 'Electron arrangement determines chemical properties. Full outer shells = stable.', topic: 'Atomic Structure'),
  ],
  'o3_phy': [
    PastExamQuestion(id: 'pe_o3_phy_1', subjectId: 'o3_phy', gradeLevel: 'Form 3', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) State Newtons First Law of Motion. (2 marks)\nb) A car of mass 1000 kg accelerates at 2 m/s². Calculate the force applied. (3 marks)\nc) Explain what happens to the passengers when a car suddenly stops. (3 marks)',
      marks: 8, answer: 'a) An object at rest stays at rest, and an object in motion stays in motion at constant velocity, unless acted upon by an external force.\nb) F = ma = 1000 × 2 = 2000 N\nc) Passengers continue moving forward due to inertia. They need seatbelts to stop them safely.',
      explanation: 'Newton\'s laws describe how forces affect motion. F = ma is the fundamental equation.', topic: 'Mechanics'),
  ],

  // ======================== FORM 4 ========================
  'o4_mat': [
    PastExamQuestion(id: 'pe_o4_mat_1', subjectId: 'o4_mat', gradeLevel: 'Form 4', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Solve: 2(x - 3) = 3(x + 1) - 5 (4 marks)\nb) Factorise: x² - 5x + 6 (3 marks)\nc) Solve: x² - 4x - 12 = 0 (4 marks)',
      marks: 11, answer: 'a) 2x - 6 = 3x + 3 - 5\n2x - 6 = 3x - 2\n-6 + 2 = 3x - 2x\nx = -4\nb) (x - 2)(x - 3)\nc) (x - 6)(x + 2) = 0, so x = 6 or x = -2',
      explanation: 'For quadratics, find factors that multiply to give constant term and add to give coefficient of x.', topic: 'O-Level Maths Revision'),
    PastExamQuestion(id: 'pe_o4_mat_2', subjectId: 'o4_mat', gradeLevel: 'Form 4', year: '2022', term: 'Term 2', paper: '2',
      question: 'The angle of depression from the top of a 50 m building to a car is 30°. How far is the car from the base of the building? (5 marks)',
      marks: 5, answer: 'tan 30° = 50/distance\ndistance = 50/tan 30°\ndistance = 50/0.5774\ndistance = 86.6 m',
      explanation: 'Draw a diagram. Angle of depression from top = angle of elevation from bottom. Use tangent ratio.', topic: 'Trigonometry'),
  ],
  'o4_eng': [
    PastExamQuestion(id: 'pe_o4_eng_1', subjectId: 'o4_eng', gradeLevel: 'Form 4', year: '2023', term: 'Term 1', paper: '1',
      question: 'Write an argumentative essay of about 400 words on: "Social media does more harm than good to young people."', marks: 30,
      answer: 'Introduction with clear position. Body paragraphs: 1) Addiction and time waste, 2) Cyberbullying and mental health, 3) Comparison and self-esteem, 4) Counterargument and rebuttal. Conclusion reinforcing position.',
      explanation: 'O-Level argumentative essays require: thesis statement, well-developed arguments, counterarguments, and conclusion.', topic: 'O-Level Exam Prep'),
  ],
  'o4_agr': [
    PastExamQuestion(id: 'pe_o4_agr_1', subjectId: 'o4_agr', gradeLevel: 'Form 4', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) What is soil erosion? (2 marks)\nb) Name three types of soil erosion. (3 marks)\nc) Describe four methods of controlling soil erosion. (8 marks)',
      marks: 13, answer: 'a) Soil erosion is the removal of topsoil by wind, water, or human activity.\nb) Sheet erosion, rill erosion, gully erosion, wind erosion (any three)\nc) Contour ploughing, terracing, cover cropping, mulching, strip cropping, reforestation, windbreaks, conservation tillage. Any four with explanation.',
      explanation: 'Soil conservation is critical for sustainable agriculture in Zimbabwe.', topic: 'O-Level Agriculture'),
  ],

  // ======================== FORM 5 ========================
  'a5_mat': [
    PastExamQuestion(id: 'pe_a5_mat_1', subjectId: 'a5_mat', gradeLevel: 'Form 5', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Differentiate: f(x) = (3x² + 2x)⁴ (4 marks)\nb) Find the equation of the tangent to y = x³ - 2x at x = 1. (5 marks)',
      marks: 9, answer: 'a) Use chain rule: f\'(x) = 4(3x² + 2x)³ × (6x + 2)\nb) y = x³ - 2x, dy/dx = 3x² - 2\nAt x = 1: y = 1 - 2 = -1, gradient = 3(1)² - 2 = 1\nEquation: y - (-1) = 1(x - 1), y + 1 = x - 1, y = x - 2',
      explanation: 'Chain rule: differentiate outer function first, multiply by derivative of inner function.', topic: 'Differentiation'),
    PastExamQuestion(id: 'pe_a5_mat_2', subjectId: 'a5_mat', gradeLevel: 'Form 5', year: '2022', term: 'Term 2', paper: '2',
      question: 'Evaluate: ∫₀² (x³ - 2x² + 1) dx (5 marks)', marks: 5,
      answer: '∫(x³ - 2x² + 1) dx = x⁴/4 - 2x³/3 + x + C\n[2⁴/4 - 2(2)³/3 + 2] - [0⁴/4 - 2(0)³/3 + 0]\n= [16/4 - 16/3 + 2] - [0]\n= 4 - 5.333 + 2 = 0.667',
      explanation: 'For definite integrals: integrate then substitute limits (upper minus lower).', topic: 'Integration'),
  ],
  'a5_bio': [
    PastExamQuestion(id: 'pe_a5_bio_1', subjectId: 'a5_bio', gradeLevel: 'Form 5', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Describe the process of protein synthesis. (8 marks)\nb) Explain the role of mRNA and tRNA. (4 marks)\nc) What would happen if a mutation occurred in the DNA sequence? (4 marks)',
      marks: 16, answer: 'a) Transcription: DNA unwinds, mRNA is synthesised by RNA polymerase, mRNA leaves nucleus. Translation: mRNA binds to ribosome, tRNA brings amino acids, peptide bonds form between amino acids, protein chain grows.\nb) mRNA carries the genetic code from DNA to ribosomes. tRNA carries specific amino acids to the ribosome matching mRNA codons.\nc) Mutation could change the amino acid sequence, potentially altering protein function. Effects range from negligible to severe.',
      explanation: 'The central dogma: DNA → RNA → Protein. Any change in DNA can affect the final protein.', topic: 'Molecular Biology'),
  ],
  'a5_eco': [
    PastExamQuestion(id: 'pe_a5_eco_1', subjectId: 'a5_eco', gradeLevel: 'Form 5', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Explain the law of demand. (3 marks)\nb) With the aid of a diagram, explain why the demand curve slopes downwards. (5 marks)\nc) Distinguish between a movement along and a shift of the demand curve. (6 marks)',
      marks: 14, answer: 'a) Law of demand: as price increases, quantity demanded decreases, ceteris paribus.\nb) Demand curve slopes downward due to: income effect (higher price = less purchasing power), substitution effect (consumers switch to cheaper alternatives), diminishing marginal utility.\nc) Movement along: caused by price change of the good itself. Shift: caused by changes in income, tastes, prices of related goods, population, expectations.',
      explanation: 'Understanding demand is fundamental to microeconomics. The ceteris paribus assumption is crucial.', topic: 'Microeconomics'),
  ],

  // ======================== FORM 6 ========================
  'a6_mat': [
    PastExamQuestion(id: 'pe_a6_mat_1', subjectId: 'a6_mat', gradeLevel: 'Form 6', year: '2023', term: 'Term 1', paper: '1',
      question: 'Solve the differential equation: dy/dx = 2xy, given that y = 1 when x = 0. (7 marks)',
      marks: 7, answer: 'Separate variables: dy/y = 2x dx\n∫(1/y) dy = ∫2x dx\nln|y| = x² + C\ny = e^(x² + C) = Ae^(x²) where A = e^C\nUsing y = 1 when x = 0: 1 = Ae⁰ = A, so A = 1\nTherefore y = e^(x²)',
      explanation: 'Separate variables, integrate both sides, apply initial conditions to find constant.', topic: 'Differential Equations'),
    PastExamQuestion(id: 'pe_a6_mat_2', subjectId: 'a6_mat', gradeLevel: 'Form 6', year: '2022', term: 'Term 2', paper: '2',
      question: 'Use integration by parts to evaluate: ∫x·cos(x) dx (5 marks)', marks: 5,
      answer: 'Let u = x, dv = cos(x) dx\ndu = dx, v = sin(x)\n∫x·cos(x) dx = x·sin(x) - ∫sin(x) dx\n= x·sin(x) - (-cos(x)) + C\n= x·sin(x) + cos(x) + C',
      explanation: 'Integration by parts: ∫u dv = uv - ∫v du. Choose u that simplifies when differentiated.', topic: 'Advanced Integration'),
  ],
  'a6_bio': [
    PastExamQuestion(id: 'pe_a6_bio_1', subjectId: 'a6_bio', gradeLevel: 'Form 6', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Describe the structure of a named ecosystem in Zimbabwe. (6 marks)\nb) Explain how energy flows through this ecosystem. (5 marks)\nc) Discuss the impact of human activities on this ecosystem. (6 marks)',
      marks: 17, answer: 'a) Lake Kariba ecosystem: producers (phytoplankton, water plants), primary consumers (small fish, zooplankton), secondary consumers (large fish), tertiary consumers (crocodiles, fish eagles), decomposers.\nb) Sun → phytoplankton → small fish → large fish → crocodile. Only 10% of energy passes between trophic levels.\nc) Overfishing, pollution from mining, water level changes due to hydroelectric operations, invasive species introduction, climate change impacts.',
      explanation: 'Ecosystem ecology integrates biology with environmental science. Zimbabwe has diverse ecosystems.', topic: 'Ecology'),
  ],
  'a6_che': [
    PastExamQuestion(id: 'pe_a6_che_1', subjectId: 'a6_che', gradeLevel: 'Form 6', year: '2023', term: 'Term 1', paper: '1',
      question: 'a) Define a transition metal. (2 marks)\nb) Give three characteristic properties of transition metals. (3 marks)\nc) Explain the catalytic activity of transition metals using iron in the Haber process as an example. (6 marks)',
      marks: 11, answer: 'a) Transition metals are elements with partially filled d-orbitals.\nb) Variable oxidation states, coloured compounds, catalytic activity, formation of complexes (any three)\nc) Iron catalyses the Haber process (N₂ + 3H₂ ⇌ 2NH₃). It provides a surface for adsorption of N₂ and H₂, weakening their bonds and lowering activation energy, without being consumed in the reaction.',
      explanation: 'Transition metals have unique properties due to their d-electron configuration.', topic: 'Inorganic Chemistry'),
  ],
};

List<PastExamQuestion> getPastQuestionsForSubjectAndGrade(String subjectId, String gradeLevel) {
  final key = subjectId;
  final questions = pastExamQuestions[key] ?? [];
  return questions.where((q) => q.gradeLevel == gradeLevel).toList();
}

List<PastExamQuestion> getPastQuestionsForGrade(String gradeLevel) {
  return pastExamQuestions.values
      .expand((list) => list)
      .where((q) => q.gradeLevel == gradeLevel)
      .toList();
}

List<String> getAvailableYears() {
  return ['2023', '2022', '2021', '2020'];
}

String extractGradeBand(String gradeLevel) {
  if (gradeLevel.startsWith('ECD')) return 'ECD';
  if (gradeLevel.startsWith('Grade')) return 'Primary';
  if (['Form 1', 'Form 2', 'Form 3', 'Form 4'].contains(gradeLevel)) return 'O-Level';
  if (['Form 5', 'Form 6'].contains(gradeLevel)) return 'A-Level';
  return 'Other';
}
