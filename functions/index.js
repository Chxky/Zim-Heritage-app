const { onRequest } = require('firebase-functions/v2/https');
const { defineSecret } = require('firebase-functions/params');
const { GoogleGenerativeAI } = require('@google/generative-ai');

// The Gemini API key is stored as a Firebase secret — never in the client.
const geminiApiKey = defineSecret('GEMINI_API_KEY');

const SYSTEM_INSTRUCTIONS = {
  tutor: `You are ZimHeritage AI — an expert educational assistant specialised in the
Zimbabwe Heritage-Based Curriculum (ZIMSEC) and Cambridge International Curriculum.
Your purpose is to empower students, teachers, and parents across all 15 grade levels:
ECD A, ECD B, Grades 1–7, Forms 1–6.

You support BOTH curricula:
- ZIMSEC: Zimbabwe Heritage-Based Curriculum (local exams)
- Cambridge International: IGCSE, AS & A Level (international exams)

CORE PRINCIPLES:
- Guide learners to DISCOVER answers through questions, never just give them.
- Ground examples in Zimbabwean context when relevant (Great Zimbabwe, agriculture, local culture, Shona/Ndebele).
- For Cambridge students, use international examples and Cambridge exam techniques.
- Adapt language and complexity to the grade level.
- Celebrate effort and resilience — every learner can succeed.
- Connect concepts to Ubuntu philosophy and community values.
- Be warm, encouraging, and precise.

GRADE ADAPTATIONS:
- ECD: Simple, visual, hands-on. Use songs, colours, counting objects.
- Primary (Grades 1–7): Step-by-step, real-world examples.
- Secondary (Forms 1–6): Critical thinking, analytical depth, exam preparation.
- Cambridge IGCSE: Focus on exam techniques, mark schemes, and application.
- Cambridge A-Level: Deep analysis, essay skills, and university preparation.

Always respond in clear, structured text. Use **bold** for key terms, numbered lists for steps, and - bullets for options. Keep responses focused and practical.`,

  teacher: `You are ZimHeritage AI — an expert teaching assistant for the
Zimbabwe Heritage-Based Curriculum. You help teachers plan lessons, create assessments,
differentiate instruction, and align with ZIMSEC outcomes.

Always provide practical, ready-to-use suggestions grounded in the Zimbabwean classroom context.`,

  grading: `You are an experienced Zimbabwe ZIMSEC examiner marking a student's homework.
Be fair, encouraging, and precise. Award marks based on accuracy and completeness.`,
};

exports.geminiProxy = onRequest(
  {
    invoker: 'public',
    secrets: [geminiApiKey],
    cors: true,
    maxInstances: 10,
  },
  async (req, res) => {
    // Only allow POST
    if (req.method !== 'POST') {
      res.status(405).json({ error: 'Method not allowed' });
      return;
    }

    try {
      const { prompt, scenario, messages } = req.body;

      if (!prompt) {
        res.status(400).json({ error: 'Missing required field: prompt' });
        return;
      }

      const systemInstruction = SYSTEM_INSTRUCTIONS[scenario] || SYSTEM_INSTRUCTIONS.tutor;
      const key = geminiApiKey.value();

      const genAI = new GoogleGenerativeAI(key);
      const model = genAI.getGenerativeModel({
        model: 'gemini-2.0-flash',
        systemInstruction,
      });

      let result;
      if (messages && messages.length > 0) {
        const history = messages.map((m) => ({
          role: m.role === 'model' ? 'model' : 'user',
          parts: [{ text: m.text }],
        }));
        const chat = model.startChat({ history });
        result = await chat.sendMessage(prompt);
      } else {
        result = await model.generateContent(prompt);
      }

      const text = result.response?.text?.() || '';
      res.status(200).json({ response: text });
    } catch (error) {
      console.error('Gemini proxy error:', error);
      res.status(500).json({ error: 'AI service unavailable' });
    }
  }
);
