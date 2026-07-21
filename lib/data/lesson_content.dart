import '../models/lesson.dart';

final Map<String, List<Lesson>> lessonsByTopic = {
  // ======================== ECD A ========================
  'ecda_lan_1': [
    Lesson(
      id: 'lesson_ecda_lan_1',
      subjectId: 'ecda_lan',
      topicId: 'ecda_lan_1',
      title: 'Greetings and Introductions',
      gradeLevel: 'ECD A',
      objectives: [
        'Say hello and goodbye to others',
        'Say my name when someone asks',
        'Wave and smile when greeting',
      ],
      sections: [
        LessonSection(
          heading: 'Learning to Greet',
          content: 'Greeting is how we show respect and friendliness. When we meet someone, we say "Hello" or "Good morning". In Zimbabwe, we also greet in Shona saying "Mhoro" or in Ndebele saying "Sawubona".',
          bulletPoints: [
            'Wave your hand and smile when you greet',
            'Say "Good morning" in the morning',
            'Say "Good afternoon" after lunch',
            'Say "Goodbye" when leaving',
            'In Shona: "Mhoro" means hello',
            'In Ndebele: "Sawubona" means hello',
          ],
          imageHints: ['child_waving', 'two_children_greeting'],
          example: 'Parent: "Say hello to Auntie"\nChild: "Hello Auntie, good morning!"',
        ),
        LessonSection(
          heading: 'Saying Your Name',
          content: 'When you meet someone new, you should tell them your name. Your name is special and part of who you are!',
          bulletPoints: [
            'Say your full name clearly',
            'Ask "What is your name?" to others',
            'Remember your friends names',
          ],
          imageHints: ['child_saying_name', 'name_tags'],
        ),
      ],
      keyPoints: [
        'Greeting shows respect and kindness',
        'Always smile when you greet someone',
        'Use the right greeting for the time of day',
        'Be proud of your name',
      ],
      practiceQuestions: [
        PracticeQuestion(question: 'What do you say when you meet someone in the morning?', answer: 'Good morning', explanation: 'We say "Good morning" when we meet someone in the morning time.'),
        PracticeQuestion(question: 'How do you say hello in Shona?', answer: 'Mhoro', explanation: '"Mhoro" is the Shona word for hello.'),
      ],
      references: ['ECD A Language Activity Book', 'Zimbabwe Ministry of Education ECD Syllabus'],
      imageAssets: ['assets/ecd/greeting_1.png', 'assets/ecd/greeting_2.png'],
    ),
  ],
  'ecda_lan_2': [
    Lesson(
      id: 'lesson_ecda_lan_2',
      subjectId: 'ecda_lan',
      topicId: 'ecda_lan_2',
      title: 'Naming Body Parts and Objects',
      gradeLevel: 'ECD A',
      objectives: ['Name at least 5 body parts', 'Name common objects at home', 'Point to objects when asked'],
      sections: [
        LessonSection(heading: 'My Body Parts', content: 'Your body has many parts. Each part has a name and a special job to do. Let us learn the names of our body parts!',
          bulletPoints: ['Head - you think and see with your head', 'Eyes - you see with your eyes', 'Nose - you smell with your nose',
            'Mouth - you eat and speak with your mouth', 'Ears - you hear with your ears', 'Hands - you hold things with your hands',
            'Feet - you walk and run with your feet'],
          imageHints: ['body_parts_chart', 'child_pointing_to_nose'],
          example: 'Touch your nose! Can you find your ears?'),
        LessonSection(heading: 'Objects at Home', content: 'Look around your home. There are many objects. Let us learn their names.',
          bulletPoints: ['Table - we put food on the table', 'Chair - we sit on a chair', 'Cup - we drink from a cup',
            'Plate - we eat from a plate', 'Bed - we sleep on a bed', 'Book - we read a book'],
          imageHints: ['household_objects', 'child_with_cup']),
      ],
      keyPoints: ['Every body part has a special name', 'Objects around us have names too', 'Practice naming things every day'],
      practiceQuestions: [
        PracticeQuestion(question: 'What do you use to see?', answer: 'Eyes', explanation: 'We use our eyes to see the world around us.'),
        PracticeQuestion(question: 'What do you sit on?', answer: 'A chair', explanation: 'A chair is what we sit on at the table.'),
      ],
      references: ['ECD A Activity Book'],
    ),
  ],

  // ======================== ECD B ========================
  'ecdb_lan_1': [
    Lesson(
      id: 'lesson_ecdb_lan_1',
      subjectId: 'ecdb_lan',
      topicId: 'ecdb_lan_1',
      title: 'Letter Recognition and Sounds',
      gradeLevel: 'ECD B',
      objectives: ['Recognise letters A to Z', 'Say the sound of each letter', 'Find letters in words'],
      sections: [
        LessonSection(heading: 'Meet the Letters', content: 'Letters are like building blocks. When we put them together, they make words! There are 26 letters from A to Z.',
          bulletPoints: ['A says "a" as in apple', 'B says "b" as in ball', 'C says "c" as in cat',
            'Each letter has a name and a sound', 'Capital letters and small letters', 'Practice saying the alphabet every day'],
          imageHints: ['alphabet_chart', 'letter_cards'],
          example: 'A is for Apple. B is for Ball. C is for Cat.'),
        LessonSection(heading: 'Letter Sounds Game', content: 'Learning letter sounds is fun! Say the sound of each letter you see.',
          bulletPoints: ['Find something that starts with "b"', 'What sound does your name start with?', 'Clap when you hear the "a" sound',
            'Match letters to pictures', 'Sing the alphabet song'],
          imageHints: ['letter_matching_game', 'alphabet_song']),
      ],
      keyPoints: ['There are 26 letters in the alphabet', 'Each letter has a name and a sound', 'Letters make words'],
      practiceQuestions: [
        PracticeQuestion(question: 'What sound does the letter B make?', answer: '/b/ sound like in "ball"', explanation: 'B makes a /b/ sound. Put your lips together and push air out.'),
        PracticeQuestion(question: 'What letter starts the word "sun"?', answer: 'S', explanation: '"Sun" starts with the letter S. S makes a /s/ sound.'),
      ],
      references: ['ECD B Language Activity Book', 'Alphabet Songs and Rhymes'],
      imageAssets: ['assets/ecd/alphabet.png'],
    ),
  ],

  // ======================== GRADE 1 ========================
  'g1_eng_1': [
    Lesson(
      id: 'lesson_g1_eng_1',
      subjectId: 'g1_eng',
      topicId: 'g1_eng_1',
      title: 'Phonics: Learning Letter Sounds',
      gradeLevel: 'Grade 1',
      objectives: ['Recognise all consonant and vowel sounds', 'Blend sounds to make words', 'Read simple CVC words'],
      sections: [
        LessonSection(heading: 'Consonant Sounds', content: 'Consonants are letters that are not vowels. They make sounds by blocking air with your lips, tongue, or teeth.',
          bulletPoints: ['b, c, d, f, g, h, j, k, l, m, n, p, q, r, s, t, v, w, x, y, z', 'Practice each sound clearly',
            'Feel where your tongue goes for each sound', 'b = lips together, t = tongue behind teeth', 'Use mirror to watch your mouth'],
          example: 'b-b-b-ball, c-c-c-cat, d-d-d-dog'),
        LessonSection(heading: 'Vowel Sounds', content: 'Vowels are special letters: a, e, i, o, u. They make open sounds.',
          bulletPoints: ['a as in apple /a/', 'e as in egg /e/', 'i as in ink /i/',
            'o as in orange /o/', 'u as in up /u/', 'Vowels are the glue that holds words together'],
          example: 'a-p-p-l-e spells apple'),
        LessonSection(heading: 'Blending CVC Words', content: 'CVC means Consonant-Vowel-Consonant. These are simple words like c-a-t, d-o-g, s-u-n.',
          bulletPoints: ['Say each sound separately then fast', 'c-a-t -> cat', 'd-o-g -> dog',
            's-u-n -> sun', 'p-i-g -> pig', 'h-e-n -> hen'],
          imageHints: ['cvc_word_cards', 'phonics_chart'],
          example: 'c + a + t = cat. Now you try!'),
      ],
      keyPoints: ['Consonants block air, vowels let air flow', 'Blend sounds together to read words', 'Practice makes perfect'],
      practiceQuestions: [
        PracticeQuestion(question: 'What word do these sounds make: m-a-t?', answer: 'mat', explanation: 'm + a + t blended together makes "mat".'),
        PracticeQuestion(question: 'What sound does the letter "s" make?', answer: '/s/ like in "sun"', explanation: 'S makes a soft hissing sound like a snake.'),
      ],
      references: ['Step In English Grade 1', 'Phonics Activity Book'],
    ),
  ],
  'g1_mat_1': [
    Lesson(
      id: 'lesson_g1_mat_1',
      subjectId: 'g1_mat',
      topicId: 'g1_mat_1',
      title: 'Numbers 1 to 100',
      gradeLevel: 'Grade 1',
      objectives: ['Count from 1 to 100', 'Recognise numbers up to 100', 'Understand tens and ones'],
      sections: [
        LessonSection(heading: 'Counting 1 to 20', content: 'Counting is one of the first maths skills you learn. Let us count from 1 to 20 together!',
          bulletPoints: ['1, 2, 3, 4, 5, 6, 7, 8, 9, 10', '11, 12, 13, 14, 15, 16, 17, 18, 19, 20',
            'Use your fingers to help count', 'Count objects around you', 'Count your toys, books, and friends'],
          imageHints: ['counting_chart', 'fingers_counting'],
          example: 'Count the apples: 1, 2, 3, 4, 5. There are 5 apples!'),
        LessonSection(heading: 'Counting to 100', content: 'When we reach 20, we keep going. Numbers after 20 follow a pattern.',
          bulletPoints: ['21, 22, 23... up to 29', '30, 40, 50, 60, 70, 80, 90, 100',
            'Count by tens: 10, 20, 30, 40, 50, 60, 70, 80, 90, 100', 'Use a 100 chart to practise',
            'Point to each number as you say it'],
          imageHints: ['hundred_chart', 'counting_stones']),
        LessonSection(heading: 'Tens and Ones', content: 'Every number is made of tens and ones. The tens are groups of ten.',
          bulletPoints: ['15 = 1 ten and 5 ones', '23 = 2 tens and 3 ones', '47 = 4 tens and 7 ones',
            '70 = 7 tens and 0 ones', 'Tens are the first digit, ones are the second digit'],
          example: 'In the number 34, the 3 means 3 tens (30) and the 4 means 4 ones.'),
      ],
      keyPoints: ['Count from 1 to 100 in order', 'Numbers are made of tens and ones', 'Practice counting every day'],
      practiceQuestions: [
        PracticeQuestion(question: 'Count from 1 to 10.', answer: '1, 2, 3, 4, 5, 6, 7, 8, 9, 10', explanation: 'These are the first ten numbers we learn.'),
        PracticeQuestion(question: 'What number comes after 19?', answer: '20', explanation: 'After 19 comes 20. We say it as "twenty".'),
      ],
      references: ['Step In Mathematics Grade 1'],
    ),
  ],
  'g1_hss_1': [
    Lesson(
      id: 'lesson_g1_hss_1',
      subjectId: 'g1_hss',
      topicId: 'g1_hss_1',
      title: 'My Family and Community',
      gradeLevel: 'Grade 1',
      objectives: ['Identify family members', 'Describe roles at home', 'Recognise community helpers'],
      sections: [
        LessonSection(heading: 'My Family', content: 'A family is a group of people who love and care for each other. Families come in different sizes.',
          bulletPoints: ['Mother, father, brothers, sisters', 'Grandparents, aunts, uncles, cousins', 'Each family member has a role',
            'Mothers and fathers care for children', 'Children help at home', 'Grandparents share stories and wisdom'],
          imageHints: ['family_group', 'family_activities'],
          example: 'In my family, I help by setting the table. My mother cooks and my father tells stories.'),
        LessonSection(heading: 'Community Helpers', content: 'Our community has special people who help us every day.',
          bulletPoints: ['Teachers help us learn', 'Nurses and doctors keep us healthy', 'Police officers keep us safe',
            'Farmers grow our food', 'Shopkeepers sell us what we need', 'We should respect all community helpers'],
          imageHints: ['community_helpers_collage', 'teacher_in_classroom']),
      ],
      keyPoints: ['Family members love and care for each other', 'Everyone has a role in the family', 'Community helpers make our lives better'],
      practiceQuestions: [
        PracticeQuestion(question: 'Who teaches you at school?', answer: 'A teacher', explanation: 'Teachers help us learn new things at school.'),
        PracticeQuestion(question: 'Name two people in your family.', answer: 'Any two family members', explanation: 'Your family includes people who live with you or are related to you.'),
      ],
      references: ['Heritage-Social Studies Grade 1', 'My Community Activity Book'],
    ),
  ],

  // ======================== GRADE 2 ========================
  'g2_eng_1': [
    Lesson(
      id: 'lesson_g2_eng_1',
      subjectId: 'g2_eng',
      topicId: 'g2_eng_1',
      title: 'Reading Comprehension',
      gradeLevel: 'Grade 2',
      objectives: ['Read simple passages fluently', 'Identify the main idea', 'Answer questions about what you read'],
      sections: [
        LessonSection(heading: 'Understanding What You Read', content: 'Reading is not just about saying words. It is about understanding the story or information.',
          bulletPoints: ['Read each sentence carefully', 'Think about what is happening', 'Look at pictures for clues',
            'Ask yourself: Who, What, Where, When, Why', 'Connect the story to your own life'],
          example: 'Read: "The sun was shining. Chipo played outside with her dog." Main idea: Chipo is playing outside on a sunny day.'),
        LessonSection(heading: 'Finding the Main Idea', content: 'The main idea is what the passage is mostly about.',
          bulletPoints: ['The main idea is the most important point', 'Details support the main idea', 'Ask "What is this about?"',
            'Look at the title for hints', 'The first sentence often tells the main idea'],
          example: 'Passage about planting maize -> Main idea: How to grow maize.'),
      ],
      keyPoints: ['Read carefully and think about the meaning', 'The main idea is the most important part', 'Look for details that support the main idea'],
      practiceQuestions: [
        PracticeQuestion(question: 'What is the main idea of a story about going to the market?', answer: 'Going to the market and what happens there', explanation: 'The main idea is the big picture of what the story is about.'),
        PracticeQuestion(question: 'If a passage is about a happy dog playing, what is the main idea?', answer: 'A dog playing happily', explanation: 'The whole passage is describing the dog having fun while playing.'),
      ],
      references: ['Step In English Grade 2'],
    ),
  ],
  'g2_mat_1': [
    Lesson(
      id: 'lesson_g2_mat_1',
      subjectId: 'g2_mat',
      topicId: 'g2_mat_1',
      title: 'Introduction to Multiplication',
      gradeLevel: 'Grade 2',
      objectives: ['Understand multiplication as repeated addition', 'Learn multiplication tables 1-5', 'Solve simple multiplication problems'],
      sections: [
        LessonSection(heading: 'Multiplication is Repeated Addition', content: 'Multiplication is a fast way of adding the same number many times.',
          bulletPoints: ['3 x 4 means 3 groups of 4', '3 x 4 = 4 + 4 + 4 = 12', 'The x sign means "groups of" or "times"',
            'Multiplication helps us count faster', 'Arrays show multiplication in rows and columns'],
          imageHints: ['multiplication_array', 'groups_of_dots'],
          example: '2 x 3 = 3 + 3 = 6. Two groups of three equals six.'),
        LessonSection(heading: 'Times Tables 1 to 5', content: 'Times tables help us remember multiplication facts quickly.',
          bulletPoints: ['1 x 1 = 1, 1 x 2 = 2, 1 x 3 = 3...', '2 x 1 = 2, 2 x 2 = 4, 2 x 3 = 6...',
            '3 x 1 = 3, 3 x 2 = 6, 3 x 3 = 9...', '4 x 1 = 4, 4 x 2 = 8, 4 x 3 = 12...',
            '5 x 1 = 5, 5 x 2 = 10, 5 x 3 = 15...', 'Practice every day for 5 minutes'],
          example: 'If you have 4 bags with 2 oranges each: 4 x 2 = 8 oranges.'),
      ],
      keyPoints: ['Multiplication is adding the same number repeatedly', 'Times tables help you calculate fast', 'Practice your tables every day'],
      practiceQuestions: [
        PracticeQuestion(question: 'What is 3 x 4?', answer: '12', explanation: '3 x 4 means 3 groups of 4. 4 + 4 + 4 = 12.'),
        PracticeQuestion(question: 'If there are 2 rows of 5 chairs, how many chairs?', answer: '10', explanation: '2 x 5 = 10. Two rows with five chairs each makes 10 chairs.'),
      ],
      references: ['Step In Mathematics Grade 2'],
    ),
  ],

  // ======================== GRADE 3 ========================
  'g3_mat_1': [
    Lesson(
      id: 'lesson_g3_mat_1',
      subjectId: 'g3_mat',
      topicId: 'g3_mat_1',
      title: 'Understanding Fractions',
      gradeLevel: 'Grade 3',
      objectives: ['Understand fractions as parts of a whole', 'Identify halves, thirds, and quarters', 'Recognise equivalent fractions'],
      sections: [
        LessonSection(heading: 'What is a Fraction?', content: 'A fraction is a part of a whole. When we share something equally, we are making fractions.',
          bulletPoints: ['The top number is the numerator (how many parts)', 'The bottom number is the denominator (total parts)',
            '1/2 means 1 part out of 2 equal parts', '1/4 means 1 part out of 4 equal parts',
            'The bigger the denominator, the smaller the parts'],
          imageHints: ['fraction_pizza', 'fraction_circles'],
          example: 'If you cut a sadza into 4 pieces and eat 1, you have eaten 1/4 of the sadza.'),
        LessonSection(heading: 'Halves and Quarters', content: 'Halves and quarters are the most common fractions we use every day.',
          bulletPoints: ['Half = 1/2 = one of two equal parts', 'Quarter = 1/4 = one of four equal parts',
            'Two quarters = one half (2/4 = 1/2)', 'Three quarters = 3/4', 'A half is bigger than a quarter'],
          example: 'If you share a mango equally with your friend, you each get 1/2 of the mango.'),
      ],
      keyPoints: ['A fraction is part of a whole', 'The denominator tells how many equal parts', 'The numerator tells how many parts we have'],
      practiceQuestions: [
        PracticeQuestion(question: 'What fraction is one piece of a sadza cut into 4 pieces?', answer: '1/4 (one quarter)', explanation: 'When something is cut into 4 equal pieces, each piece is one quarter (1/4).'),
        PracticeQuestion(question: 'How many quarters make a half?', answer: '2 quarters', explanation: '2/4 = 1/2. Two quarters equal one half.'),
      ],
      references: ['Step In Mathematics Grade 3'],
    ),
  ],
  'g3_sci_1': [
    Lesson(
      id: 'lesson_g3_sci_1',
      subjectId: 'g3_sci',
      topicId: 'g3_sci_1',
      title: 'Plants and Animals Around Us',
      gradeLevel: 'Grade 3',
      objectives: ['Classify plants and animals', 'Identify different habitats', 'Understand simple food chains'],
      sections: [
        LessonSection(heading: 'Living Things', content: 'Plants and animals are living things. They grow, need food and water, and can make more of themselves.',
          bulletPoints: ['Plants make their own food using sunlight', 'Animals eat plants or other animals', 'Living things need water, air, and food',
            'Non-living things do not grow or need food', 'Rocks, water, and air are non-living'],
          imageHints: ['plants_and_animals', 'living_things_chart'],
          example: 'A maize plant is a living thing. It grows from a seed, needs water and sunlight, and makes more maize.'),
        LessonSection(heading: 'Food Chains', content: 'A food chain shows who eats what in nature.',
          bulletPoints: ['Plants are producers (make their own food)', 'Plant-eaters are called herbivores', 'Meat-eaters are called carnivores',
            'Animals that eat both are omnivores', 'The sun is the start of most food chains'],
          example: 'Sun -> Grass -> Cow -> Lion. The grass uses sunlight to grow, the cow eats the grass, the lion eats the cow.'),
      ],
      keyPoints: ['Living things grow, need food, and reproduce', 'Plants produce their own food, animals eat other things', 'Food chains show energy flow in nature'],
      practiceQuestions: [
        PracticeQuestion(question: 'Is a rock a living thing? Why?', answer: 'No, because it does not grow, need food, or reproduce', explanation: 'Rocks are non-living. They do not grow, eat, or make baby rocks.'),
        PracticeQuestion(question: 'What does a herbivore eat?', answer: 'Plants', explanation: 'Herbivores are animals that eat only plants. Cows, goats, and giraffes are herbivores.'),
      ],
      references: ['General Science Grade 3'],
    ),
  ],

  // ======================== GRADE 4 ========================
  'g4_eng_1': [
    Lesson(
      id: 'lesson_g4_eng_1',
      subjectId: 'g4_eng',
      topicId: 'g4_eng_1',
      title: 'Composition Writing',
      gradeLevel: 'Grade 4',
      objectives: ['Structure an essay with introduction, body, and conclusion', 'Write narrative and descriptive essays', 'Edit and revise your writing'],
      sections: [
        LessonSection(heading: 'Essay Structure', content: 'Every good essay has three main parts: the beginning, the middle, and the end.',
          bulletPoints: ['Introduction: Tell them what you will write about', 'Body: Give details, examples, and explanations',
            'Conclusion: Sum up your main points', 'Each paragraph should have one main idea', 'Use connecting words like "first", "then", "finally"'],
          example: 'Topic: My Village\nIntro: My village is a beautiful place in Manicaland.\nBody: The hills are green, the rivers are clean, and the people are friendly.\nConclusion: I love visiting my village because it is peaceful and beautiful.'),
        LessonSection(heading: 'Descriptive Writing', content: 'Descriptive writing paints a picture with words. Use your five senses!',
          bulletPoints: ['Describe what you SEE', 'Describe what you HEAR', 'Describe what you SMELL',
            'Describe what you TASTE', 'Describe what you FEEL (touch)', 'Use interesting adjectives'],
          example: 'The market was alive with colour. I saw bright green vegetables and red tomatoes. I heard people laughing and bargaining. I smelled roasted maize and fresh fruit.'),
      ],
      keyPoints: ['Every essay needs an introduction, body, and conclusion', 'Use descriptive words to make writing interesting', 'Always edit your work before submitting'],
      practiceQuestions: [
        PracticeQuestion(question: 'What are the three parts of an essay?', answer: 'Introduction, body, and conclusion', explanation: 'The introduction starts your essay, the body gives details, and the conclusion sums up.'),
        PracticeQuestion(question: 'What should you use to describe things in writing?', answer: 'Your five senses: sight, hearing, smell, taste, touch', explanation: 'Using the five senses makes your writing vivid and interesting for the reader.'),
      ],
      references: ['Step In English Grade 4'],
    ),
  ],
  'g4_hss_1': [
    Lesson(
      id: 'lesson_g4_hss_1',
      subjectId: 'g4_hss',
      topicId: 'g4_hss_1',
      title: 'History of Zimbabwe',
      gradeLevel: 'Grade 4',
      objectives: ['Understand the early history of Zimbabwe', 'Learn about Great Zimbabwe', 'Know the colonial period and independence'],
      sections: [
        LessonSection(heading: 'Early Zimbabwe', content: 'Zimbabwe has a rich history dating back thousands of years. The name "Zimbabwe" means "house of stone" in Shona.',
          bulletPoints: ['The San people were the earliest inhabitants', 'Great Zimbabwe was built between 1100-1450 AD',
            'It was a centre of trade and power', 'The Mutapa State followed Great Zimbabwe', 'The Rozvi Empire was the last pre-colonial kingdom'],
          imageHints: ['great_zimbabwe_ruins', 'zimbabwe_map_historical'],
          example: 'Great Zimbabwe is a UNESCO World Heritage Site. Its stone walls were built without mortar, yet they have stood for over 800 years!'),
        LessonSection(heading: 'Colonial Period and Independence', content: 'Zimbabwe was colonised by the British in 1890 and called Rhodesia. After a long liberation struggle, Zimbabwe became independent in 1980.',
          bulletPoints: ['British colonisation in 1890', 'Land was taken from African people', 'The liberation struggle lasted from 1964-1979',
            'Robert Mugabe became first Prime Minister', 'Independence Day is 18 April 1980'],
          imageHints: ['independence_celebration', 'zimbabwe_flag']),
      ],
      keyPoints: ['Zimbabwe has a long and proud history', 'Great Zimbabwe was a great African civilisation', 'Independence was won through struggle and sacrifice'],
      practiceQuestions: [
        PracticeQuestion(question: 'What does "Zimbabwe" mean?', answer: 'House of stone', explanation: 'The name Zimbabwe comes from the Shona words "dzimba" (houses) and "mabwe" (stones).'),
        PracticeQuestion(question: 'When did Zimbabwe become independent?', answer: '18 April 1980', explanation: 'Zimbabwe gained independence on 18 April 1980 after a long liberation struggle.'),
      ],
      references: ['Heritage-Social Studies Grade 4'],
    ),
  ],

  // ======================== GRADE 5 ========================
  'g5_eng_1': [
    Lesson(
      id: 'lesson_g5_eng_1',
      subjectId: 'g5_eng',
      topicId: 'g5_eng_1',
      title: 'Essay Writing Skills',
      gradeLevel: 'Grade 5',
      objectives: ['Write argumentative essays with clear positions', 'Develop expository writing skills', 'Plan essays effectively before writing'],
      sections: [
        LessonSection(heading: 'Argumentative Essays', content: 'An argumentative essay takes a position and defends it with evidence and reasoning.',
          bulletPoints: ['State your position clearly in the introduction', 'Each paragraph should support your position',
            'Use facts, examples, and logical reasoning', 'Address counterarguments respectfully', 'Conclude by reinforcing your position'],
          example: 'Topic: Should children help with housework?\nPosition: Yes, children should help.\nReason 1: It teaches responsibility.\nReason 2: It helps the family.\nReason 3: It builds life skills.'),
        LessonSection(heading: 'Essay Planning', content: 'Good essays start with good planning. Never start writing without a plan!',
          bulletPoints: ['Brainstorm ideas about the topic', 'Group similar ideas together', 'Organise ideas into a logical order',
            'Write a thesis statement (main argument)', 'Plan each paragraph before writing'],
          example: 'Use a mind map: Write the topic in the centre, then branch out with main ideas, then add supporting details.'),
      ],
      keyPoints: ['An argumentative essay takes a clear position', 'Support your position with evidence and reasoning', 'Always plan your essay before writing'],
      practiceQuestions: [
        PracticeQuestion(question: 'What is the purpose of an argumentative essay?', answer: 'To take a position and defend it with evidence', explanation: 'An argumentative essay convinces the reader to agree with your point of view using facts and reasoning.'),
        PracticeQuestion(question: 'What should you do before writing an essay?', answer: 'Plan and organise your ideas', explanation: 'Planning helps you organise your thoughts and write a more coherent essay.'),
      ],
      references: ['Step In English Grade 5'],
    ),
  ],
  'g5_sci_1': [
    Lesson(
      id: 'lesson_g5_sci_1',
      subjectId: 'g5_sci',
      topicId: 'g5_sci_1',
      title: 'States of Matter',
      gradeLevel: 'Grade 5',
      objectives: ['Identify the three states of matter', 'Understand how matter changes state', 'Describe the particle model'],
      sections: [
        LessonSection(heading: 'Solids, Liquids, and Gases', content: 'Everything around you is made of matter. Matter comes in three main states.',
          bulletPoints: ['Solids have a fixed shape and volume (rock, wood, ice)', 'Liquids flow and take the shape of their container (water, oil, milk)',
            'Gases spread out to fill any space (air, steam, oxygen)', 'Particles in solids are tightly packed', 'Particles in liquids can slide past each other',
            'Particles in gases move freely and fast'],
          example: 'Water is a liquid. When you freeze it, it becomes solid ice. When you boil it, it becomes steam (gas).'),
        LessonSection(heading: 'Changing States', content: 'Matter can change from one state to another by heating or cooling.',
          bulletPoints: ['Melting: solid to liquid (ice to water)', 'Freezing: liquid to solid (water to ice)', 'Boiling/Evaporation: liquid to gas (water to steam)',
            'Condensation: gas to liquid (steam to water)', 'Sublimation: solid to gas (dry ice)',
            'These changes are called physical changes'],
          imageHints: ['water_cycle_diagram', 'states_of_matter'],
          example: 'When you boil water for sadza, the water turns into steam (gas). The steam rises and if it touches a cold lid, it turns back into liquid water (condensation).'),
      ],
      keyPoints: ['Matter exists as solid, liquid, or gas', 'Heating and cooling change states of matter', 'The particle model explains how states behave'],
      practiceQuestions: [
        PracticeQuestion(question: 'What happens to water when you freeze it?', answer: 'It becomes solid ice', explanation: 'When water is cooled below 0°C, it freezes and becomes solid ice.'),
        PracticeQuestion(question: 'Why can you smell food cooking from another room?', answer: 'The particles of the food spread through the air as a gas', explanation: 'When food cooks, some particles turn into gas and travel through the air to your nose.'),
      ],
      references: ['General Science Grade 5'],
    ),
  ],

  // ======================== GRADE 6 ========================
  'g6_mat_1': [
    Lesson(
      id: 'lesson_g6_mat_1',
      subjectId: 'g6_mat',
      topicId: 'g6_mat_1',
      title: 'Advanced Algebra: Equations and Inequalities',
      gradeLevel: 'Grade 6',
      objectives: ['Solve linear equations with one variable', 'Solve simple inequalities', 'Factorise algebraic expressions'],
      sections: [
        LessonSection(heading: 'Solving Linear Equations', content: 'An equation shows that two things are equal. We solve equations to find the value of the unknown variable.',
          bulletPoints: ['The goal is to get the variable alone on one side', 'Whatever you do to one side, do to the other',
            'Add or subtract first, then multiply or divide', 'Check your answer by substituting back', 'Use inverse operations to undo'],
          example: 'Solve: 2x + 5 = 13\n2x + 5 - 5 = 13 - 5\n2x = 8\n2x/2 = 8/2\nx = 4\nCheck: 2(4) + 5 = 8 + 5 = 13 ✓'),
        LessonSection(heading: 'Inequalities', content: 'Inequalities show that two things are not equal. They use <, >, ≤, and ≥ symbols.',
          bulletPoints: ['< means less than', '> means greater than', '≤ means less than or equal to',
            '≥ means greater than or equal to', 'Solve inequalities like equations', 'Flip the sign when multiplying or dividing by a negative number'],
          example: 'Solve: 3x - 7 > 8\n3x > 15\nx > 5\nThis means x can be any number greater than 5.'),
      ],
      keyPoints: ['Equations show equality, inequalities show comparison', 'Use inverse operations to solve equations', 'Always check your answer'],
      practiceQuestions: [
        PracticeQuestion(question: 'Solve: 3x + 7 = 22', answer: 'x = 5', explanation: '3x + 7 = 22 -> 3x = 15 -> x = 5'),
        PracticeQuestion(question: 'Solve: 2x - 3 > 7', answer: 'x > 5', explanation: '2x - 3 > 7 -> 2x > 10 -> x > 5'),
      ],
      references: ['Step In Mathematics Grade 6'],
    ),
  ],

  // ======================== GRADE 7 ========================
  'g7_eng_1': [
    Lesson(
      id: 'lesson_g7_eng_1',
      subjectId: 'g7_eng',
      topicId: 'g7_eng_1',
      title: 'Grade 7 Exam Preparation',
      gradeLevel: 'Grade 7',
      objectives: ['Practice past exam papers effectively', 'Apply exam techniques and strategies', 'Manage time during exams'],
      sections: [
        LessonSection(heading: 'Exam Techniques', content: 'Knowing the content is only half the battle. You also need to know how to take the exam.',
          bulletPoints: ['Read all instructions carefully before starting', 'Scan through the entire paper first',
            'Answer easy questions first, then difficult ones', 'Allocate time based on marks per question',
            'Leave time to review your answers', 'Never leave a question unanswered'],
          example: 'If a paper has 5 sections worth 10 marks each, spend about 12 minutes on each section in a 1-hour exam.'),
        LessonSection(heading: 'Common Exam Mistakes', content: 'Avoid these common mistakes that cost students marks.',
          bulletPoints: ['Not reading the question properly', 'Running out of time on high-mark questions', 'Not showing working in maths',
            'Writing illegibly', 'Not checking spelling and grammar', 'Panicking and giving up'],
          example: 'For a "discuss" question, do not just list points. Explain each point with examples and reasons.'),
      ],
      keyPoints: ['Read instructions carefully', 'Manage your time wisely', 'Show all your working', 'Review your answers before submitting'],
      practiceQuestions: [
        PracticeQuestion(question: 'What should you do first when you receive an exam paper?', answer: 'Read all instructions and scan through the paper', explanation: 'Understanding the instructions and seeing the full paper helps you plan your time.'),
        PracticeQuestion(question: 'How should you decide how much time to spend on each question?', answer: 'Based on the marks each question is worth', explanation: 'Spend more time on questions worth more marks. A 10-mark question deserves more time than a 2-mark question.'),
      ],
      references: ['Grade 7 Past Exam Papers', 'Step In English Grade 7'],
    ),
  ],

  // ======================== FORM 1 ========================
  'o1_mat_1': [
    Lesson(
      id: 'lesson_o1_mat_1',
      subjectId: 'o1_mat',
      topicId: 'o1_mat_1',
      title: 'Number Theory: Sets, Factors, and Indices',
      gradeLevel: 'Form 1',
      objectives: ['Understand set notation and operations', 'Find factors, multiples, LCM and HCF', 'Work with indices and standard form'],
      sections: [
        LessonSection(heading: 'Sets and Set Notation', content: 'A set is a collection of distinct objects. Sets are the foundation of modern mathematics.',
          bulletPoints: ['A = {1, 2, 3, 4, 5} means set A contains 1, 2, 3, 4, 5', '∈ means "is an element of"', '∉ means "is not an element of"',
            'Union (∪) combines all elements from both sets', 'Intersection (∩) gives only common elements',
            'The empty set has no elements: {} or ∅'],
          example: 'A = {1, 2, 3}, B = {3, 4, 5}\nA ∪ B = {1, 2, 3, 4, 5}\nA ∩ B = {3}'),
        LessonSection(heading: 'LCM and HCF', content: 'LCM (Lowest Common Multiple) and HCF (Highest Common Factor) help us work with numbers.',
          bulletPoints: ['Factors are numbers that divide exactly into another number', 'Multiples are numbers we get by multiplying',
            'HCF is the largest factor shared by two numbers', 'LCM is the smallest multiple shared by two numbers',
            'Use prime factorisation to find LCM and HCF'],
          example: 'Find LCM and HCF of 12 and 18.\nFactors of 12: 1,2,3,4,6,12\nFactors of 18: 1,2,3,6,9,18\nHCF = 6\nMultiples of 12: 12,24,36,48...\nMultiples of 18: 18,36,54...\nLCM = 36'),
        LessonSection(heading: 'Indices and Standard Form', content: 'Indices (powers) tell us how many times to multiply a number by itself.',
          bulletPoints: ['3² = 3 × 3 = 9', '2³ = 2 × 2 × 2 = 8', '5⁰ = 1 (any number to power 0 is 1)',
            '10⁶ = 1,000,000 (standard form: 1 × 10⁶)', 'Very large and small numbers use standard form',
            'Standard form: a × 10ⁿ where 1 ≤ a < 10'],
          example: '3² × 3⁴ = 3⁶ (add the powers)\n(2³)² = 2⁶ (multiply the powers)\n4,000,000 = 4 × 10⁶'),
      ],
      keyPoints: ['Sets are collections of objects with operations like union and intersection', 'LCM and HCF help with fractions and number work', 'Indices make it easy to work with large numbers'],
      practiceQuestions: [
        PracticeQuestion(question: 'If A = {1, 2, 3} and B = {2, 3, 4}, what is A ∩ B?', answer: '{2, 3}', explanation: 'A ∩ B means the elements that are in both A and B. Both contain 2 and 3.'),
        PracticeQuestion(question: 'Find the LCM of 6 and 8.', answer: '24', explanation: 'Multiples of 6: 6,12,18,24,30... Multiples of 8: 8,16,24,32... The LCM is 24.'),
        PracticeQuestion(question: 'Write 5,600,000 in standard form.', answer: '5.6 × 10⁶', explanation: '5.6 × 10⁶ = 5.6 × 1,000,000 = 5,600,000'),
      ],
      references: ['Complete Mathematics for Form 1', 'ZIMSEC O-Level Mathematics Syllabus'],
    ),
  ],
  'o1_eng_1': [
    Lesson(
      id: 'lesson_o1_eng_1',
      subjectId: 'o1_eng',
      topicId: 'o1_eng_1',
      title: 'Grammar and Sentence Structure',
      gradeLevel: 'Form 1',
      objectives: ['Identify all parts of speech', 'Construct complex sentences', 'Use active and passive voice correctly'],
      sections: [
        LessonSection(heading: 'Parts of Speech', content: 'Every word in English belongs to a part of speech. Knowing them helps you understand and write better.',
          bulletPoints: ['Noun: names a person, place, thing, or idea (Zimbabwe, teacher, freedom)', 'Pronoun: replaces a noun (he, she, it, they, we)',
            'Verb: shows action or state (run, is, think)', 'Adjective: describes a noun (beautiful, tall, clever)',
            'Adverb: describes a verb (quickly, loudly, well)', 'Preposition: shows relationship (in, on, at, under, above)',
            'Conjunction: connects words or sentences (and, but, because)', 'Interjection: shows emotion (Wow! Oh! Alas!)'],
          example: '"The clever students quickly completed their difficult homework."\nThe (article), clever (adj), students (noun), quickly (adv), completed (verb), their (pronoun), difficult (adj), homework (noun).'),
        LessonSection(heading: 'Active and Passive Voice', content: 'Voice shows whether the subject performs or receives the action.',
          bulletPoints: ['Active: The subject performs the action (The boy kicked the ball)', 'Passive: The subject receives the action (The ball was kicked by the boy)',
            'Passive voice uses "to be" + past participle', 'Active voice is usually stronger and clearer', 'Passive voice is useful when the doer is unknown or unimportant'],
          example: 'Active: The teacher marked the homework.\nPassive: The homework was marked by the teacher.\nPassive (without doer): The homework was marked.'),
      ],
      keyPoints: ['There are 8 parts of speech in English', 'Active voice is stronger and more direct', 'Passive voice shifts focus to the action or receiver'],
      practiceQuestions: [
        PracticeQuestion(question: 'Identify the parts of speech: "The tall girl sang beautifully."', answer: 'The (article), tall (adj), girl (noun), sang (verb), beautifully (adv)', explanation: 'Each word has a specific function in the sentence.'),
        PracticeQuestion(question: 'Change to passive voice: "The dog chased the cat."', answer: 'The cat was chased by the dog.', explanation: 'In passive voice, the object becomes the subject. Use "was/were" + past participle.'),
      ],
      references: ['New Express English Form 1', 'English Grammar in Use'],
    ),
  ],

  // ======================== FORM 3 ========================
  'o3_bio_1': [
    Lesson(
      id: 'lesson_o3_bio_1',
      subjectId: 'o3_bio',
      topicId: 'o3_bio_1',
      title: 'Cell Biology: Structure and Function',
      gradeLevel: 'Form 3',
      objectives: ['Describe cell structures and their functions', 'Differentiate between plant and animal cells', 'Explain cell transport mechanisms'],
      sections: [
        LessonSection(heading: 'Cell Structure', content: 'The cell is the basic unit of life. All living things are made of cells.',
          bulletPoints: ['Cell membrane: controls what enters and leaves the cell', 'Cytoplasm: jelly-like substance where reactions happen',
            'Nucleus: contains DNA and controls the cell', 'Mitochondria: powerhouses that release energy',
            'Ribosomes: make proteins', 'Plant cells also have: cell wall, chloroplasts, and a large vacuole'],
          imageHints: ['plant_cell_diagram', 'animal_cell_diagram'],
          example: 'A cheek cell (animal) is different from a leaf cell (plant). Leaf cells have chloroplasts for photosynthesis, which cheek cells do not need.'),
        LessonSection(heading: 'Cell Transport', content: 'Substances move in and out of cells through the cell membrane.',
          bulletPoints: ['Diffusion: movement from high to low concentration (no energy needed)', 'Osmosis: diffusion of water through a membrane',
            'Active transport: movement against concentration (needs energy)', 'Remember: diffusion is passive, active transport needs energy'],
          example: 'When you put a raisin in water, it swells up. This is because water enters the raisin by osmosis.'),
      ],
      keyPoints: ['Cells are the basic unit of life', 'Plant cells have cell walls, chloroplasts, and large vacuoles', 'Substances move across cell membranes by diffusion, osmosis, or active transport'],
      practiceQuestions: [
        PracticeQuestion(question: 'What is the function of the nucleus?', answer: 'Contains DNA and controls cell activities', explanation: 'The nucleus is the control centre of the cell. It contains genetic material (DNA).'),
        PracticeQuestion(question: 'What is the difference between diffusion and active transport?', answer: 'Diffusion does not need energy, active transport does', explanation: 'Diffusion moves particles down the concentration gradient naturally. Active transport moves them against the gradient using energy.'),
      ],
      references: ['Biology Form 3', 'O-Level Biology Revision Guide'],
    ),
  ],
  'o3_che_1': [
    Lesson(
      id: 'lesson_o3_che_1',
      subjectId: 'o3_che',
      topicId: 'o3_che_1',
      title: 'Atomic Structure and Bonding',
      gradeLevel: 'Form 3',
      objectives: ['Describe the structure of an atom', 'Understand electron configuration', 'Explain ionic and covalent bonding'],
      sections: [
        LessonSection(heading: 'The Atom', content: 'Atoms are the building blocks of all matter. They are incredibly small.',
          bulletPoints: ['Protons: positive charge, in the nucleus', 'Neutrons: no charge, in the nucleus',
            'Electrons: negative charge, orbit the nucleus in shells', 'Atomic number = number of protons',
            'Mass number = protons + neutrons', 'Electrons are arranged in shells (2, 8, 8...)'],
          example: 'Carbon: atomic number 6, mass number 12. It has 6 protons, 6 neutrons, and 6 electrons (2 in first shell, 4 in second shell).'),
        LessonSection(heading: 'Chemical Bonding', content: 'Atoms bond together to form compounds. They do this by sharing or transferring electrons.',
          bulletPoints: ['Ionic bonding: transfer of electrons (metal + non-metal)', 'Covalent bonding: sharing of electrons (non-metal + non-metal)',
            'In ionic bonding, atoms become ions (charged particles)', 'Sodium chloride (table salt) is an ionic compound',
            'Water (H₂O) is a covalent compound', 'The type of bond affects properties'],
          example: 'NaCl (salt): Sodium gives one electron to chlorine. Sodium becomes Na⁺, chlorine becomes Cl⁻. They are held together by opposite charges.'),
      ],
      keyPoints: ['Atoms have protons, neutrons, and electrons', 'Electrons are arranged in shells', 'Ionic bonds transfer electrons, covalent bonds share electrons'],
      practiceQuestions: [
        PracticeQuestion(question: 'What particles make up the nucleus of an atom?', answer: 'Protons and neutrons', explanation: 'The nucleus is at the centre of the atom and contains protons (positive) and neutrons (neutral).'),
        PracticeQuestion(question: 'What type of bond is formed when atoms share electrons?', answer: 'Covalent bond', explanation: 'Non-metal atoms share electrons to form covalent bonds, as in water (H₂O).'),
      ],
      references: ['Chemistry Form 3', 'O-Level Chemistry Revision'],
    ),
  ],

  // ======================== FORM 5 ========================
  'a5_mat_1': [
    Lesson(
      id: 'lesson_a5_mat_1',
      subjectId: 'a5_mat',
      topicId: 'a5_mat_1',
      title: 'Pure Mathematics: Functions and Calculus',
      gradeLevel: 'Form 5',
      objectives: ['Understand different types of functions', 'Apply differentiation rules', 'Solve optimisation problems'],
      sections: [
        LessonSection(heading: 'Functions', content: 'A function is a relationship where each input has exactly one output. Functions are the foundation of calculus.',
          bulletPoints: ['f(x) = x² + 3x - 5 means: take x, square it, add 3 times x, subtract 5', 'Domain: all possible input values',
            'Range: all possible output values', 'Composite functions: f(g(x)) means apply g first, then f',
            'Inverse functions: f⁻¹(x) undoes what f(x) did'],
          example: 'f(x) = 2x + 3\nf(4) = 2(4) + 3 = 11\nThe inverse: f⁻¹(x) = (x - 3)/2'),
        LessonSection(heading: 'Differentiation', content: 'Differentiation finds the rate of change of a function. The derivative gives the gradient at any point.',
          bulletPoints: ['Power rule: d/dx(xⁿ) = nxⁿ⁻¹', 'd/dx(3x⁴) = 12x³', 'Differentiate term by term',
            'The derivative f\'(x) gives the gradient', 'Stationary points occur where f\'(x) = 0',
            'Second derivative f\'\'(x) tells if it is a maximum or minimum'],
          example: 'f(x) = 3x⁴ + 2x³ - 5x + 7\nf\'(x) = 12x³ + 6x² - 5\nf\'\'(x) = 36x² + 12x'),
        LessonSection(heading: 'Integration', content: 'Integration is the reverse of differentiation. It finds areas under curves.',
          bulletPoints: ['∫xⁿ dx = xⁿ⁺¹/(n+1) + C (for n ≠ -1)', '∫3x² dx = x³ + C', 'Definite integrals give a numerical value',
            'Area under curve = ∫f(x) dx between limits', 'Integration is also called antidiﬀerentiation'],
          example: '∫(2x + 3) dx = x² + 3x + C\n∫₁³(2x + 3) dx = [3² + 3(3)] - [1² + 3(1)] = (9+9) - (1+3) = 18 - 4 = 14'),
      ],
      keyPoints: ['Functions map inputs to outputs', 'Differentiation finds rates of change', 'Integration finds areas and reverses differentiation'],
      practiceQuestions: [
        PracticeQuestion(question: 'Differentiate f(x) = 5x³ - 2x² + 7x - 3', answer: 'f\'(x) = 15x² - 4x + 7', explanation: 'Apply the power rule to each term: 5(3)x² - 2(2)x + 7 = 15x² - 4x + 7'),
        PracticeQuestion(question: 'Integrate ∫(6x² - 4x + 1) dx', answer: '2x³ - 2x² + x + C', explanation: '∫6x² dx = 2x³, ∫-4x dx = -2x², ∫1 dx = x. Add constant C.'),
      ],
      references: ['Advanced Level Mathematics: Pure Mathematics', 'A-Level Mathematics Revision Guide'],
    ),
  ],
  'a5_bio_1': [
    Lesson(
      id: 'lesson_a5_bio_1',
      subjectId: 'a5_bio',
      topicId: 'a5_bio_1',
      title: 'Molecular Biology: DNA and Protein Synthesis',
      gradeLevel: 'Form 5',
      objectives: ['Describe the structure of DNA', 'Explain DNA replication', 'Describe the process of protein synthesis'],
      sections: [
        LessonSection(heading: 'DNA Structure', content: 'DNA (deoxyribonucleic acid) contains the genetic instructions for all living things.',
          bulletPoints: ['DNA is a double helix (twisted ladder shape)', 'Each strand has a sugar-phosphate backbone',
            'Rungs are made of nitrogenous base pairs', 'A pairs with T, C pairs with G (complementary base pairing)',
            'Genes are sections of DNA that code for proteins', 'The order of bases is the genetic code'],
          imageHints: ['dna_double_helix', 'base_pairing'],
          example: 'A DNA sequence: ATTCGATCG\nComplementary strand: TAAGCTAGC\nA always pairs with T, C always pairs with G.'),
        LessonSection(heading: 'Protein Synthesis', content: 'Protein synthesis is how cells make proteins using the instructions in DNA.',
          bulletPoints: ['Transcription: DNA is copied into mRNA in the nucleus', 'mRNA carries the code to ribosomes in the cytoplasm',
            'Translation: ribosomes read mRNA codons', 'tRNA brings the correct amino acids',
            'Amino acids join together to form a protein', 'Each set of 3 bases (codon) codes for one amino acid'],
          example: 'DNA: ATG CCA TTT\nmRNA: UAC GGU AAA\nAmino acids: Tyrosine - Glycine - Lysine\nThese join to form part of a protein.'),
      ],
      keyPoints: ['DNA is a double helix with complementary base pairing', 'DNA replication is semi-conservative', 'Protein synthesis involves transcription and translation'],
      practiceQuestions: [
        PracticeQuestion(question: 'What are the complementary base pairs in DNA?', answer: 'A-T and C-G', explanation: 'Adenine pairs with Thymine, and Cytosine pairs with Guanine.'),
        PracticeQuestion(question: 'Where does transcription occur?', answer: 'In the nucleus', explanation: 'Transcription happens in the nucleus where DNA is copied into mRNA.'),
      ],
      references: ['Advanced Level Biology', 'Molecular Biology of the Cell'],
    ),
  ],

  // ======================== FORM 6 ========================
  'a6_mat_1': [
    Lesson(
      id: 'lesson_a6_mat_1',
      subjectId: 'a6_mat',
      topicId: 'a6_mat_1',
      title: 'Advanced Calculus: Integration and Differential Equations',
      gradeLevel: 'Form 6',
      objectives: ['Apply advanced integration techniques', 'Solve first-order differential equations', 'Use numerical methods'],
      sections: [
        LessonSection(heading: 'Advanced Integration Techniques', content: 'Integration is more complex at A-Level. Several techniques are needed.',
          bulletPoints: ['Integration by substitution: let u = g(x)', 'Integration by parts: ∫u dv = uv - ∫v du',
            'Partial fractions for rational functions', 'Trigonometric integrals and substitutions',
            'Definite integrals with infinite limits (improper integrals)'],
          example: '∫x·eˣ dx using parts:\nLet u = x, dv = eˣ dx\ndu = dx, v = eˣ\n∫x·eˣ dx = x·eˣ - ∫eˣ dx = x·eˣ - eˣ + C = eˣ(x - 1) + C'),
        LessonSection(heading: 'Differential Equations', content: 'Differential equations involve derivatives and describe how things change.',
          bulletPoints: ['First-order: dy/dx = f(x) or dy/dx = f(y)', 'Separate variables: get all y terms with dy, all x with dx',
            'Integrate both sides', 'Use boundary conditions to find the constant', 'Applications: population growth, cooling, radioactive decay'],
          example: 'dy/dx = kx\ndy = kx·dx\n∫dy = ∫kx·dx\ny = ½kx² + C\nIf y = 5 when x = 0, then C = 5, so y = ½kx² + 5'),
      ],
      keyPoints: ['Integration requires multiple techniques depending on the function', 'Differential equations model real-world change', 'Always include the constant of integration for indefinite integrals'],
      practiceQuestions: [
        PracticeQuestion(question: 'Which technique would you use to integrate ∫x·sin(x) dx?', answer: 'Integration by parts', explanation: 'Integration by parts is used for products of functions. ∫x·sin(x) dx = -x·cos(x) + sin(x) + C.'),
      ],
      references: ['Advanced Level Mathematics: Pure Mathematics', 'Calculus: Early Transcendentals'],
    ),
  ],
  'a6_eco_1': [
    Lesson(
      id: 'lesson_a6_eco_1',
      subjectId: 'a6_eco',
      topicId: 'a6_eco_1',
      title: 'Development Economics',
      gradeLevel: 'Form 6',
      objectives: ['Understand economic growth theories', 'Analyse the challenges facing developing economies', 'Evaluate development strategies'],
      sections: [
        LessonSection(heading: 'Economic Growth and Development', content: 'Economic growth is different from economic development. Growth means more output; development means better quality of life.',
          bulletPoints: ['GDP measures total output of goods and services', 'HDI (Human Development Index) measures: life expectancy, education, income',
            'Developing countries face unique challenges', 'Poverty, inequality, and unemployment are key issues',
            'Zimbabwe is classified as a developing economy', 'Sustainable development balances growth with environmental care'],
          example: 'A country can have economic growth (more factories, more goods) but not development if only the rich benefit and the poor stay poor. Development means everyone benefits.'),
        LessonSection(heading: 'Barriers to Development', content: 'Developing economies face many barriers that slow their progress.',
          bulletPoints: ['Lack of capital (both financial and physical)', 'Low levels of education and skills', 'Poor infrastructure (roads, electricity, internet)',
            'Political instability and poor governance', 'Dependence on primary products (raw materials)', 'High population growth and debt burden'],
          example: 'Zimbabwe has abundant natural resources but faces challenges like infrastructure gaps and capital shortages that slow development. Addressing these requires both domestic effort and international cooperation.'),
      ],
      keyPoints: ['Growth and development are related but different concepts', 'Development includes education, health, and quality of life', 'Developing economies face multiple interlocking barriers'],
      practiceQuestions: [
        PracticeQuestion(question: 'What is the difference between economic growth and economic development?', answer: 'Growth is increase in output, development is improvement in quality of life', explanation: 'GDP growth measures output. HDI and other indicators measure development including education, health, and income.'),
        PracticeQuestion(question: 'Name three barriers to development in Zimbabwe.', answer: 'Capital shortages, infrastructure gaps, skills deficits', explanation: 'Developing economies like Zimbabwe face multiple barriers including lack of capital, poor infrastructure, and low education levels.'),
      ],
      references: ['Advanced Level Economics', 'Todaro & Smith: Economic Development'],
    ),
  ],

  // ======================== FORM 4 ========================
  'o4_eng_1': [
    Lesson(
      id: 'lesson_o4_eng_1',
      subjectId: 'o4_eng',
      topicId: 'o4_eng_1',
      title: 'O-Level English Exam Preparation',
      gradeLevel: 'Form 4',
      objectives: ['Master O-Level past paper techniques', 'Improve summary and comprehension skills', 'Write high-scoring essays'],
      sections: [
        LessonSection(heading: 'Understanding the Exam', content: 'O-Level English has multiple papers. Know what each one requires.',
          bulletPoints: ['Paper 1: Composition (essay writing)', 'Paper 2: Comprehension and summary',
            'Know the mark scheme and what examiners look for', 'Content: what you say', 'Organisation: how you structure it',
            'Language: your vocabulary and grammar', 'Accuracy: spelling, punctuation, and grammar'],
          example: 'For a 30-mark essay, examiners divide marks: Content (10), Organisation (8), Language (7), Accuracy (5).'),
        LessonSection(heading: 'Summary Writing', content: 'Summary tests your ability to identify and restate key points concisely.',
          bulletPoints: ['Read the passage carefully twice', 'Identify the key points (usually 5-7 main ideas)',
            'Use your own words (paraphrase)', 'Do not include examples or repetition',
            'Stay within the word limit (usually 150 words)', 'Write in connected prose, not bullet points'],
          example: 'Original: "The sun, which is a massive ball of burning gas, provides heat and light to the Earth, making it possible for plants to grow through photosynthesis."\nSummary: "The sun gives heat and light that enables plant growth through photosynthesis."'),
      ],
      keyPoints: ['Know the exam structure and mark scheme', 'Practice past papers under timed conditions', 'For summary: identify key points and paraphrase'],
      practiceQuestions: [
        PracticeQuestion(question: 'What are the four marking criteria for O-Level English essays?', answer: 'Content, Organisation, Language, Accuracy', explanation: 'Examiners mark based on what you say, how you structure it, your vocabulary, and your technical accuracy.'),
      ],
      references: ['New Express English Form 4', 'ZIMSEC O-Level English Past Papers'],
    ),
  ],

  // ========== CAMBRIDGE PRIMARY - GRADE 1 ENGLISH ==========
  'cam_g1_eng_1': [
    Lesson(
      id: 'lsn_cam_g1_eng_1', subjectId: 'cam_g1_eng', topicId: 'cam_g1_eng_1',
      title: 'Phonics and Reading', gradeLevel: 'Grade 1',
      objectives: ['Recognise letter sounds', 'Blend sounds to read words', 'Read simple sentences'],
      sections: [
        LessonSection(
          heading: 'Letter Sounds',
          content: 'Each letter of the alphabet makes a sound. Learning these sounds helps us read words.',
          bulletPoints: ['A says /a/ as in apple', 'B says /b/ as in ball', 'C says /c/ as in cat'],
          example: 'The letter M says /m/ as in mat, moon, and mouse.',
        ),
        LessonSection(
          heading: 'Blending Sounds',
          content: 'Blending means putting sounds together to read a word. Start slowly, then speed up.',
          bulletPoints: ['c-a-t = cat', 'd-o-g = dog', 's-u-n = sun'],
          example: 'Try blending: m-a-t = mat. Say each sound, then say them faster together.',
        ),
      ],
      keyPoints: ['Every letter has a sound', 'Blend sounds from left to right', 'Practice with simple CVC words'],
      practiceQuestions: [
        PracticeQuestion(question: 'What word do these sounds make: b-u-s?', answer: 'bus', explanation: 'Blend the sounds b, u, s together to make the word bus.'),
        PracticeQuestion(question: 'Which word starts with the /s/ sound? cat, sun, dog', answer: 'sun', explanation: 'Sun starts with the /s/ sound.'),
      ],
      references: ['Cambridge Primary English Learner\'s Book 1'],
    ),
  ],

  // ========== CAMBRIDGE PRIMARY - GRADE 1 MATHEMATICS ==========
  'cam_g1_mat_1': [
    Lesson(
      id: 'lsn_cam_g1_mat_1', subjectId: 'cam_g1_mat', topicId: 'cam_g1_mat_1',
      title: 'Numbers and Counting', gradeLevel: 'Grade 1',
      objectives: ['Count from 1 to 100', 'Recognise numbers', 'Understand place value'],
      sections: [
        LessonSection(
          heading: 'Counting to 100',
          content: 'We count objects one by one to find out how many there are.',
          bulletPoints: ['Count 1, 2, 3, 4, 5...', 'Use fingers to help count', 'Touch each object as you count'],
          example: 'Count the apples: 1, 2, 3, 4, 5. There are 5 apples.',
        ),
        LessonSection(
          heading: 'Place Value',
          content: 'Numbers have tens and ones. For example, 23 has 2 tens and 3 ones.',
          bulletPoints: ['10 ones = 1 ten', '25 = 2 tens and 5 ones', '50 = 5 tens'],
          example: 'The number 47 has 4 tens (40) and 7 ones.',
        ),
      ],
      keyPoints: ['Count objects one by one', 'Numbers have tens and ones', 'Practice counting every day'],
      practiceQuestions: [
        PracticeQuestion(question: 'How many tens are in the number 35?', answer: '3 tens', explanation: '35 = 30 + 5, so there are 3 tens and 5 ones.'),
        PracticeQuestion(question: 'What number comes after 49?', answer: '50', explanation: 'After 49 comes 50. The tens change from 4 to 5.'),
      ],
      references: ['Cambridge Primary Mathematics Learner\'s Book 1'],
    ),
  ],

  // ========== CAMBRIDGE IGCSE - FORM 3 ENGLISH ==========
  'cam_o3_eng_1': [
    Lesson(
      id: 'lsn_cam_o3_eng_1', subjectId: 'cam_o3_eng', topicId: 'cam_o3_eng_1',
      title: 'Reading and Comprehension', gradeLevel: 'Form 3',
      objectives: ['Analyse passages critically', 'Write effective summaries', 'Identify language techniques'],
      sections: [
        LessonSection(
          heading: 'Reading Strategies',
          content: 'Effective reading involves understanding the main idea, supporting details, and the writer\'s purpose.',
          bulletPoints: ['Read the passage twice', 'Identify the main idea', 'Look for supporting evidence', 'Consider the writer\'s tone'],
          example: 'If the passage is about climate change, the main idea might be that human activities are causing global warming.',
        ),
        LessonSection(
          heading: 'Summary Writing',
          content: 'A summary captures the key points of a passage in your own words.',
          bulletPoints: ['Identify 4-5 key points', 'Use your own words', 'Stay within the word limit', 'Do not add your opinion'],
          example: 'Key points might be: causes of climate change, effects on environment, possible solutions.',
        ),
      ],
      keyPoints: ['Read actively and critically', 'Summary = key points in your own words', 'Identify language techniques and their effects'],
      practiceQuestions: [
        PracticeQuestion(question: 'What is the difference between a fact and an opinion?', answer: 'A fact can be proven true. An opinion is a personal belief that may vary between people.', explanation: 'Facts use evidence. Opinions use words like I think, I believe, in my opinion.'),
      ],
      references: ['Cambridge IGCSE English First Language Coursebook'],
    ),
  ],

  // ========== CAMBRIDGE IGCSE - FORM 3 BIOLOGY ==========
  'cam_o3_bio_1': [
    Lesson(
      id: 'lsn_cam_o3_bio_1', subjectId: 'cam_o3_bio', topicId: 'cam_o3_bio_1',
      title: 'Cell Biology', gradeLevel: 'Form 3',
      objectives: ['Describe cell structure', 'Compare plant and animal cells', 'Explain cell functions'],
      sections: [
        LessonSection(
          heading: 'Cell Structure',
          content: 'All living things are made of cells. Cells are the basic units of life.',
          bulletPoints: ['Nucleus - controls cell activities', 'Cytoplasm - where chemical reactions happen', 'Cell membrane - controls what enters and leaves', 'Mitochondria - site of respiration'],
          example: 'A cheek cell has a nucleus, cytoplasm, and cell membrane.',
        ),
        LessonSection(
          heading: 'Plant vs Animal Cells',
          content: 'Plant cells have extra structures that animal cells do not have.',
          bulletPoints: ['Cell wall - rigid structure for support', 'Chloroplasts - for photosynthesis', 'Permanent vacuole - stores cell sap'],
          example: 'A leaf cell has chloroplasts for photosynthesis. An animal cell does not.',
        ),
      ],
      keyPoints: ['All cells have nucleus, cytoplasm, membrane', 'Plant cells also have cell wall, chloroplasts, vacuole', 'Mitochondria release energy from glucose'],
      practiceQuestions: [
        PracticeQuestion(question: 'Name three structures found in plant cells but not animal cells.', answer: 'Cell wall, chloroplasts, permanent vacuole', explanation: 'These structures help plants make food and maintain their shape.'),
      ],
      references: ['Cambridge IGCSE Biology Coursebook'],
    ),
  ],

  // ========== CAMBRIDGE IGCSE - FORM 3 MATHEMATICS ==========
  'cam_o3_mat_1': [
    Lesson(
      id: 'lsn_cam_o3_mat_1', subjectId: 'cam_o3_mat', topicId: 'cam_o3_mat_1',
      title: 'Number and Algebra', gradeLevel: 'Form 3',
      objectives: ['Simplify algebraic expressions', 'Solve linear equations', 'Work with indices'],
      sections: [
        LessonSection(
          heading: 'Algebraic Expressions',
          content: 'Algebra uses letters to represent unknown numbers. We can simplify expressions by combining like terms.',
          bulletPoints: ['Like terms have the same variable and power', '3x + 5x = 8x', '4x² and 7x² are like terms', '3x and 5y are NOT like terms'],
          example: 'Simplify: 2a + 3b - a + 5b = a + 8b',
        ),
        LessonSection(
          heading: 'Solving Equations',
          content: 'To solve an equation, find the value of the unknown that makes it true.',
          bulletPoints: ['Do the same to both sides', 'Get the variable on its own', 'Check your answer by substituting back'],
          example: 'Solve 2x + 3 = 11: 2x = 8, x = 4. Check: 2(4) + 3 = 11 ✓',
        ),
      ],
      keyPoints: ['Combine like terms to simplify', 'Do the same operation to both sides of an equation', 'Always check your answer'],
      practiceQuestions: [
        PracticeQuestion(question: 'Simplify: 5x + 3y - 2x + y', answer: '3x + 4y', explanation: 'Combine x terms: 5x - 2x = 3x. Combine y terms: 3y + y = 4y.'),
        PracticeQuestion(question: 'Solve: 3x - 7 = 14', answer: 'x = 7', explanation: '3x = 14 + 7 = 21. x = 21/3 = 7.'),
      ],
      references: ['Cambridge IGCSE Mathematics Coursebook'],
    ),
  ],

  // ========== CAMBRIDGE A-LEVEL - FORM 5 MATHEMATICS ==========
  'cam_a5_mat_1': [
    Lesson(
      id: 'lsn_cam_a5_mat_1', subjectId: 'cam_a5_mat', topicId: 'cam_a5_mat_1',
      title: 'Pure Mathematics 1', gradeLevel: 'Form 5',
      objectives: ['Differentiate polynomials', 'Apply the power rule', 'Find gradients of curves'],
      sections: [
        LessonSection(
          heading: 'Differentiation',
          content: 'Differentiation finds the rate of change of a function. It gives us the gradient at any point on a curve.',
          bulletPoints: ['Power rule: d/dx(xⁿ) = nxⁿ⁻¹', 'Differentiate term by term', 'Constants disappear when differentiated', 'The result is called the derivative'],
          example: 'If f(x) = x³, then f\'(x) = 3x².',
        ),
        LessonSection(
          heading: 'Applications',
          content: 'Differentiation can find gradients, rates of change, and turning points.',
          bulletPoints: ['Gradient at x = a is f\'(a)', 'Stationary points where f\'(x) = 0', 'Maximum when gradient changes + to -', 'Minimum when gradient changes - to +'],
          example: 'For f(x) = x² - 4x + 3, f\'(x) = 2x - 4. Stationary point at x = 2.',
        ),
      ],
      keyPoints: ['Power rule: bring down the power, reduce by 1', 'Derivative gives gradient at any point', 'Stationary points where derivative = 0'],
      practiceQuestions: [
        PracticeQuestion(question: 'Differentiate f(x) = 4x³ - 2x + 5', answer: 'f\'(x) = 12x² - 2', explanation: 'Apply power rule: 4x³ → 12x², -2x → -2, constant 5 → 0.'),
        PracticeQuestion(question: 'Find the gradient of y = x² + 3x at x = 2', answer: '7', explanation: 'dy/dx = 2x + 3. At x = 2: 2(2) + 3 = 7.'),
      ],
      references: ['Cambridge International AS & A Level Mathematics Coursebook'],
    ),
  ],
  ],

  // ======================== FORM 3 FRS ========================
  'o3_frs_1': [
    Lesson(
      id: 'lsn_o3_frs_1_1', subjectId: 'o3_frs', topicId: 'o3_frs_1',
      title: 'Indigenous Religion: Concept of God', gradeLevel: 'Form 3',
      objectives: ['Understand the African concept of a Supreme Being', 'Identify local names for God', 'Explain the role of ancestors as intermediaries'],
      sections: [
        LessonSection(
          heading: 'The Supreme Being',
          content: 'In Zimbabwean Indigenous Religion, God is viewed as the Supreme Being, the Creator (Musiki/uMdali), and the source of all life. God is considered transcendent (far away and holy) but also immanent (involved in everyday life through intermediaries).',
          bulletPoints: ['Shona names for God: Mwari (The Supreme), Nyadenga (Lord of the Sky), Musikavanhu (Creator of humanity).', 'Ndebele names for God: uNkulunkulu (The Greatest), uMdali (Creator).', 'God is rarely approached directly; intermediaries are used.'],
          example: 'When rain is needed, communities do not pray to God directly. They approach the ancestors (midzimu/amadlozi), who then take the plea to God.',
        ),
        LessonSection(
          heading: 'Role of Ancestors',
          content: 'Ancestors (midzimu in Shona, amadlozi in Ndebele) play a vital role as mediators between the living and the Supreme Being. They are respected and honored, not worshipped.',
          bulletPoints: ['They protect the family from evil.', 'They act as messengers to God.', 'They are consulted during times of crisis or illness.', 'Offerings (like beer or snuff) are given to appease or thank them.'],
        ),
      ],
      keyPoints: ['God is the Creator and Sustainer of life.', 'Ancestors act as intermediaries between humans and God.', 'Different names for God reflect His various attributes.'],
      practiceQuestions: [
        PracticeQuestion(question: 'Give two names for God in the Shona religion and explain their meanings.', answer: 'Musikavanhu (Creator of humanity) and Nyadenga (Lord of the Sky).', explanation: 'These names highlight God\'s role as creator and his transcendent nature.'),
        PracticeQuestion(question: 'Explain the role of ancestors in Indigenous Religion.', answer: 'They act as intermediaries or mediators between the living and the Supreme Being.', explanation: 'Ancestors bridge the gap between the physical and spiritual worlds.'),
      ],
      references: ['O-Level FRS Textbook'],
    ),
  ],
  'o3_frs_2': [
    Lesson(
      id: 'lsn_o3_frs_2_1', subjectId: 'o3_frs', topicId: 'o3_frs_2',
      title: 'Christianity: Origins and Core Beliefs', gradeLevel: 'Form 3',
      objectives: ['Trace the origins of Christianity', 'Identify the core beliefs of the Christian faith', 'Understand the significance of the Bible'],
      sections: [
        LessonSection(
          heading: 'Origins of Christianity',
          content: 'Christianity originated in the 1st century AD in Judea. It is based on the life, teachings, death, and resurrection of Jesus Christ, whom Christians believe to be the Son of God and the Messiah (Savior).',
          bulletPoints: ['Started as a sect within Judaism.', 'Spread through the Roman Empire by apostles like Paul.', 'Emphasizes love, forgiveness, and salvation.'],
        ),
        LessonSection(
          heading: 'Core Beliefs',
          content: 'The central tenet of Christianity is the belief in the Trinity (God the Father, God the Son, and God the Holy Spirit).',
          bulletPoints: ['Incarnation: Jesus is God in human form.', 'Atonement: Jesus\' death on the cross pays the penalty for human sin.', 'Resurrection: Jesus rose from the dead, offering eternal life.'],
        ),
      ],
      keyPoints: ['Founded on the life and teachings of Jesus Christ.', 'The Bible is the sacred text.', 'Core beliefs include the Trinity, Incarnation, and Resurrection.'],
      practiceQuestions: [
        PracticeQuestion(question: 'What is the doctrine of the Trinity?', answer: 'The belief that God is one in essence but exists in three persons: Father, Son, and Holy Spirit.', explanation: 'This is a foundational concept in mainstream Christianity.'),
      ],
      references: ['O-Level FRS Textbook'],
    ),
  ],

  // ======================== FORM 4 FRS ========================
  'o4_frs_1': [
    Lesson(
      id: 'lsn_o4_frs_1_1', subjectId: 'o4_frs', topicId: 'o4_frs_1',
      title: 'Ethics and Morality in Society', gradeLevel: 'Form 4',
      objectives: ['Define ethics and morality', 'Differentiate between secular and religious ethics', 'Apply ethical principles to contemporary issues'],
      sections: [
        LessonSection(
          heading: 'Understanding Ethics',
          content: 'Ethics is the branch of philosophy that deals with moral principles—what is right and wrong. Morality refers to the actual beliefs and practices regarding good and bad behavior.',
          bulletPoints: ['Religious ethics: Based on divine commands and sacred texts (e.g., Ten Commandments).', 'Secular ethics: Based on human reason, logic, and societal well-being (e.g., Utilitarianism).', 'Ubuntu/Unhu: The African philosophy of humaneness and community solidarity.'],
          example: 'Ubuntu/Unhu states "I am because we are." It emphasizes respect, compassion, and living in harmony with others.',
        ),
        LessonSection(
          heading: 'Contemporary Moral Issues',
          content: 'Modern society faces complex ethical dilemmas where right and wrong are heavily debated.',
          bulletPoints: ['Bioethics: Abortion, euthanasia, cloning.', 'Environmental ethics: Deforestation, pollution, climate change.', 'Social ethics: Corruption, human rights violations, poverty.'],
        ),
      ],
      keyPoints: ['Ethics guides human behavior.', 'Ubuntu/Unhu is central to Zimbabwean moral philosophy.', 'Ethical dilemmas require careful consideration of different perspectives.'],
      practiceQuestions: [
        PracticeQuestion(question: 'Briefly explain the concept of Ubuntu/Unhu.', answer: 'It is an African philosophy emphasizing community, respect, compassion, and the interconnectedness of humanity ("I am because we are").', explanation: 'Ubuntu is the moral foundation of many African societies.'),
        PracticeQuestion(question: 'Distinguish between religious and secular ethics.', answer: 'Religious ethics rely on divine revelation, while secular ethics rely on human reason and societal impact.', explanation: 'The source of moral authority differs between the two.'),
      ],
      references: ['O-Level FRS Textbook'],
    ),
  ],

  // ======================== ADVANCED LEVEL FRS ========================
  'a5_frs_1': [
    Lesson(
      id: 'lsn_a5_frs_1_1', subjectId: 'a5_frs', topicId: 'a5_frs_1',
      title: 'Advanced Study of African Traditional Religion (ATR)', gradeLevel: 'Form 5',
      objectives: ['Analyze the cosmology of ATR', 'Evaluate the impact of modernity on ATR practices', 'Examine the significance of rites of passage'],
      sections: [
        LessonSection(
          heading: 'Cosmology and Worldview',
          content: 'ATR presents a holistic universe where the physical and spiritual realms are deeply intertwined. There is no sharp distinction between the sacred and the secular.',
          bulletPoints: ['Hierarchical structure: Supreme Being, divinities, ancestors, living humans, and lower creation.', 'Vital force: A spiritual energy that permeates all living things.', 'Health and prosperity are seen as signs of spiritual harmony.'],
        ),
        LessonSection(
          heading: 'Rites of Passage',
          content: 'Rites of passage mark critical transitions in a person\'s life, integrating them into the community and conferring new spiritual status.',
          bulletPoints: ['Birth and naming ceremonies.', 'Initiation (transition from childhood to adulthood).', 'Marriage (uniting two families, not just individuals).', 'Death and Kurova Guva/Umbuyiso (bringing the spirit back to protect the family).'],
        ),
      ],
      keyPoints: ['ATR worldview is holistic and community-centered.', 'Rites of passage ensure the continuity of society and spiritual harmony.', 'Modernization poses challenges to traditional practices.'],
      practiceQuestions: [
        PracticeQuestion(question: 'Analyze the significance of the Kurova Guva ceremony.', answer: 'It elevates the deceased to the status of an ancestor, allowing them to protect and guide the living family members.', explanation: 'It is a crucial ritual for ensuring the spiritual security of the family.'),
      ],
      references: ['A-Level Divinity/FRS Textbook'],
    ),
  ],
  'a6_frs_1': [
    Lesson(
      id: 'lsn_a6_frs_1_1', subjectId: 'a6_frs', topicId: 'a6_frs_1',
      title: 'Comparative Religion: Thematic Approaches', gradeLevel: 'Form 6',
      objectives: ['Compare concepts of salvation across religions', 'Analyze interfaith dialogue initiatives', 'Evaluate the role of religion in peacebuilding'],
      sections: [
        LessonSection(
          heading: 'Concepts of Salvation',
          content: 'Different religions offer varying paths to ultimate liberation or salvation.',
          bulletPoints: ['Christianity: Salvation through grace and faith in Jesus Christ.', 'Islam: Salvation through submission to Allah and adherence to the Five Pillars.', 'ATR: Salvation understood as well-being, harmony with ancestors, and community prosperity.', 'Buddhism: Nirvana—liberation from the cycle of rebirth (Samsara) through enlightenment.'],
        ),
        LessonSection(
          heading: 'Interfaith Dialogue and Peacebuilding',
          content: 'In a pluralistic world, dialogue between religions is essential for social cohesion.',
          bulletPoints: ['Aims to build mutual understanding, not conversion.', 'Addresses shared social issues (poverty, injustice).', 'Religions can be sources of conflict but also powerful tools for reconciliation and peace.'],
        ),
      ],
      keyPoints: ['Salvation concepts vary significantly across faiths.', 'Interfaith dialogue promotes peace and understanding.', 'Religions must actively address global challenges.'],
      practiceQuestions: [
        PracticeQuestion(question: 'Compare the Christian and ATR concepts of salvation.', answer: 'Christianity views salvation as eternal life and deliverance from sin through Christ. ATR views salvation as present well-being, health, and harmony with the spiritual realm.', explanation: 'Christianity is often eschatological (future-focused), while ATR is pragmatic (present-focused).'),
      ],
      references: ['A-Level Comparative Religion Texts'],
    ),
  ],
};

List<Lesson> getLessonsForTopic(String topicId) {
  return lessonsByTopic[topicId] ?? [];
}

List<Lesson> getLessonsForSubjectAndGrade(String subjectId, String gradeLevel) {
  return lessonsByTopic.values
      .expand((list) => list)
      .where((l) => l.subjectId == subjectId && l.gradeLevel == gradeLevel)
      .toList();
}

List<Lesson> getLessonsForGrade(String gradeLevel) {
  return lessonsByTopic.values
      .expand((list) => list)
      .where((l) => l.gradeLevel == gradeLevel)
      .toList();
}
