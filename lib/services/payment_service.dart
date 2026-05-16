import 'app_config.dart';
import 'mock_data_service.dart';
import '../models/user.dart';
import '../models/payment_plan.dart';

class PaymentService {
  static Future<List<PaymentPlan>> getAvailablePlans() async {
    if (!AppConfig.useFirebase) {
      await Future.delayed(const Duration(milliseconds: 200));
      return PaymentPlan.defaultPlans;
    }
    return PaymentPlan.defaultPlans;
  }

  static Future<PaymentPlan?> getPlanById(String planId) async {
    final plans = await getAvailablePlans();
    try {
      return plans.firstWhere((p) => p.id == planId);
    } catch (_) {
      return null;
    }
  }

  static Future<User> subscribeToPlan(User user, String planId) async {
    final plan = await getPlanById(planId);
    if (plan == null) throw Exception('Plan not found');

    final now = DateTime.now();
    final endDate = plan.duration == 'yearly'
        ? DateTime(now.year + 1, now.month, now.day)
        : DateTime(now.year, now.month + 1, now.day);

    if (plan.price > 0) {
      await _processPayment(plan);
    }

    return user.copyWith(
      paymentPlanId: planId,
      paymentStatus: 'active',
      subscriptionStartDate: now,
      subscriptionEndDate: endDate,
    );
  }

  static Future<void> _processPayment(PaymentPlan plan) async {
    await Future.delayed(const Duration(seconds: 1));
  }

  static Future<User> cancelSubscription(User user) async {
    return user.copyWith(
      paymentPlanId: 'free',
      paymentStatus: 'cancelled',
      subscriptionEndDate: DateTime.now(),
    );
  }

  static Future<User> updatePaymentStatus(User user, String status) async {
    return user.copyWith(paymentStatus: status);
  }

  static Future<List<Map<String, dynamic>>> getPaymentHistory(User user) async {
    if (!AppConfig.useFirebase) {
      return MockDataService.getPaymentHistory(user.id);
    }
    return [];
  }

  static Future<void> savePaymentMethod({
    required String userId,
    required String cardLastFour,
    required String cardBrand,
  }) async {
    if (!AppConfig.useFirebase) {
      await MockDataService.savePaymentMethod(
        userId: userId,
        cardLastFour: cardLastFour,
        cardBrand: cardBrand,
      );
      return;
    }
  }

  static String? getPlanDurationRemaining(User user) {
    if (user.subscriptionEndDate == null) return null;
    final remaining = user.subscriptionEndDate!.difference(DateTime.now());
    if (remaining.isNegative) return 'Expired';
    if (remaining.inDays > 30) return '${(remaining.inDays / 30).ceil()} months';
    if (remaining.inDays > 0) return '${remaining.inDays} days';
    return '${remaining.inHours} hours';
  }
}
