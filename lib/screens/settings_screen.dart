import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../services/privacy_service.dart';
import '../services/update_service.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_card.dart';

class SettingsScreen extends StatefulWidget {
  final User user;

  const SettingsScreen({super.key, required this.user});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  String _appVersion = '2.0.0';
  String _locale = 'en';

  @override
  void initState() {
    super.initState();
    _loadAppInfo();
  }

  Future<void> _loadAppInfo() async {
    try {
      final version = await UpdateService.getCurrentVersion();
      if (mounted) setState(() => _appVersion = version);
    } catch (_) {}
  }

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

  Future<void> _exportData() async {
    try {
      final data = await PrivacyService.exportUserData(widget.user.id);
      final json = PrivacyService.generateDataExportJson(data);
      _showSnackbar('Data exported. Copying to clipboard...');
    } catch (e) {
      _showSnackbar('Failed to export data: $e');
    }
  }

  Future<void> _deleteData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete All Data'),
        content: const Text('Are you sure you want to delete all your data? This action cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: AppTheme.redBright)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      try {
        await PrivacyService.deleteUserData(widget.user.id);
        if (mounted) {
          _showSnackbar('All data deleted.');
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
        }
      } catch (e) {
        _showSnackbar('Failed to delete data: $e');
      }
    }
  }

  Widget _sectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.gold, size: 20),
          const SizedBox(width: 8),
          Semantics(header: true, child: Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white))),
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
    return Semantics(
      label: title,
      hint: subtitle,
      button: onTap != null,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? AppTheme.primaryGreen).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor ?? AppTheme.greenBright, size: 20),
        ),
        title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: AppTheme.white)),
        subtitle: subtitle != null
            ? Text(subtitle, style: const TextStyle(color: AppTheme.white50, fontSize: 12))
            : null,
        trailing: trailing,
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        dense: true,
      ),
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
                    icon: Icons.language,
                    title: 'Language',
                    subtitle: _locale == 'sn' ? 'chiShona' : _locale == 'nd' ? 'isiNdebele' : 'English',
                    trailing: const Icon(Icons.chevron_right, color: AppTheme.white30),
                    onTap: () => _showLanguagePicker(),
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
            _sectionHeader('Privacy & Data', Icons.shield_outlined),
            GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Column(
                children: [
                  _settingsTile(
                    icon: Icons.file_download_outlined,
                    title: 'Export My Data',
                    subtitle: 'Download all your data as JSON',
                    onTap: _exportData,
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.delete_forever_outlined,
                    iconColor: AppTheme.redBright,
                    title: 'Delete My Data',
                    subtitle: 'Permanently remove all your data',
                    onTap: _deleteData,
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
                    subtitle: _appVersion,
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.update,
                    title: 'Check for Updates',
                    onTap: () => UpdateService.openStoreListing(),
                  ),
                  const Divider(),
                  _settingsTile(
                    icon: Icons.public,
                    title: 'About ZimHeritage',
                    onTap: () => _showSnackbar('ZimHeritage v$_appVersion — Preserving Zimbabwean heritage through education.'),
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

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceDark,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Select Language', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.language, color: AppTheme.gold),
              title: const Text('English', style: TextStyle(color: AppTheme.white)),
              trailing: _locale == 'en' ? const Icon(Icons.check, color: AppTheme.gold) : null,
              onTap: () { setState(() => _locale = 'en'); Navigator.pop(ctx); },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: AppTheme.gold),
              title: const Text('chiShona', style: TextStyle(color: AppTheme.white)),
              trailing: _locale == 'sn' ? const Icon(Icons.check, color: AppTheme.gold) : null,
              onTap: () { setState(() => _locale = 'sn'); Navigator.pop(ctx); },
            ),
            ListTile(
              leading: const Icon(Icons.language, color: AppTheme.gold),
              title: const Text('isiNdebele', style: TextStyle(color: AppTheme.white)),
              trailing: _locale == 'nd' ? const Icon(Icons.check, color: AppTheme.gold) : null,
              onTap: () { setState(() => _locale = 'nd'); Navigator.pop(ctx); },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
