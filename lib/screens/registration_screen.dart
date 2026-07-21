import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_theme.dart';
import '../services/auth_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _schoolController = TextEditingController();
  final _districtController = TextEditingController();
  bool _isLoading = false;
  
  String _selectedRole = 'Student';
  String _selectedCurriculum = 'ZIMSEC (Core Heritage Curriculum)';
  String _selectedProvince = 'Harare Metropolitan';
  String _selectedLanguage = 'English';
  
  final List<String> _roles = ['Student', 'Parent', 'Teacher'];
  final List<String> _curricula = ['ZIMSEC (Core Heritage Curriculum)', 'Cambridge (Supplementary Pathway)'];
  final List<String> _provinces = [
    'Bulawayo Metropolitan', 'Harare Metropolitan', 'Manicaland',
    'Mashonaland Central', 'Mashonaland East', 'Mashonaland West',
    'Masvingo', 'Matabeleland North', 'Matabeleland South', 'Midlands'
  ];
  final List<String> _languages = [
    'Chewa', 'Chibarwe', 'English', 'Kalanga', 'Koisan', 'Nambya', 'Ndau',
    'Ndebele', 'Shangani', 'Shona', 'Sign Language', 'Sotho', 'Tonga',
    'Tswana', 'Venda', 'Xhosa'
  ];


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _schoolController.dispose();
    _districtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.06,
                child: SvgPicture.asset('assets/images/flag_pattern.svg', fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: AppTheme.gold),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        const Text('National Education Registration', 
                          style: TextStyle(color: AppTheme.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 60, height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.gold.withValues(alpha: 0.4), width: 2),
                      ),
                      child: ClipOval(child: Image.asset('assets/images/zim_bird_real.png', fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 12),
                    const Text('MINISTRY OF PRIMARY AND SECONDARY EDUCATION',
                      style: TextStyle(fontSize: 10, color: AppTheme.white60, letterSpacing: 1.5, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    
                    ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.white.withValues(alpha: 0.10), AppTheme.white.withValues(alpha: 0.04)],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppTheme.white20, width: 1),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildSectionTitle('Personal Information', Icons.person),
                                const SizedBox(height: 16),
                                _buildTextField('Full Name', Icons.badge, _nameController),
                                const SizedBox(height: 12),
                                _buildTextField('Email Address', Icons.email, _emailController),
                                const SizedBox(height: 12),
                                _buildTextField('Password', Icons.lock, _passwordController, obscureText: true),
                                const SizedBox(height: 12),
                                _buildDropdown('Role', _roles, _selectedRole, (v) => setState(() => _selectedRole = v!)),
                                
                                const SizedBox(height: 24),
                                _buildSectionTitle('Academic Profile', Icons.school),
                                const SizedBox(height: 16),
                                _buildDropdown('Curriculum Pathway', _curricula, _selectedCurriculum, (v) => setState(() => _selectedCurriculum = v!)),
                                const SizedBox(height: 12),
                                _buildTextField('MoPSE School Registration Code', Icons.numbers, _schoolController),
                                
                                const SizedBox(height: 24),
                                _buildSectionTitle('Geo-Tagging & Demographics', Icons.my_location),
                                const SizedBox(height: 8),
                                const Text('Data used to optimize rural edge nodes and map educational resources.', 
                                  style: TextStyle(color: AppTheme.white50, fontSize: 10)),
                                const SizedBox(height: 16),
                                _buildDropdown('Province', _provinces, _selectedProvince, (v) => setState(() => _selectedProvince = v!)),
                                const SizedBox(height: 12),
                                _buildTextField('District / Locality', Icons.map, _districtController),
                                const SizedBox(height: 12),
                                _buildDropdown('Primary Language', _languages, _selectedLanguage, (v) => setState(() => _selectedLanguage = v!)),
                                
                                const SizedBox(height: 32),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.gold,
                                      foregroundColor: AppTheme.surfaceDark,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        setState(() => _isLoading = true);
                                        AuthService.register(
                                          name: _nameController.text.trim(),
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                          role: _selectedRole.toLowerCase(),
                                          gradeLevel: 'N/A', // Set later in app
                                          school: _schoolController.text.trim(),
                                          age: 0,
                                          curriculum: _selectedCurriculum,
                                        ).then((user) {
                                          if (!mounted) return;
                                          Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
                                        }).catchError((e) {
                                          if (!mounted) return;
                                          setState(() => _isLoading = false);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text(e.toString()), backgroundColor: Colors.red)
                                          );
                                        });
                                      }
                                    },
                                    child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppTheme.surfaceDark, strokeWidth: 2)) : const Text('REGISTER & GEO-TAG ACCOUNT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      setState(() => _isLoading = true);
                                      try {
                                        final user = await AuthService.signInWithGoogle(
                                          role: _selectedRole,
                                          curriculum: _selectedCurriculum,
                                          province: _selectedProvince,
                                          language: _selectedLanguage,
                                        );
                                        if (!mounted) return;
                                        Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
                                      } catch (e) {
                                        if (!mounted) return;
                                        setState(() => _isLoading = false);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(e.toString()), backgroundColor: Colors.red)
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.g_mobiledata, size: 28),
                                    label: const Text('Sign in with Google'),
                                    style: OutlinedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      side: const BorderSide(color: AppTheme.white50),
                                      foregroundColor: AppTheme.white80,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceDark.withValues(alpha: 0.5),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.security, color: AppTheme.greenBright, size: 20),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Official Government Portal',
                                              style: TextStyle(color: AppTheme.white, fontSize: 11, fontWeight: FontWeight.bold)),
                                            Text('Secured under the Zimbabwe Cyber & Data Protection Act',
                                              style: TextStyle(color: AppTheme.greenBright, fontSize: 9)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.gold, size: 18),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildTextField(String label, IconData icon, TextEditingController controller, {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: AppTheme.white, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppTheme.white60),
        filled: true,
        fillColor: AppTheme.surfaceDark.withValues(alpha: 0.5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        labelStyle: const TextStyle(color: AppTheme.white50, fontSize: 12),
      ),
      validator: (v) => v!.isEmpty ? 'Required' : null,
    );
  }

  Widget _buildDropdown(String label, List<String> items, String value, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: AppTheme.surfaceDark.withValues(alpha: 0.5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        labelStyle: const TextStyle(color: AppTheme.white50, fontSize: 12),
      ),
      dropdownColor: AppTheme.surfaceDark,
      style: const TextStyle(color: AppTheme.white, fontSize: 13),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
