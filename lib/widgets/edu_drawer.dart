import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import 'glass_card.dart';

class EduDrawer extends StatelessWidget {
  final User user;
  final int selectedIndex;
  final Function(int) onItemSelected;
  final List<DrawerItem> items;

  const EduDrawer({
    super.key,
    required this.user,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      width: 300,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.surfaceDark,
              AppTheme.surfaceMid.withValues(alpha: 0.98),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          border: const Border(
            right: BorderSide(color: AppTheme.white15, width: 1),
          ),
        ),
        child: Column(
          children: [
            // Drawer Header with Zimbabwe Bird
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppTheme.white10),
                ),
              ),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.gold.withValues(alpha: 0.4), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.gold.withValues(alpha: 0.15),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: SvgPicture.asset(
                        'assets/images/zimbabwe_bird_logo.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
                    ),
                    child: Text(
                      user.role.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.gold,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  if (user.school.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      user.school,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.white60,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final isSelected = selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [
                                  AppTheme.primaryGreen.withValues(alpha: 0.3),
                                  Colors.transparent,
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              )
                            : null,
                        border: isSelected
                            ? const Border(
                                left: BorderSide(color: AppTheme.gold, width: 3),
                              )
                            : null,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => onItemSelected(index),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              children: [
                                Icon(
                                  isSelected ? item.activeIcon : item.icon,
                                  size: 22,
                                  color: isSelected ? AppTheme.gold : AppTheme.white50,
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                      color: isSelected ? AppTheme.white : AppTheme.white70,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppTheme.gold,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Logout button
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await AuthService.logout();
                    if (!context.mounted) return;
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                  },
                  icon: const Icon(Icons.logout, size: 18),
                  label: const Text('Logout', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.redBright,
                    side: const BorderSide(color: AppTheme.redBright),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ),
            // Flag bar at bottom
            const FlagBar(),
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const DrawerItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
