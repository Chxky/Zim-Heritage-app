import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/glass_card.dart';

class AncientStatesScreen extends StatelessWidget {
  const AncientStatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ancient States'),
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
              _buildStateCard(
                title: 'Great Zimbabwe',
                period: '11th - 15th Century',
                content: 'A powerful medieval city built entirely of stone without mortar. It was the center of a vast trading network linking the African interior with the Swahili Coast, Arab, and Chinese merchants. It stands as a testament to indigenous engineering and organizational brilliance.',
                icon: Icons.castle,
                color: AppTheme.gold,
              ),
              const SizedBox(height: 16),
              _buildStateCard(
                title: 'The Mutapa Empire',
                period: '15th - 17th Century',
                content: 'Founded by Nyatsimba Mutota, this empire stretched from the Zambezi river to the Limpopo. It controlled vast gold mines and established complex diplomatic relations with Portuguese traders before eventually declining due to internal conflicts and foreign interference.',
                icon: Icons.shield,
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(height: 16),
              _buildStateCard(
                title: 'The Rozvi State',
                period: '17th - 19th Century',
                content: 'Established by Changamire Dombo, the Rozvi state was known for its formidable military capability. They successfully drove the Portuguese out of the Zimbabwean plateau and constructed magnificent stone structures like Khami Ruins.',
                icon: Icons.security,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 24),
              _buildVRBanner(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStateCard({required String title, required String period, required String content, required IconData icon, required Color color}) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: color.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: color.withValues(alpha: 0.2), shape: BoxShape.circle),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(period, style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(content, style: const TextStyle(color: AppTheme.white70, fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildVRBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.purpleAccent, Colors.deepPurple]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.pushNamed(context, '/heritage'),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.vrpano, color: Colors.white, size: 48),
                const SizedBox(height: 12),
                const Text('Experience History in VR', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Take a virtual tour of Great Zimbabwe and Khami Ruins.', 
                  textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
