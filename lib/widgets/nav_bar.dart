import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Widget screen;

  const NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.screen,
  });
}

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        border: const Border(
          top: BorderSide(color: AppTheme.white10),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (i) {
              final items = [
                _buildNavItem(Icons.dashboard_rounded, Icons.dashboard_rounded, 'Home', 0),
                _buildNavItem(Icons.book_rounded, Icons.book_rounded, 'Subjects', 1),
                _buildNavItem(Icons.assignment_rounded, Icons.assignment_rounded, 'Homework', 2),
                _buildNavItem(Icons.trending_up_rounded, Icons.trending_up_rounded, 'Progress', 3),
                _buildNavItem(Icons.auto_awesome, Icons.auto_awesome, 'AI Tutor', 4),
              ];
              return items[i];
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.gold.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: AppTheme.gold.withValues(alpha: 0.3), width: 1)
              : null,
        ),
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.95, end: 1.0),
          duration: const Duration(milliseconds: 250),
          builder: (context, value, child) {
            return Transform.scale(
              scale: isSelected ? 1.05 : 1.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isSelected ? activeIcon : icon,
                    color: isSelected ? AppTheme.gold : AppTheme.white50,
                    size: 24,
                    shadows: isSelected
                        ? [Shadow(color: AppTheme.gold.withValues(alpha: 0.5), blurRadius: 10)]
                        : null,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? AppTheme.gold : AppTheme.white50,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TeacherNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const TeacherNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        border: const Border(
          top: BorderSide(color: AppTheme.white10),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(5, (i) {
              final items = [
                _buildNavItem(Icons.dashboard_rounded, 'Dashboard', 0),
                _buildNavItem(Icons.people_rounded, 'Students', 1),
                _buildNavItem(Icons.vpn_key_rounded, 'Keys', 2),
                _buildNavItem(Icons.auto_awesome, 'AI', 3),
                _buildNavItem(Icons.rate_review_rounded, 'Review', 4),
              ];
              return items[i];
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.gold.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: AppTheme.gold.withValues(alpha: 0.3), width: 1)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppTheme.gold : AppTheme.white50,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppTheme.gold : AppTheme.white50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
