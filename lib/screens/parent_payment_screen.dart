import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user.dart' as models;
import '../models/payment_plan.dart';
import '../services/payment_service.dart';
import '../services/user_repository.dart';
import '../widgets/glass_card.dart';

class ParentPaymentScreen extends StatefulWidget {
  final models.User user;
  const ParentPaymentScreen({super.key, required this.user});

  @override
  State<ParentPaymentScreen> createState() => _ParentPaymentScreenState();
}

class _ParentPaymentScreenState extends State<ParentPaymentScreen> {
  late models.User _user;
  List<PaymentPlan> _plans = [];
  bool _loading = true;
  bool _processingPlan = false;
  String? _selectedPlanId;
  bool _showHistory = false;
  List<Map<String, dynamic>> _history = [];

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    try {
      final plans = await PaymentService.getAvailablePlans();
      final history = await PaymentService.getPaymentHistory(_user);
      if (mounted) {
        setState(() {
          _plans = plans;
          _history = history;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _selectPlan(PaymentPlan plan) async {
    if (_processingPlan) return;
    if (plan.id == _user.paymentPlanId) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This plan is already active'), backgroundColor: AppTheme.greenBright),
      );
      return;
    }

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(plan.price == 0 ? 'Switch to ${plan.name}' : 'Subscribe to ${plan.name}'),
        content: Text(
          plan.price == 0
              ? 'Switch to the ${plan.name} plan?'
              : 'Subscribe to ${plan.name} for ${plan.priceFormatted}${plan.periodText}?',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() {
      _processingPlan = true;
      _selectedPlanId = plan.id;
    });

    try {
      final updatedUser = await PaymentService.subscribeToPlan(_user, plan.id);
      await UserRepository.updateUser(_user.id, updatedUser.toMap());
      if (!mounted) return;
      setState(() {
        _user = updatedUser;
        _processingPlan = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(plan.price == 0
              ? 'Switched to ${plan.name} plan'
              : 'Subscribed to ${plan.name} plan!'),
          backgroundColor: AppTheme.greenBright,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _processingPlan = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppTheme.red),
      );
    }
  }

  Future<void> _cancelSubscription() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cancel Subscription'),
        content: const Text('Are you sure you want to cancel your subscription? You will be switched to the Free plan.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Keep Plan')),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.redBright),
            child: const Text('Cancel Subscription'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    setState(() => _processingPlan = true);
    try {
      final updatedUser = await PaymentService.cancelSubscription(_user);
      await UserRepository.updateUser(_user.id, updatedUser.toMap());
      if (!mounted) return;
      setState(() {
        _user = updatedUser;
        _processingPlan = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subscription cancelled'), backgroundColor: AppTheme.gold),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _processingPlan = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppTheme.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCurrentPlan(),
                  const SizedBox(height: 24),
                  const Text('Choose a Plan',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                  const SizedBox(height: 4),
                  Text('Unlock more features for your family',
                    style: TextStyle(fontSize: 13, color: AppTheme.white60)),
                  const SizedBox(height: 16),
                  ..._plans.map((plan) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildPlanCard(plan),
                  )),
                  const SizedBox(height: 16),
                  _buildPaymentHistory(),
                ],
              ),
            ),
    );
  }

  Widget _buildCurrentPlan() {
    final plan = _plans.where((p) => p.id == _user.paymentPlanId).firstOrNull;
    final remaining = PaymentService.getPlanDurationRemaining(_user);

    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: AppTheme.gold.withValues(alpha: 0.3),
      boxShadow: AppTheme.goldGlow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.gold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.card_membership, color: AppTheme.gold, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Plan',
                      style: TextStyle(color: AppTheme.white60, fontSize: 12)),
                    Text(plan?.name ?? 'Free',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _user.isPaymentActive
                      ? AppTheme.greenBright.withValues(alpha: 0.15)
                      : AppTheme.white15,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _user.isPaymentActive ? AppTheme.greenBright : AppTheme.white30,
                  ),
                ),
                child: Text(
                  _user.isPaymentActive ? 'Active' : (_user.paymentStatus ?? 'Inactive'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _user.isPaymentActive ? AppTheme.greenBright : AppTheme.white60,
                  ),
                ),
              ),
            ],
          ),
          if (remaining != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.white10,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.timer_outlined, size: 16, color: AppTheme.white60),
                  const SizedBox(width: 6),
                  Text('$remaining remaining',
                    style: TextStyle(color: AppTheme.white60, fontSize: 12)),
                ],
              ),
            ),
          ],
          if (_user.hasActiveSubscription) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _cancelSubscription,
                icon: const Icon(Icons.cancel_outlined, size: 18),
                label: const Text('Cancel Subscription'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppTheme.redBright,
                  side: const BorderSide(color: AppTheme.redBright),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlanCard(PaymentPlan plan) {
    final isCurrentPlan = plan.id == _user.paymentPlanId;
    final isLoading = _processingPlan && _selectedPlanId == plan.id;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: plan.isPopular
          ? AppTheme.gold.withValues(alpha: 0.5)
          : isCurrentPlan
              ? AppTheme.greenBright.withValues(alpha: 0.4)
              : null,
      boxShadow: plan.isPopular ? AppTheme.goldGlow : null,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(plan.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                        if (plan.isPopular) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.gold.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text('Popular',
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppTheme.gold)),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(plan.priceFormatted,
                        style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold,
                          color: plan.price == 0 ? AppTheme.white60 : AppTheme.gold,
                        )),
                      if (plan.price > 0)
                        Text(plan.periodText,
                          style: TextStyle(fontSize: 11, color: AppTheme.white50)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(plan.description,
                style: TextStyle(fontSize: 12, color: AppTheme.white60)),
              const SizedBox(height: 12),
              ...plan.features.map((f) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check_circle, size: 16,
                      color: plan.price == 0 ? AppTheme.white50 : AppTheme.greenBright),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(f,
                        style: TextStyle(fontSize: 12, color: AppTheme.white80)),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                    : isCurrentPlan
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: AppTheme.greenBright.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
                            ),
                            child: const Center(
                              child: Text('Current Plan',
                                style: TextStyle(color: AppTheme.greenBright, fontWeight: FontWeight.w600)),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () => _selectPlan(plan),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: plan.isPopular ? AppTheme.gold : AppTheme.primaryGreen,
                              foregroundColor: plan.isPopular ? Colors.brown : AppTheme.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: Text(
                              plan.price == 0 ? 'Switch to Free' : 'Subscribe',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentHistory() {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => setState(() => _showHistory = !_showHistory),
            child: Row(
              children: [
                const Icon(Icons.receipt_long, color: AppTheme.gold, size: 20),
                const SizedBox(width: 8),
                const Text('Payment History',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.white)),
                const Spacer(),
                Icon(
                  _showHistory ? Icons.expand_less : Icons.expand_more,
                  color: AppTheme.white60,
                ),
              ],
            ),
          ),
          if (_showHistory) ...[
            const SizedBox(height: 12),
            if (_history.isEmpty)
              Text('No payment history', style: TextStyle(color: AppTheme.white50, fontSize: 13))
            else
              ..._history.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.greenBright.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.check, size: 14, color: AppTheme.greenBright),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(h['planName'] as String? ?? '',
                            style: const TextStyle(fontSize: 13, color: AppTheme.white80)),
                          Text(h['date'] is DateTime
                              ? '${(h['date'] as DateTime).day}/${(h['date'] as DateTime).month}/${(h['date'] as DateTime).year}'
                              : '',
                            style: TextStyle(fontSize: 11, color: AppTheme.white50)),
                        ],
                      ),
                    ),
                    Text(h['amount'] == 0 ? 'Free' : '\$${(h['amount'] as num).toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold,
                        color: (h['amount'] as num) == 0 ? AppTheme.white60 : AppTheme.gold,
                      )),
                  ],
                ),
              )),
          ],
        ],
      ),
    );
  }
}
