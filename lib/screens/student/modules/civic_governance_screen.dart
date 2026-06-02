import 'package:flutter/material.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/glass_card.dart';

class CivicGovernanceScreen extends StatelessWidget {
  const CivicGovernanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Civic Governance'),
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
              _buildIntroCard(),
              const SizedBox(height: 16),
              _buildRightsCard(),
              const SizedBox(height: 16),
              _buildGovStructureCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroCard() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: Colors.teal.withValues(alpha: 0.3),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.balance, size: 40, color: Colors.teal),
          SizedBox(height: 12),
          Text('The Constitution of Zimbabwe', style: TextStyle(color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Adopted in 2013, the Constitution is the supreme law of the land. It outlines the rights of citizens, the structure of the government, and the principles of national governance, including gender equality and the devolution of power.', 
            style: TextStyle(color: AppTheme.white70, fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }

  Widget _buildRightsCard() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: Colors.amber.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Declaration of Rights', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildListItem(Icons.health_and_safety, 'Right to life, liberty, and security of person.'),
          _buildListItem(Icons.school, 'Right to basic state-funded education.'),
          _buildListItem(Icons.how_to_vote, 'Political rights to free, fair, and regular elections.'),
          _buildListItem(Icons.record_voice_over, 'Freedom of expression and freedom of the media.'),
          _buildListItem(Icons.gavel, 'Right to equality and non-discrimination.'),
        ],
      ),
    );
  }

  Widget _buildGovStructureCard() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderColor: Colors.blueGrey.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Arms of Government', style: TextStyle(color: Colors.blueGrey, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildListItem(Icons.account_balance, 'Executive: The President and the Cabinet who enforce the laws.'),
          _buildListItem(Icons.menu_book, 'Legislature: The Parliament (Senate and National Assembly) who make the laws.'),
          _buildListItem(Icons.gavel, 'Judiciary: The Courts (Constitutional Court, Supreme Court, High Court) who interpret the laws.'),
        ],
      ),
    );
  }

  Widget _buildListItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppTheme.white50, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: AppTheme.white, fontSize: 14))),
        ],
      ),
    );
  }
}
