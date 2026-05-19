import 'package:shared_preferences/shared_preferences.dart';

class ChallengeService {
  static const String _activeChallengesKey = 'active_challenges';
  static const String _completedChallengesKey = 'completed_challenges';

  static final List<Challenge> _availableChallenges = [
    Challenge(
      id: 'hw_5_week',
      title: 'Homework Hero',
      description: 'Complete 5 homework assignments this week',
      xpReward: 100,
      icon: '📝',
      type: 'weekly',
      target: 5,
      category: 'homework',
    ),
    Challenge(
      id: 'quiz_80_3',
      title: 'Quiz Master',
      description: 'Achieve 80%+ on 3 consecutive quizzes',
      xpReward: 150,
      icon: '🎯',
      type: 'weekly',
      target: 3,
      category: 'quiz',
    ),
    Challenge(
      id: 'streak_7',
      title: 'Week Warrior',
      description: 'Study every day for 7 days straight',
      xpReward: 200,
      icon: '🔥',
      type: 'weekly',
      target: 7,
      category: 'streak',
    ),
    Challenge(
      id: 'subjects_3',
      title: 'Well Rounded',
      description: 'Study 3 different subjects this week',
      xpReward: 120,
      icon: '📚',
      type: 'weekly',
      target: 3,
      category: 'variety',
    ),
    Challenge(
      id: 'ai_chat_5',
      title: 'AI Curious',
      description: 'Ask 5 questions to the AI tutor',
      xpReward: 80,
      icon: '🤖',
      type: 'weekly',
      target: 5,
      category: 'ai',
    ),
    Challenge(
      id: 'heritage_explorer',
      title: 'Heritage Explorer',
      description: 'Explore 3 heritage sites in the app',
      xpReward: 100,
      icon: '🏛️',
      type: 'monthly',
      target: 3,
      category: 'heritage',
    ),
    Challenge(
      id: 'perfect_score',
      title: 'Perfectionist',
      description: 'Get 100% on any homework assignment',
      xpReward: 250,
      icon: '⭐',
      type: 'monthly',
      target: 1,
      category: 'achievement',
    ),
    Challenge(
      id: 'early_bird',
      title: 'Early Bird',
      description: 'Submit 3 homework assignments before the due date',
      xpReward: 130,
      icon: '🐦',
      type: 'monthly',
      target: 3,
      category: 'punctuality',
    ),
  ];

  static Future<List<Challenge>> getAvailableChallenges() async {
    return _availableChallenges;
  }

  static Future<List<Challenge>> getActiveChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    final activeIds = prefs.getStringList(_activeChallengesKey) ?? [];
    return _availableChallenges.where((c) => activeIds.contains(c.id)).toList();
  }

  static Future<void> acceptChallenge(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    final active = prefs.getStringList(_activeChallengesKey) ?? [];
    if (!active.contains(challengeId)) {
      active.add(challengeId);
      await prefs.setStringList(_activeChallengesKey, active);
    }
  }

  static Future<void> abandonChallenge(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    final active = prefs.getStringList(_activeChallengesKey) ?? [];
    active.remove(challengeId);
    await prefs.setStringList(_activeChallengesKey, active);
  }

  static Future<void> updateProgress(String challengeId, int progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('challenge_progress_$challengeId', progress);

    // Check if completed
    final challenge = _availableChallenges.where((c) => c.id == challengeId).firstOrNull;
    if (challenge != null && progress >= challenge.target) {
      await completeChallenge(challengeId);
    }
  }

  static Future<int> getProgress(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('challenge_progress_$challengeId') ?? 0;
  }

  static Future<void> completeChallenge(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList(_completedChallengesKey) ?? [];
    if (!completed.contains(challengeId)) {
      completed.add(challengeId);
      await prefs.setStringList(_completedChallengesKey, completed);
    }
    // Remove from active
    final active = prefs.getStringList(_activeChallengesKey) ?? [];
    active.remove(challengeId);
    await prefs.setStringList(_activeChallengesKey, active);
  }

  static Future<bool> isCompleted(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList(_completedChallengesKey) ?? [];
    return completed.contains(challengeId);
  }

  static Future<int> getTotalXpFromChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    final completed = prefs.getStringList(_completedChallengesKey) ?? [];
    int total = 0;
    for (final id in completed) {
      final challenge = _availableChallenges.where((c) => c.id == id).firstOrNull;
      if (challenge != null) total += challenge.xpReward;
    }
    return total;
  }
}

class Challenge {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final String icon;
  final String type; // 'weekly' or 'monthly'
  final int target;
  final String category;

  const Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.icon,
    required this.type,
    required this.target,
    required this.category,
  });
}
