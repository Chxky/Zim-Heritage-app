// screens/admin_user_management_screen.dart
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/user.dart';
import '../../services/user_repository.dart';
import '../../widgets/glass_card.dart';

class AdminUserManagementScreen extends StatefulWidget {
  const AdminUserManagementScreen({super.key});

  @override
  State<AdminUserManagementScreen> createState() =>
      _AdminUserManagementScreenState();
}

class _AdminUserManagementScreenState
    extends State<AdminUserManagementScreen> {
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];
  bool _loading = true;
  String _searchQuery = '';
  String _selectedRole = 'All';

  static const _roles = ['All', 'Student', 'Teacher', 'Parent', 'Admin'];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _loading = true);
    try {
      final users = await UserRepository.getAllUsers();
      if (mounted) {
        setState(() {
          _allUsers = users;
          _loading = false;
          _applyFilters();
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _applyFilters() {
    var users = _allUsers;
    if (_selectedRole != 'All') {
      users = users.where((u) =>
          u.role.toLowerCase() == _selectedRole.toLowerCase()).toList();
    }
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      users = users.where((u) =>
          u.name.toLowerCase().contains(q) ||
          u.email.toLowerCase().contains(q)).toList();
    }
    setState(() => _filteredUsers = users);
  }

  Future<void> _updateVerification(User user, bool verified) async {
    try {
      await UserRepository.updateUser(user.id, {'isVerified': verified});
      if (mounted) {
        setState(() {
          _allUsers = _allUsers.map((u) =>
              u.id == user.id ? u.copyWith(isVerified: verified) : u).toList();
          _applyFilters();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(verified
                ? '${user.name} has been activated'
                : '${user.name} has been deactivated'),
            backgroundColor: AppTheme.greenBright,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update user: $e'),
            backgroundColor: AppTheme.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  Color _roleColor(String role) {
    switch (role.toLowerCase()) {
      case 'student':
        return Colors.blue;
      case 'teacher':
        return AppTheme.greenBright;
      case 'parent':
        return Colors.orange;
      case 'admin':
        return Colors.purple;
      default:
        return AppTheme.greyMedium;
    }
  }

  String _roleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'student':
        return 'S';
      case 'teacher':
        return 'T';
      case 'parent':
        return 'P';
      case 'admin':
        return 'A';
      default:
        return '?';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
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
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _filteredUsers.isEmpty
                    ? _buildEmptyState()
                    : _buildUserList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: TextField(
        onChanged: (v) {
          _searchQuery = v;
          _applyFilters();
        },
        decoration: InputDecoration(
          hintText: 'Search by name or email...',
          prefixIcon: const Icon(Icons.search, size: 20),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 18),
                  onPressed: () {
                    _searchQuery = '';
                    _applyFilters();
                  },
                )
              : null,
          filled: true,
          fillColor: AppTheme.surfaceMid,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.white20),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: AppTheme.white20),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppTheme.gold, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        style: const TextStyle(color: AppTheme.white),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _roles.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final role = _roles[index];
          final selected = _selectedRole == role;
          return FilterChip(
            label: Text(role),
            selected: selected,
            onSelected: (v) {
              setState(() => _selectedRole = role);
              _applyFilters();
            },
            selectedColor: _roleColor(role).withValues(alpha: 0.3),
            checkmarkColor: _roleColor(role),
            labelStyle: TextStyle(
              color: selected ? _roleColor(role) : AppTheme.white70,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              fontSize: 12,
            ),
            backgroundColor: AppTheme.surfaceMid,
            side: BorderSide(
              color: selected
                  ? _roleColor(role).withValues(alpha: 0.6)
                  : AppTheme.white20,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isNotEmpty || _selectedRole != 'All'
                ? Icons.search_off
                : Icons.people_outline,
            size: 64,
            color: AppTheme.white50,
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty || _selectedRole != 'All'
                ? 'No users match your search'
                : 'No users found',
            style: const TextStyle(color: AppTheme.white60, fontSize: 15),
          ),
          if (_searchQuery.isNotEmpty || _selectedRole != 'All') ...[
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                _searchQuery = '';
                _selectedRole = 'All';
                _applyFilters();
              },
              child: const Text('Clear filters'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUserList() {
    return RefreshIndicator(
      onRefresh: _loadUsers,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
        itemCount: _filteredUsers.length,
        itemBuilder: (context, index) {
          final user = _filteredUsers[index];
          return _buildUserCard(user);
        },
      ),
    );
  }

  Widget _buildUserCard(User user) {
    final color = _roleColor(user.role);
    return GlassCard(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.3),
            child: Text(
              _roleIcon(user.role),
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.white,
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!user.isVerified)
                      Container(
                        margin: const EdgeInsets.only(left: 6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.red.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'INACTIVE',
                          style: TextStyle(
                            fontSize: 9,
                            color: AppTheme.redBright,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  user.email,
                  style: const TextStyle(
                    color: AppTheme.white60,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        user.role,
                        style: TextStyle(
                          fontSize: 10,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (user.gradeLevel.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.white10,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          user.gradeLevel,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.white60,
                          ),
                        ),
                      ),
                    ],
                    if (user.school.isNotEmpty) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppTheme.white10,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          user.school,
                          style: const TextStyle(
                            fontSize: 10,
                            color: AppTheme.white60,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: AppTheme.white60, size: 20),
            onSelected: (value) {
              if (value == 'activate') {
                _updateVerification(user, true);
              } else if (value == 'deactivate') {
                _updateVerification(user, false);
              }
            },
            itemBuilder: (context) => [
              if (user.isVerified)
                const PopupMenuItem(
                  value: 'deactivate',
                  child: Row(
                    children: [
                      Icon(Icons.block, size: 18, color: AppTheme.redBright),
                      SizedBox(width: 8),
                      Text('Deactivate',
                          style: TextStyle(color: AppTheme.white)),
                    ],
                  ),
                )
              else
                const PopupMenuItem(
                  value: 'activate',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle,
                          size: 18, color: AppTheme.greenBright),
                      SizedBox(width: 8),
                      Text('Activate',
                          style: TextStyle(color: AppTheme.white)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
