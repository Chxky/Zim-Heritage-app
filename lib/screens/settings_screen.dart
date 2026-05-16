// screens/settings_screen.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../models/user.dart';
import '../widgets/glass_card.dart';
import '../services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  final User user;

  const SettingsScreen({super.key, required this.user});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _logout() async {
    await AuthService.logout();
    if (mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
    }
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.gold, size: 20),
          const SizedBox(width: 8),
          Text(title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.white,
            )),
        ],
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? iconColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? AppTheme.primaryGreen).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor ?? AppTheme.greenBright, size: 20),
      ),
      title: Text(title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: AppTheme.white,
        )),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: const TextStyle(color: AppTheme.white50, fontSize: 12))
          : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('Account', Icons.person_outline),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  _settingsTile(
                    icon: Icons.badge_outlined,
                    title: widget.user.name,
                    subtitle: 'Name',
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.email_outlined,
                    title: widget.user.email,
                    subtitle: 'Email',
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.school_outlined,
                    title: widget.user.role,
                    subtitle: 'Role',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _sectionHeader('Preferences', Icons.tune),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  _settingsTile(
                    icon: Icons.dark_mode,
                    title: 'Dark Mode',
                    trailing: Switch(
                      value: true,
                      onChanged: null,
                      activeThumbColor: AppTheme.gold,
                      inactiveThumbColor: AppTheme.white30,
                    ),
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: 'English',
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.white30),
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    trailing: Switch(
                      value: _notificationsEnabled,
                      onChanged: (v) => setState(() => _notificationsEnabled = v),
                      activeThumbColor: AppTheme.gold,
                      inactiveThumbColor: AppTheme.white30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _sectionHeader('App Info', Icons.info_outline),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  _settingsTile(
                    icon: Icons.smartphone,
                    title: 'App Version',
                    subtitle: '2.0.0',
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.public,
                    title: 'About ZimHeritage',
                    onTap: () => _showSnackbar('ZimHeritage v2.0.0 — Preserving Zimbabwean heritage through education.'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _sectionHeader('Support', Icons.headset_mic_outlined),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  _settingsTile(
                    icon: Icons.mail_outline,
                    title: 'Contact Us',
                    onTap: () => _showSnackbar('Contact us at support@zimheritage.co.zw'),
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.shield_outlined,
                    title: 'Privacy Policy',
                    onTap: () => _showSnackbar('Your data is handled securely in accordance with our Privacy Policy.'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            _sectionHeader('Account Actions', Icons.security),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              borderColor: AppTheme.red.withValues(alpha: 0.3),
              child: _settingsTile(
                icon: Icons.logout,
                iconColor: AppTheme.redBright,
                title: 'Logout',
                subtitle: 'Sign out of your account',
                onTap: _logout,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
