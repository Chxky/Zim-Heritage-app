import '../models/answer_key.dart';

final Map<String, List<AnswerKey>> answerKeysBySubject = {
  // ========== ECD A ==========
  'ecda_lan': [
    AnswerKey(id: 'ak_ecda_lan_1', subjectId: 'ecda_lan', topicId: 'ecda_lan_1', title: 'Oral Language Development', gradeLevel: 'ECD A', entries: [
      AnswerKeyEntry(question: 'Can the child greet others appropriately?', answer: 'Yes/No - Child should use proper greetings like "Good morning" or "Mhoro"', explanation: 'At ECD A level, children should be able to greet using at least one language.', marks: 2),
      AnswerKeyEntry(question: 'Can the child name basic body parts?', answer: 'Head, eyes, nose, mouth, ears, hands, feet', explanation: 'Children should identify at least 5 body parts when asked.', marks: 2),
    ]),
  ],
  'ecda_mat': [
    AnswerKey(id: 'ak_ecda_mat_1', subjectId: 'ecda_mat', topicId: 'ecda_mat_1', title: 'Number Concepts 1-10', gradeLevel: 'ECD A', entries: [
      AnswerKeyEntry(question: 'Count from 1 to 5', answer: '1, 2, 3, 4, 5', explanation: 'Children should be able to count orally from 1 to 5 at this level.', marks: 2),
      AnswerKeyEntry(question: 'Identify the circle', answer: 'Child points to or picks the circle shape', explanation: 'Children should recognise basic shapes including circle.', marks: 1),
    ]),
  ],

  // ========== ECD B ==========
  'ecdb_lan': [
    AnswerKey(id: 'ak_ecdb_lan_1', subjectId: 'ecdb_lan', topicId: 'ecdb_lan_2', title: 'Pre-Writing Skills', gradeLevel: 'ECD B', entries: [
      AnswerKeyEntry(question: 'Trace the letter A', answer: 'Child should correctly trace the letter A', explanation: 'At ECD B, children should be able to trace letters with reasonable accuracy.', marks: 2),
      AnswerKeyEntry(question: 'Write your name', answer: 'Child writes their own name (may have errors)', explanation: 'Children should attempt to write their name. Perfection is not expected at this stage.', marks: 3),
    ]),
  ],
  'ecdb_mat': [
    AnswerKey(id: 'ak_ecdb_mat_1', subjectId: 'ecdb_mat', topicId: 'ecdb_mat_1', title: 'Numbers 1-20', gradeLevel: 'ECD B', entries: [
      AnswerKeyEntry(question: 'Count from 1 to 20', answer: '1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20', explanation: 'By ECD B, children should count to 20 with minimal errors.', marks: 3),
      AnswerKeyEntry(question: 'What is 2 + 1?', answer: '3', explanation: 'Simple addition using concrete objects should be introduced at ECD B.', marks: 2),
    ]),
  ],

  // ========== MATHEMATICS ==========
  'g1_mat': [
    AnswerKey(id: 'ak_g1_mat_1', subjectId: 'g1_mat', topicId: 'g1_mat_1', title: 'Number Recognition - Term 1', gradeLevel: 'Grade 1', entries: [
      AnswerKeyEntry(question: 'Count the apples: How many?', answer: '5', explanation: 'Count each apple one by one.', marks: 2),
      AnswerKeyEntry(question: 'What number comes after 7?', answer: '8', explanation: 'In the number sequence 1,2,3,4,5,6,7,8 - the number after 7 is 8.', marks: 1),
      AnswerKeyEntry(question: 'Write the number name for 3', answer: 'Three', explanation: 'The number 3 is written as "three" in words.', marks: 2),
      AnswerKeyEntry(question: 'Circle the bigger number: 8 or 3', answer: '8', explanation: '8 is larger than 3 on the number line.', marks: 1),
    ]),
    AnswerKey(id: 'ak_g1_mat_2', subjectId: 'g1_mat', topicId: 'g1_mat_2', title: 'Basic Operations - Term 2', gradeLevel: 'Grade 1', entries: [
      AnswerKeyEntry(question: 'What is 3 + 2?', answer: '5', explanation: 'When we add 3 and 2 together, we get a total of 5.', marks: 1),
      AnswerKeyEntry(question: 'What is 7 - 4?', answer: '3', explanation: 'Taking away 4 from 7 leaves us with 3.', marks: 1),
      AnswerKeyEntry(question: 'John has 4 sweets. Mary gives him 3 more. How many sweets does John have now?', answer: '7 sweets', explanation: '4 + 3 = 7. John now has 7 sweets in total.', marks: 2),
    ]),
  ],
  'g3_mat': [
    AnswerKey(id: 'ak_g3_mat_1', subjectId: 'g3_mat', topicId: 'g3_mat_1', title: 'Multiplication and Division', gradeLevel: 'Grade 3', entries: [
      AnswerKeyEntry(question: 'What is 6 x 4?', answer: '24', explanation: '6 multiplied by 4 equals 24 (6+6+6+6 = 24).', marks: 1),
      AnswerKeyEntry(question: 'What is 20 / 5?', answer: '4', explanation: '20 divided into 5 equal groups gives 4 in each group.', marks: 1),
      AnswerKeyEntry(question: 'There are 3 bags with 8 oranges in each bag. How many oranges are there altogether?', answer: '24 oranges', explanation: '3 x 8 = 24. There are 24 oranges altogether.', marks: 2),
    ]),
  ],

  // ========== O-LEVEL MATHEMATICS ==========
  'o1_mat': [
    AnswerKey(id: 'ak_o1_mat_1', subjectId: 'o1_mat', topicId: 'o1_mat_1', title: 'Number Theory', gradeLevel: 'Form 1', entries: [
      AnswerKeyEntry(question: 'Find the LCM of 12 and 18', answer: '36', explanation: 'Multiples of 12: 12,24,36,48... Multiples of 18: 18,36,54... LCM = 36', marks: 3),
      AnswerKeyEntry(question: 'Simplify: 3^2 x 3^4', answer: '3^6 = 729', explanation: 'When multiplying indices with same base, add the powers: 3^2 x 3^4 = 3^(2+4) = 3^6 = 729', marks: 2),
    ]),
  ],
  'o1_eng': [
    AnswerKey(id: 'ak_o1_eng_1', subjectId: 'o1_eng', topicId: 'o1_eng_1', title: 'Parts of Speech', gradeLevel: 'Form 1', entries: [
      AnswerKeyEntry(question: 'Identify the parts of speech: "The beautiful bird sang loudly."', answer: 'The (article), beautiful (adjective), bird (noun), sang (verb), loudly (adverb)', explanation: 'Each word in a sentence has a grammatical function. Understanding these helps with writing.', marks: 5),
      AnswerKeyEntry(question: 'Change to passive voice: "The boy kicked the ball."', answer: '"The ball was kicked by the boy."', explanation: 'In passive voice, the object becomes the subject. Use appropriate form of "to be" + past participle.', marks: 3),
    ]),
  ],

  // ========== A-LEVEL MATHEMATICS ==========
  'a5_mat': [
    AnswerKey(id: 'ak_a5_mat_1', subjectId: 'a5_mat', topicId: 'a5_mat_1', title: 'Pure Mathematics', gradeLevel: 'Form 5', entries: [
      AnswerKeyEntry(question: 'Differentiate f(x) = 3x^4 + 2x^3 - 5x + 7', answer: "f'(x) = 12x^3 + 6x^2 - 5", explanation: 'Apply the power rule: d/dx(x^n) = nx^(n-1) to each term.', marks: 4),
      AnswerKeyEntry(question: 'Integrate: ∫(2x + 3) dx', answer: 'x^2 + 3x + C', explanation: 'Integrate term by term: ∫2x dx = x^2, ∫3 dx = 3x. Don\'t forget the constant C.', marks: 3),
    ]),
  ],
  'a5_che': [
    AnswerKey(id: 'ak_a5_che_1', subjectId: 'a5_che', topicId: 'a5_che_1', title: 'Atomic Structure', gradeLevel: 'Form 5', entries: [
      AnswerKeyEntry(question: 'Define the term "isotope"', answer: 'Isotopes are atoms of the same element with the same number of protons but different numbers of neutrons.', explanation: 'Isotopes have identical atomic numbers but different mass numbers. Example: Carbon-12 and Carbon-14.', marks: 3),
      AnswerKeyEntry(question: 'Calculate the relative atomic mass of chlorine given: Cl-35 (75%) and Cl-37 (25%)', answer: '35.5', explanation: '(35 x 0.75) + (37 x 0.25) = 26.25 + 9.25 = 35.5', marks: 4),
    ]),
  ],
  'a5_bio': [
    AnswerKey(id: 'ak_a5_bio_1', subjectId: 'a5_bio', topicId: 'a5_bio_1', title: 'Molecular Biology', gradeLevel: 'Form 5', entries: [
      AnswerKeyEntry(question: 'Describe the structure of DNA', answer: 'DNA is a double helix with two antiparallel strands. Each strand consists of nucleotides with a sugar-phosphate backbone and nitrogenous bases (A, T, G, C) that pair A-T and G-C.', explanation: 'DNA structure was discovered by Watson and Crick. The complementary base pairing is essential for replication.', marks: 5),
      AnswerKeyEntry(question: 'Explain the process of protein synthesis', answer: 'Protein synthesis involves transcription (DNA to mRNA in nucleus) and translation (mRNA to protein at ribosomes). tRNA brings amino acids matching mRNA codons.', explanation: 'This is the central dogma of molecular biology: DNA -> RNA -> Protein.', marks: 5),
    ]),
  ],
  'a5_eco': [
    AnswerKey(id: 'ak_a5_eco_1', subjectId: 'a5_eco', topicId: 'a5_eco_1', title: 'Microeconomics', gradeLevel: 'Form 5', entries: [
      AnswerKeyEntry(question: 'Explain the law of demand', answer: 'The law of demand states that as price increases, quantity demanded decreases, and vice versa, ceteris paribus (all other factors held constant).', explanation: 'This inverse relationship between price and quantity demanded is fundamental to microeconomics.', marks: 3),
      AnswerKeyEntry(question: 'What is price elasticity of demand?', answer: 'Price elasticity of demand measures the responsiveness of quantity demanded to a change in price. PED = % change in QD / % change in P.', explanation: 'Elastic (>1), inelastic (<1), and unit elastic (=1) demand have different implications for pricing.', marks: 4),
    ]),
  ],

  // ========== REGULAR ANSWER KEYS FOR EXISTING SUBJECTS ==========
  'g5_mat': [
    AnswerKey(id: 'ak_g5_mat_1', subjectId: 'g5_mat', topicId: 'g5_mat_1', title: 'Ratio and Proportion', gradeLevel: 'Grade 5', entries: [
      AnswerKeyEntry(question: 'Express the ratio of 6 to 12 in its simplest form.', answer: '1:2', explanation: 'Divide both numbers by their GCD (6). 6/6=1, 12/6=2, so simplest form is 1:2.', marks: 2),
      AnswerKeyEntry(question: r'If 3 books cost $15, how much do 7 books cost?', answer: r'$35', explanation: r'One book costs $15/3 = $5. So 7 books cost 7x$5 = $35.', marks: 3),
    ]),
  ],
  'g7_mat': [
    AnswerKey(id: 'ak_g7_mat_1', subjectId: 'g7_mat', topicId: 'g7_mat_1', title: 'Pre-Algebra - Equations', gradeLevel: 'Grade 7', entries: [
      AnswerKeyEntry(question: 'Solve for x: 2x + 5 = 15', answer: 'x = 5', explanation: '2x + 5 = 15 -> 2x = 10 -> x = 5', marks: 3),
      AnswerKeyEntry(question: 'Simplify: 3(x + 2) - 2x', answer: 'x + 6', explanation: '3(x+2) - 2x = 3x + 6 - 2x = x + 6', marks: 2),
    ]),
  ],

  // ========== ENGLISH ==========
  'g1_eng': [
    AnswerKey(id: 'ak_g1_eng_1', subjectId: 'g1_eng', topicId: 'g1_eng_1', title: 'Phonics - Letter Sounds', gradeLevel: 'Grade 1', entries: [
      AnswerKeyEntry(question: 'What sound does the letter "b" make?', answer: '/b/ sound as in "ball"', explanation: 'The letter "b" makes a /b/ sound. Put your lips together and push air out.', marks: 1),
      AnswerKeyEntry(question: 'Which word starts with the same sound as "sun"? a) mat  b) sit  c) dog', answer: 'b) sit', explanation: '"Sun" and "sit" both start with the /s/ sound.', marks: 2),
    ]),
  ],

  // ========== HERITAGE-SOCIAL STUDIES ==========
  'g1_hss': [
    AnswerKey(id: 'ak_g1_hss_1', subjectId: 'g1_hss', topicId: 'g1_hss_1', title: 'My Family', gradeLevel: 'Grade 1', entries: [
      AnswerKeyEntry(question: 'Name three people in your family.', answer: 'Any three family members (mother, father, brother, sister, grandmother, grandfather, etc.)', explanation: 'A family includes people related by blood, marriage, or adoption.', marks: 2),
      AnswerKeyEntry(question: 'What colour is the Zimbabwe flag?', answer: 'Green, yellow/gold, red, black, white', explanation: 'Zimbabwes flag has green (agriculture), yellow (minerals), red (liberation struggle), black (heritage), and white (peace).', marks: 2),
    ]),
  ],

  // ========== SCIENCE ==========
  'g3_sci': [
    AnswerKey(id: 'ak_g3_sci_1', subjectId: 'g3_sci', topicId: 'g3_sci_1', title: 'Energy', gradeLevel: 'Grade 3', entries: [
      AnswerKeyEntry(question: 'Name three sources of light.', answer: 'Sun, fire, torch/bulb', explanation: 'Light comes from natural sources (sun, fire) and artificial sources (torches, bulbs).', marks: 2),
      AnswerKeyEntry(question: 'What is sound energy?', answer: 'Energy produced when objects vibrate, which we can hear', explanation: 'Sound is produced by vibrations that travel through air to our ears.', marks: 2),
    ]),
  ],

  // ========== AGRICULTURE ==========
  'g3_agr': [
    AnswerKey(id: 'ak_g3_agr_1', subjectId: 'g3_agr', topicId: 'g3_agr_1', title: 'Soil Types', gradeLevel: 'Grade 3', entries: [
      AnswerKeyEntry(question: 'What are the three main types of soil?', answer: 'Sandy, clay, and loam', explanation: 'The three main soil types are sandy (large particles), clay (fine particles), and loam (mixture, best for farming).', marks: 2),
      AnswerKeyEntry(question: 'Which soil type is best for gardening and why?', answer: 'Loam soil because it has a good balance of nutrients, water retention, and drainage', explanation: 'Loam is a mixture of sand, silt, and clay, making it ideal for most plants.', marks: 2),
    ]),
  ],

  // ========== O-LEVEL HISTORY ==========
  'o1_his': [
    AnswerKey(id: 'ak_o1_his_1', subjectId: 'o1_his', topicId: 'o1_his_2', title: 'Early Zimbabwe', gradeLevel: 'Form 1', entries: [
      AnswerKeyEntry(question: 'What was Great Zimbabwe?', answer: 'Great Zimbabwe was a medieval city and the capital of the Kingdom of Zimbabwe, known for its impressive stone structures.', explanation: 'Great Zimbabwe was built between the 11th and 15th centuries and was a major trading centre.', marks: 3),
      AnswerKeyEntry(question: 'Who built Great Zimbabwe?', answer: 'The ancestors of the Shona people built Great Zimbabwe.', explanation: 'Great Zimbabwe was built by indigenous African people, not by foreign builders as some colonial narratives claimed.', marks: 2),
    ]),
  ],

  // ========== O-LEVEL GEOGRAPHY ==========
  'o1_geo': [
    AnswerKey(id: 'ak_o1_geo_1', subjectId: 'o1_geo', topicId: 'o1_geo_1', title: 'Map Reading', gradeLevel: 'Form 1', entries: [
      AnswerKeyEntry(question: 'What are the four cardinal points?', answer: 'North, South, East, West', explanation: 'Cardinal points are the four main directions used in navigation and map reading.', marks: 2),
      AnswerKeyEntry(question: 'What is a contour line?', answer: 'A contour line is a line on a map joining points of equal height above sea level.', explanation: 'Contour lines show the shape and height of the land on a map.', marks: 3),
    ]),
  ],

  // ========== SHONA/NDEBELE ==========
  'g3_sho': [
    AnswerKey(id: 'ak_g3_sho_1', subjectId: 'g3_sho', topicId: 'g3_sho_1', title: 'Proverbs', gradeLevel: 'Grade 3', entries: [
      AnswerKeyEntry(question: 'What is the meaning of "Chara chimwe hachitswanyi inda"?', answer: 'Unity is strength / One finger cannot crush a louse', explanation: 'This proverb teaches that we need to work together as a team to achieve goals.', marks: 3),
      AnswerKeyEntry(question: 'Explain "Kudada kunobva muhombe"', answer: 'Pride comes from greatness / One can only be proud of genuine achievements', explanation: 'This Ndebele proverb teaches that true pride comes from real accomplishments.', marks: 3),
    ]),
  ],

  // ========== CAMBRIDGE PRIMARY - ENGLISH ==========
  'cam_g1_eng': [
    AnswerKey(id: 'ak_cam_g1_eng_1', subjectId: 'cam_g1_eng', topicId: 'cam_g1_eng_1', title: 'Phonics and Reading', gradeLevel: 'Grade 1', entries: [
      AnswerKeyEntry(question: 'Blend the sounds: c-a-t', answer: 'cat', explanation: 'Blend each sound together slowly, then faster: c-a-t = cat.', marks: 1),
      AnswerKeyEntry(question: 'Which word rhymes with "hat"? a) dog  b) mat  c) cup', answer: 'b) mat', explanation: 'Hat and mat both end with the -at sound.', marks: 1),
    ]),
  ],
  'cam_g3_eng': [
    AnswerKey(id: 'ak_cam_g3_eng_1', subjectId: 'cam_g3_eng', topicId: 'cam_g3_eng_1', title: 'Reading Comprehension', gradeLevel: 'Grade 3', entries: [
      AnswerKeyEntry(question: 'Read the passage. What is the main idea?', answer: 'The main idea is the most important point the author wants to share.', explanation: 'Look at the first and last sentences for the main idea.', marks: 2),
      AnswerKeyEntry(question: 'Write a sentence using the word "because"', answer: 'Example: I went inside because it started raining.', explanation: '"Because" connects a reason to an action.', marks: 2),
    ]),
  ],

  // ========== CAMBRIDGE PRIMARY - MATHEMATICS ==========
  'cam_g1_mat': [
    AnswerKey(id: 'ak_cam_g1_mat_1', subjectId: 'cam_g1_mat', topicId: 'cam_g1_mat_1', title: 'Numbers and Counting', gradeLevel: 'Grade 1', entries: [
      AnswerKeyEntry(question: 'Count the objects: How many?', answer: 'Count each object one by one', explanation: 'Touch each object as you count to avoid counting twice.', marks: 2),
      AnswerKeyEntry(question: 'What is 5 + 3?', answer: '8', explanation: 'Use fingers or objects to help count: 5, then count 3 more: 6, 7, 8.', marks: 1),
    ]),
  ],
  'cam_g3_mat': [
    AnswerKey(id: 'ak_cam_g3_mat_1', subjectId: 'cam_g3_mat', topicId: 'cam_g3_mat_1', title: 'Multiplication and Division', gradeLevel: 'Grade 3', entries: [
      AnswerKeyEntry(question: 'What is 7 x 6?', answer: '42', explanation: '7 x 6 means 7 groups of 6, or 6+6+6+6+6+6+6 = 42.', marks: 1),
      AnswerKeyEntry(question: 'Share 24 sweets equally among 4 children. How many does each get?', answer: '6 sweets each', explanation: '24 ÷ 4 = 6. Each child gets 6 sweets.', marks: 2),
    ]),
  ],

  // ========== CAMBRIDGE IGCSE - ENGLISH ==========
  'cam_o3_eng': [
    AnswerKey(id: 'ak_cam_o3_eng_1', subjectId: 'cam_o3_eng', topicId: 'cam_o3_eng_1', title: 'Reading and Comprehension', gradeLevel: 'Form 3', entries: [
      AnswerKeyEntry(question: 'Summarise the passage in your own words.', answer: 'A good summary captures the main points using different wording from the passage.', explanation: 'Focus on key ideas, not details. Use your own words.', marks: 5),
      AnswerKeyEntry(question: 'Explain the effect of the metaphor in paragraph 3.', answer: 'The metaphor creates a vivid image that helps the reader understand the feeling being described.', explanation: 'Identify the metaphor, then explain what image or feeling it creates.', marks: 3),
    ]),
  ],

  // ========== CAMBRIDGE IGCSE - MATHEMATICS ==========
  'cam_o3_mat': [
    AnswerKey(id: 'ak_cam_o3_mat_1', subjectId: 'cam_o3_mat', topicId: 'cam_o3_mat_1', title: 'Number and Algebra', gradeLevel: 'Form 3', entries: [
      AnswerKeyEntry(question: 'Simplify: 3x + 5x - 2x', answer: '6x', explanation: 'Combine like terms: 3x + 5x - 2x = (3+5-2)x = 6x.', marks: 2),
      AnswerKeyEntry(question: 'Solve: 2x + 5 = 13', answer: 'x = 4', explanation: '2x + 5 = 13 → 2x = 8 → x = 4.', marks: 3),
    ]),
  ],

  // ========== CAMBRIDGE IGCSE - BIOLOGY ==========
  'cam_o3_bio': [
    AnswerKey(id: 'ak_cam_o3_bio_1', subjectId: 'cam_o3_bio', topicId: 'cam_o3_bio_1', title: 'Cell Biology', gradeLevel: 'Form 3', entries: [
      AnswerKeyEntry(question: 'Name three differences between plant and animal cells.', answer: 'Plant cells have cell wall, chloroplasts, and permanent vacuole. Animal cells do not.', explanation: 'Plant cells need these for photosynthesis and structural support.', marks: 3),
      AnswerKeyEntry(question: 'What is the function of mitochondria?', answer: 'Mitochondria are the site of aerobic respiration, where glucose is broken down to release energy (ATP).', explanation: 'Mitochondria are called the powerhouse of the cell.', marks: 2),
    ]),
  ],

  // ========== CAMBRIDGE IGCSE - CHEMISTRY ==========
  'cam_o3_che': [
    AnswerKey(id: 'ak_cam_o3_che_1', subjectId: 'cam_o3_che', topicId: 'cam_o3_che_1', title: 'Atomic Structure', gradeLevel: 'Form 3', entries: [
      AnswerKeyEntry(question: 'Describe the structure of an atom.', answer: 'An atom has a nucleus containing protons and neutrons, surrounded by electrons in energy levels/shells.', explanation: 'Protons are positive, neutrons are neutral, electrons are negative.', marks: 3),
      AnswerKeyEntry(question: 'What is the atomic number of carbon?', answer: '6', explanation: 'Carbon has 6 protons in its nucleus. The atomic number equals the number of protons.', marks: 1),
    ]),
  ],

  // ========== CAMBRIDGE IGCSE - PHYSICS ==========
  'cam_o3_phy': [
    AnswerKey(id: 'ak_cam_o3_phy_1', subjectId: 'cam_o3_phy', topicId: 'cam_o3_phy_1', title: 'Mechanics', gradeLevel: 'Form 3', entries: [
      AnswerKeyEntry(question: 'A car accelerates from 0 to 20 m/s in 4 seconds. What is its acceleration?', answer: '5 m/s²', explanation: 'Acceleration = change in velocity / time = (20-0)/4 = 5 m/s².', marks: 3),
      AnswerKeyEntry(question: 'State Newton\'s First Law of Motion.', answer: 'An object remains at rest or moves in a straight line at constant speed unless acted upon by a resultant force.', explanation: 'This is also called the law of inertia.', marks: 2),
    ]),
  ],

  // ========== CAMBRIDGE IGCSE - ECONOMICS ==========
  'cam_o3_eco': [
    AnswerKey(id: 'ak_cam_o3_eco_1', subjectId: 'cam_o3_eco', topicId: 'cam_o3_eco_1', title: 'Basic Economic Ideas', gradeLevel: 'Form 3', entries: [
      AnswerKeyEntry(question: 'What is the basic economic problem?', answer: 'The basic economic problem is scarcity: unlimited wants but limited resources.', explanation: 'This forces societies to make choices about what to produce.', marks: 2),
      AnswerKeyEntry(question: 'Define opportunity cost.', answer: 'Opportunity cost is the next best alternative foregone when making a choice.', explanation: 'When you choose one thing, you give up something else. That something else is the opportunity cost.', marks: 2),
    ]),
  ],

  // ========== CAMBRIDGE A-LEVEL - MATHEMATICS ==========
  'cam_a5_mat': [
    AnswerKey(id: 'ak_cam_a5_mat_1', subjectId: 'cam_a5_mat', topicId: 'cam_a5_mat_1', title: 'Pure Mathematics 1', gradeLevel: 'Form 5', entries: [
      AnswerKeyEntry(question: 'Differentiate f(x) = 3x⁴ - 2x² + 5x - 1', answer: "f'(x) = 12x³ - 4x + 5", explanation: 'Apply the power rule: d/dx(xⁿ) = nxⁿ⁻¹ to each term.', marks: 4),
      AnswerKeyEntry(question: 'Find the integral of ∫(6x² + 4x) dx', answer: '2x³ + 2x² + C', explanation: 'Integrate term by term. Increase power by 1 and divide by new power.', marks: 3),
    ]),
  ],

  // ========== CAMBRIDGE A-LEVEL - BIOLOGY ==========
  'cam_a5_bio': [
    AnswerKey(id: 'ak_cam_a5_bio_1', subjectId: 'cam_a5_bio', topicId: 'cam_a5_bio_1', title: 'Cell Structure', gradeLevel: 'Form 5', entries: [
      AnswerKeyEntry(question: 'Describe the fluid mosaic model of cell membranes.', answer: 'The membrane consists of a phospholipid bilayer with proteins embedded in it. The bilayer is fluid, allowing lateral movement of components. Cholesterol and glycoproteins are also present.', explanation: 'Singer and Nicolson proposed this model in 1972.', marks: 5),
      AnswerKeyEntry(question: 'Explain the role of ribosomes in protein synthesis.', answer: 'Ribosomes read mRNA and assemble amino acids in the correct order using tRNA. They can be free in the cytoplasm or attached to rough ER.', explanation: 'Ribosomes are the site of translation.', marks: 3),
    ]),
  ],

  // ========== CAMBRIDGE A-LEVEL - CHEMISTRY ==========
  'cam_a5_che': [
    AnswerKey(id: 'ak_cam_a5_che_1', subjectId: 'cam_a5_che', topicId: 'cam_a5_che_1', title: 'Physical Chemistry', gradeLevel: 'Form 5', entries: [
      AnswerKeyEntry(question: 'Calculate the number of moles in 12g of carbon-12.', answer: '1 mole', explanation: 'Moles = mass / molar mass = 12g / 12g/mol = 1 mol.', marks: 2),
      AnswerKeyEntry(question: 'Explain what happens to the rate of reaction when temperature increases.', answer: 'Rate increases because particles have more kinetic energy, collide more frequently, and more collisions have energy greater than the activation energy.', explanation: 'Use the collision theory to explain rate changes.', marks: 4),
    ]),
  ],

  // ========== CAMBRIDGE A-LEVEL - PHYSICS ==========
  'cam_a5_phy': [
    AnswerKey(id: 'ak_cam_a5_phy_1', subjectId: 'cam_a5_phy', topicId: 'cam_a5_phy_1', title: 'Mechanics', gradeLevel: 'Form 5', entries: [
      AnswerKeyEntry(question: 'A ball is thrown vertically upward at 20 m/s. Calculate the maximum height reached. (g = 10 m/s²)', answer: '20 m', explanation: 'Using v² = u² + 2as: 0 = 400 - 20s, so s = 20m.', marks: 4),
      AnswerKeyEntry(question: 'State the principle of conservation of energy.', answer: 'Energy cannot be created or destroyed, only converted from one form to another. The total energy in a closed system remains constant.', explanation: 'This is a fundamental law of physics.', marks: 2),
    ]),
  ],
};

AnswerKey? getAnswerKey(String subjectId) {
  if (!answerKeysBySubject.containsKey(subjectId)) return null;
  final keys = answerKeysBySubject[subjectId]!;
  return keys.isNotEmpty ? keys.first : null;
}

List<AnswerKey> getAllAnswerKeysForGrade(String grade) {
  final result = <AnswerKey>[];
  for (final entry in answerKeysBySubject.entries) {
    result.addAll(entry.value.where((ak) => ak.gradeLevel.contains(grade)));
  }
  return result;
}

List<AnswerKey> getAnswerKeysForSubject(String subjectId) {
  return answerKeysBySubject[subjectId] ?? [];
}
