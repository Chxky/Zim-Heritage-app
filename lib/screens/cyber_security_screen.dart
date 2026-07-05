import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CyberSecurityScreen extends StatelessWidget {
  const CyberSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Cyber Security & Privacy', style: TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.gold),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCard(),
                const SizedBox(height: 24),
                const Text('Key Protection Areas', style: TextStyle(color: AppTheme.gold, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                _buildSecurityCard(
                  title: 'Anti-Cyberbullying',
                  description: 'Zero tolerance for online harassment in schools. Report abuse securely to MoPSE.',
                  icon: Icons.shield,
                  color: AppTheme.gold,
                ),
                const SizedBox(height: 12),
                _buildSecurityCard(
                  title: 'Data Encryption',
                  description: 'All student records are encrypted end-to-end to prevent unauthorized access.',
                  icon: Icons.lock_outline,
                  color: AppTheme.primaryGreen,
                ),
                const SizedBox(height: 12),
                _buildSecurityCard(
                  title: 'Phishing Awareness',
                  description: 'Learn how to identify fake links and malicious actors targeting students.',
                  icon: Icons.phishing,
                  color: AppTheme.redBright,
                ),
                const SizedBox(height: 12),
                _buildSecurityCard(
                  title: 'Digital Footprint',
                  description: 'Your online actions are permanent. Maintain a professional digital footprint.',
                  icon: Icons.fingerprint,
                  color: Colors.cyanAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppTheme.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppTheme.white20),
          ),
          child: Column(
            children: [
              const Icon(Icons.security, size: 64, color: AppTheme.gold),
              const SizedBox(height: 16),
              const Text('Zimbabwe Cyber & Data Protection Act', 
                style: TextStyle(color: AppTheme.white, fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text('This educational portal is fully compliant with Chapter 11:22, ensuring all student data is localized, anonymized, and secure.',
                style: TextStyle(color: AppTheme.white70, fontSize: 13, height: 1.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppTheme.greenBright),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: AppTheme.greenBright, size: 16),
                    SizedBox(width: 8),
                    Text('System Secure', style: TextStyle(color: AppTheme.greenBright, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityCard({required String title, required String description, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(description, style: const TextStyle(color: AppTheme.white60, fontSize: 12, height: 1.4)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
