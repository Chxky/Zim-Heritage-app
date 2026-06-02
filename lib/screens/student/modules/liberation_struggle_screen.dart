import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/glass_card.dart';

class LiberationStruggleScreen extends StatelessWidget {
  const LiberationStruggleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Liberation Struggle'),
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
              _buildEventCard(
                title: 'First Chimurenga (1896-1897)',
                content: 'The primary uprising against the British South Africa Company (BSAC) led by spiritual mediums such as Mbuya Nehanda and Sekuru Kaguvi. Although suppressed, it laid the ideological foundation for future resistance.',
                color: Colors.redAccent,
              ),
              const SizedBox(height: 16),
              _buildEventCard(
                title: 'Second Chimurenga (1960s-1979)',
                content: 'The protracted armed struggle against the Rhodesian government. It was primarily fought by two guerrilla armies: ZANLA (Zimbabwe African National Liberation Army) and ZIPRA (Zimbabwe People\'s Revolutionary Army), supported by the rural masses.',
                color: AppTheme.primaryGreen,
              ),
              const SizedBox(height: 16),
              _buildEventCard(
                title: 'Lancaster House Agreement (1979)',
                content: 'The peace conference held in London that paved the way for majority rule and led to the drafting of the independence constitution.',
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 16),
              _buildEventCard(
                title: 'Independence Day (April 18, 1980)',
                content: 'Zimbabwe officially gained its independence, raising the new flag and embracing sovereignty. Bob Marley performed his famous "Zimbabwe" anthem at Rufaro Stadium to celebrate the historic moment.',
                color: AppTheme.gold,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard({required String title, required String content, required Color color}) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: color.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4, height: 24,
                decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(title, style: const TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(content, style: const TextStyle(color: AppTheme.white70, fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}
