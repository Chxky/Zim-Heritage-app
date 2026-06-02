import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/glass_card.dart';

class UnhuUbuntuScreen extends StatelessWidget {
  const UnhuUbuntuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Philosophy of Unhu'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter, end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      backgroundColor: AppTheme.surfaceDark,
      body: Container(
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildConceptCard(
                title: '"I am because we are"',
                subtitle: 'Mwana waMambo Muranda Kumwe',
                content: 'Unhu (in Shona), Ubuntu (in Ndebele), or Vumunhu (in Kalanga) is the fundamental African philosophy of human interdependence, solidarity, and communalism. It emphasizes that a person is a person through other people.',
                icon: Icons.people_alt,
                color: Colors.orangeAccent,
              ),
              const SizedBox(height: 16),
              _buildDetailSection('Core Values of Unhu', [
                'Respect for Elders (Kuremekedza vakuru)',
                'Hospitality and Generosity',
                'Honesty and Integrity (Kuvimbika)',
                'Compassion and Empathy',
                'Communal Responsibility',
              ]),
              const SizedBox(height: 16),
              _buildDetailSection('Application in Modern Society', [
                'Environmental Conservation: Treating the land with respect as it belongs to ancestors and future generations.',
                'Justice: Focus on restorative justice and mediation (Dare/Inkundla) rather than purely punitive measures.',
                'Social Welfare: Caring for orphans, widows, and the vulnerable in the community (Zunde raMambo).',
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConceptCard({required String title, required String subtitle, required String content, required IconData icon, required Color color}) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: color.withValues(alpha: 0.4),
      boxShadow: [BoxShadow(color: color.withValues(alpha: 0.2), blurRadius: 15)],
      child: Column(
        children: [
          Icon(icon, size: 48, color: color),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(color: AppTheme.white, fontSize: 22, fontWeight: FontWeight.bold)),
          Text(subtitle, style: TextStyle(color: color, fontSize: 14, fontStyle: FontStyle.italic)),
          const SizedBox(height: 16),
          Text(content, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.white70, fontSize: 15, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> points) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: AppTheme.gold.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: AppTheme.gold, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...points.map((point) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, color: AppTheme.primaryGreen, size: 20),
                const SizedBox(width: 12),
                Expanded(child: Text(point, style: const TextStyle(color: AppTheme.white, fontSize: 14, height: 1.4))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
