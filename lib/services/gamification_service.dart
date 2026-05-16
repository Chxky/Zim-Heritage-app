// services/gamification_service.dart
import 'package:shared_preferences/shared_preferences.dart';

/// Gamification service — streaks, XP points, badges, leaderboard.
/// Persists locally via SharedPreferences and syncs shape to Firestore.
class GamificationService {
  static const _keyXP = 'xp_points';
  static const _keyStreak = 'streak_days';
  static const _keyLastLogin = 'last_login_date';
  static const _keyBadges = 'earned_badges';
  static const _keyTotalHomework = 'total_homework_done';
  static const _keyTotalCorrect = 'total_correct_answers';

  // ─── XP & Streaks ──────────────────────────────────────────────────────────

  static Future<int> getXP() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyXP) ?? 0;
  }

  static Future<void> addXP(int points) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt(_keyXP) ?? 0;
    await prefs.setInt(_keyXP, current + points);
  }

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyStreak) ?? 0;
  }

  static Future<int> checkAndUpdateStreak() async {
    final prefs = await SharedPreferences.getInstance();
    final lastLoginStr = prefs.getString(_keyLastLogin);
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';

    if (lastLoginStr == todayStr) {
      return prefs.getInt(_keyStreak) ?? 1;
    }

    int streak = prefs.getInt(_keyStreak) ?? 0;
    if (lastLoginStr != null) {
      final lastLogin = DateTime.parse(lastLoginStr);
      final diff = today.difference(lastLogin).inDays;
      if (diff == 1) {
        streak += 1; // Consecutive day
      } else if (diff > 1) {
        streak = 1; // Streak broken
      }
    } else {
      streak = 1;
    }

    await prefs.setInt(_keyStreak, streak);
    await prefs.setString(_keyLastLogin, todayStr);

    // Bonus XP for streaks
    if (streak == 3) await addXP(50);
    if (streak == 7) await addXP(150);
    if (streak == 30) await addXP(500);

    return streak;
  }

  // ─── Homework & Accuracy ───────────────────────────────────────────────────

  static Future<void> recordHomeworkSubmitted({required int correctAnswers, required int totalAnswers}) async {
    final prefs = await SharedPreferences.getInstance();
    final total = (prefs.getInt(_keyTotalHomework) ?? 0) + 1;
    final correct = (prefs.getInt(_keyTotalCorrect) ?? 0) + correctAnswers;
    await prefs.setInt(_keyTotalHomework, total);
    await prefs.setInt(_keyTotalCorrect, correct);

    // XP for submitting
    final ratio = totalAnswers > 0 ? correctAnswers / totalAnswers : 0.0;
    int xp = 20; // Base XP for submission
    if (ratio >= 0.9) {
      xp = 80;
    } else if (ratio >= 0.7) {
      xp = 50;
    } else if (ratio >= 0.5) {
      xp = 35;
    }
    await addXP(xp);

    // Check for new badges
    await _checkBadges(total, correct, totalAnswers);
  }

  static Future<int> getTotalHomework() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTotalHomework) ?? 0;
  }

  // ─── Badges ────────────────────────────────────────────────────────────────

  static const List<Badge> allBadges = [
    Badge(id: 'first_submit', name: 'First Step', emoji: '🌱', desc: 'Submitted your first homework', xpRequired: 0, homeworkRequired: 1),
    Badge(id: 'streak_3', name: 'Hat Trick', emoji: '🔥', desc: '3-day learning streak', xpRequired: 0, homeworkRequired: 0, streakRequired: 3),
    Badge(id: 'streak_7', name: 'Week Warrior', emoji: '⚡', desc: '7-day learning streak', xpRequired: 0, homeworkRequired: 0, streakRequired: 7),
    Badge(id: 'hw_5', name: 'Dedicated Learner', emoji: '📚', desc: 'Completed 5 homework tasks', xpRequired: 0, homeworkRequired: 5),
    Badge(id: 'hw_10', name: 'Scholar', emoji: '🎓', desc: 'Completed 10 homework tasks', xpRequired: 0, homeworkRequired: 10),
    Badge(id: 'xp_100', name: 'Rising Star', emoji: '⭐', desc: 'Earned 100 XP', xpRequired: 100, homeworkRequired: 0),
    Badge(id: 'xp_500', name: 'Knowledge Seeker', emoji: '🏆', desc: 'Earned 500 XP', xpRequired: 500, homeworkRequired: 0),
    Badge(id: 'xp_1000', name: 'Heritage Champion', emoji: '🦅', desc: 'Earned 1000 XP — Zimbabwe Bird level!', xpRequired: 1000, homeworkRequired: 0),
  ];

  static Future<List<String>> getEarnedBadgeIds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_keyBadges) ?? [];
  }

  static Future<List<Badge>> getEarnedBadges() async {
    final earned = await getEarnedBadgeIds();
    return allBadges.where((b) => earned.contains(b.id)).toList();
  }

  static Future<List<String>> _checkBadges(int totalHW, int totalCorrect, int totalAnswers) async {
    final prefs = await SharedPreferences.getInstance();
    final earned = List<String>.from(prefs.getStringList(_keyBadges) ?? []);
    final xp = prefs.getInt(_keyXP) ?? 0;
    final streak = prefs.getInt(_keyStreak) ?? 0;
    final newBadges = <String>[];

    for (final badge in allBadges) {
      if (earned.contains(badge.id)) continue;
      bool earned_ = false;
      if (badge.homeworkRequired > 0 && totalHW >= badge.homeworkRequired) earned_ = true;
      if (badge.xpRequired > 0 && xp >= badge.xpRequired) earned_ = true;
      if (badge.streakRequired > 0 && streak >= badge.streakRequired) earned_ = true;
      if (earned_) {
        earned.add(badge.id);
        newBadges.add(badge.id);
      }
    }

    if (newBadges.isNotEmpty) {
      await prefs.setStringList(_keyBadges, earned);
    }
    return newBadges;
  }

  static String getLevelName(int xp) {
    if (xp < 100) return 'Seedling';
    if (xp < 300) return 'Learner';
    if (xp < 600) return 'Explorer';
    if (xp < 1000) return 'Scholar';
    if (xp < 2000) return 'Achiever';
    return 'Heritage Champion';
  }

  static int getLevel(int xp) {
    if (xp < 100) return 1;
    if (xp < 300) return 2;
    if (xp < 600) return 3;
    if (xp < 1000) return 4;
    if (xp < 2000) return 5;
    return 6;
  }

  static double getLevelProgress(int xp) {
    final thresholds = [0, 100, 300, 600, 1000, 2000];
    final level = getLevel(xp);
    if (level >= 6) return 1.0;
    final min = thresholds[level - 1];
    final max = thresholds[level];
    return ((xp - min) / (max - min)).clamp(0.0, 1.0);
  }

  // ─── Reset (for testing) ───────────────────────────────────────────────────
  static Future<void> resetAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyXP);
    await prefs.remove(_keyStreak);
    await prefs.remove(_keyLastLogin);
    await prefs.remove(_keyBadges);
    await prefs.remove(_keyTotalHomework);
    await prefs.remove(_keyTotalCorrect);
  }
}

class Badge {
  final String id;
  final String name;
  final String emoji;
  final String desc;
  final int xpRequired;
  final int homeworkRequired;
  final int streakRequired;

  const Badge({
    required this.id,
    required this.name,
    required this.emoji,
    required this.desc,
    required this.xpRequired,
    required this.homeworkRequired,
    this.streakRequired = 0,
  });
}
