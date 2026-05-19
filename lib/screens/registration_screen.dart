// screens/registration_screen.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../theme/app_theme.dart';
import '../data/zimbabwe_curriculum.dart';
import '../services/auth_service.dart';
import '../widgets/glass_card.dart';

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
  final _confirmPasswordController = TextEditingController();
  final _schoolController = TextEditingController();

  String? _selectedRole;
  String? _selectedGrade;
  String _selectedCurriculum = 'zimsec';
  DateTime? _dateOfBirth;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  bool _faceCaptured = false;
  bool _ageVerified = false;
  XFile? _faceImage;
  int _step = 1;

  final List<String> _roles = ['student', 'teacher', 'parent'];
  final List<String> _gradeOptions = [
    'ECD A', 'ECD B',
    'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5', 'Grade 6', 'Grade 7',
    'Form 1', 'Form 2', 'Form 3', 'Form 4',
    'Form 5', 'Form 6',
  ];

  int get _age {
    if (_dateOfBirth == null) return 0;
    final now = DateTime.now();
    int age = now.year - _dateOfBirth!.year;
    if (now.month < _dateOfBirth!.month || (now.month == _dateOfBirth!.month && now.day < _dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  bool get _isAgeAppropriate {
    if (_selectedGrade == null) return false;
    final minAge = getMinAgeForGrade(_selectedGrade!);
    return _age >= minAge;
  }

  Future<void> _captureFace() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _faceImage = image;
        _faceCaptured = true;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Face captured successfully!'), backgroundColor: AppTheme.primaryGreen),
      );
    }
  }

  void _verifyAge() {
    if (_dateOfBirth == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your date of birth first'), backgroundColor: AppTheme.red),
      );
      return;
    }
    if (_selectedGrade == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your grade/level'), backgroundColor: AppTheme.red),
      );
      return;
    }
    if (_isAgeAppropriate) {
      setState(() => _ageVerified = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Age verified: $_age years - appropriate for $_selectedGrade'),
          backgroundColor: AppTheme.primaryGreen,
        ),
      );
    } else {
      final minAge = getMinAgeForGrade(_selectedGrade!);
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Age Not Appropriate'),
          content: Text(
            'You are $_age years old, but $_selectedGrade requires a minimum age of $minAge.\n\n'
            'Please select the correct grade level or contact your school.'),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
          ],
        ),
      );
    }
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_faceCaptured) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete facial recognition'), backgroundColor: AppTheme.red),
      );
      return;
    }
    if (!_ageVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete age verification'), backgroundColor: AppTheme.red),
      );
      return;
    }
    setState(() => _isLoading = true);
    try {
      final user = await AuthService.register(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        role: _selectedRole!,
        gradeLevel: _selectedGrade!,
        school: _schoolController.text,
        age: _age,
        hasFacialRecognition: _faceCaptured,
        curriculum: _selectedCurriculum,
      );
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceFirst('Exception: ', '')),
          backgroundColor: AppTheme.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _schoolController.dispose();
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
                opacity: 0.05,
                child: SvgPicture.asset(
                  'assets/images/flag_pattern.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.gold.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(Icons.school, size: 32, color: AppTheme.gold),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _step == 1 ? 'Create Account' : _step == 2 ? 'Age Verification' : 'Facial Recognition',
                                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.white),
                              ),
                              Text(
                                _step == 1 ? 'Join ZimHeritage Education' : _step == 2 ? 'Verify your age for $_selectedGrade' : 'Set up facial recognition',
                                style: const TextStyle(fontSize: 13, color: AppTheme.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: _step / 3.0,
                          minHeight: 6,
                          backgroundColor: AppTheme.white20,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.gold),
                        ),
                      ),
                      const SizedBox(height: 24),
                      GlassCard(
                        padding: const EdgeInsets.all(20),
                        borderRadius: 20,
                        child: Column(
                          children: [
                            if (_step == 1) _buildAccountStep(),
                            if (_step == 2) _buildAgeVerificationStep(),
                            if (_step == 3) _buildFacialRecognitionStep(),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          if (_step > 1)
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => setState(() => _step--),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  side: const BorderSide(color: AppTheme.white),
                                  foregroundColor: AppTheme.white,
                                ),
                                child: const Text('Back'),
                              ),
                            ),
                          if (_step > 1) const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : () {
                                if (_step == 1) {
                                  if (_formKey.currentState!.validate() && _selectedRole != null && _selectedGrade != null) {
                                    setState(() => _step = 2);
                                  }
                                } else if (_step == 2) {
                                  if (_ageVerified) {
                                    setState(() => _step = 3);
                                  } else {
                                    _verifyAge();
                                  }
                                } else {
                                  _register();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.gold,
                                foregroundColor: Colors.brown,
                                padding: const EdgeInsets.symmetric(vertical: 14),
                              ),
                              child: _isLoading
                                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.brown))
                                  : Text(_step == 3 ? 'Complete Registration' : 'Continue', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountStep() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Full Name', prefixIcon: Icon(Icons.person_outlined)),
          validator: (v) => (v == null || v.isEmpty) ? 'Enter your name' : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined)),
          keyboardType: TextInputType.emailAddress,
          validator: (v) => (v == null || v.isEmpty) ? 'Enter your email' : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              icon: Icon(_obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
          validator: (v) => (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirm,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            prefixIcon: const Icon(Icons.lock_outlined),
            suffixIcon: IconButton(
              icon: Icon(_obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined),
              onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
            ),
          ),
          validator: (v) {
            if (v == null || v.isEmpty) return 'Confirm your password';
            if (v != _passwordController.text) return 'Passwords do not match';
            return null;
          },
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: _selectedRole,
          decoration: const InputDecoration(labelText: 'Role', prefixIcon: Icon(Icons.badge_outlined)),
          items: _roles.map((r) => DropdownMenuItem(value: r, child: Text(r[0].toUpperCase() + r.substring(1)))).toList(),
          onChanged: (v) => setState(() => _selectedRole = v),
          validator: (v) => v == null ? 'Select your role' : null,
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: _selectedCurriculum,
          decoration: const InputDecoration(labelText: 'Curriculum', prefixIcon: Icon(Icons.menu_book_outlined)),
          items: const [
            DropdownMenuItem(value: 'zimsec', child: Text('ZIMSEC')),
            DropdownMenuItem(value: 'cambridge', child: Text('Cambridge International')),
          ],
          onChanged: (v) => setState(() => _selectedCurriculum = v ?? 'zimsec'),
        ),
        const SizedBox(height: 14),
        DropdownButtonFormField<String>(
          initialValue: _selectedGrade,
          decoration: const InputDecoration(labelText: 'Grade / Level', prefixIcon: Icon(Icons.school_outlined)),
          items: _gradeOptions.map((g) => DropdownMenuItem(value: g, child: Text('$g (${getAgeRange(g)})'))).toList(),
          onChanged: (v) => setState(() => _selectedGrade = v),
          validator: (v) => v == null ? 'Select your grade' : null,
        ),
        const SizedBox(height: 14),
        TextFormField(
          controller: _schoolController,
          decoration: const InputDecoration(labelText: 'School Name', prefixIcon: Icon(Icons.location_city_outlined)),
          validator: (v) => (v == null || v.isEmpty) ? 'Enter your school' : null,
        ),
      ],
    );
  }

  Widget _buildAgeVerificationStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.verified_user, color: AppTheme.gold),
            const SizedBox(width: 8),
            const Text('Verify Your Age', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
          ],
        ),
        const SizedBox(height: 4),
        Text('Select your date of birth to verify age eligibility for $_selectedGrade',
          style: TextStyle(color: AppTheme.white60)),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime(2010),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (date != null) setState(() => _dateOfBirth = date);
            },
            icon: const Icon(Icons.date_range),
            label: Text(_dateOfBirth == null ? 'Select your date of birth' : '${_dateOfBirth!.day}/${_dateOfBirth!.month}/${_dateOfBirth!.year}'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: AppTheme.gold),
              foregroundColor: AppTheme.gold,
            ),
          ),
        ),
        if (_dateOfBirth != null) ...[
          const SizedBox(height: 16),
          Container(
            width: double.infinity, padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppTheme.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Text('Your age: $_age years', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                const SizedBox(height: 4),
                Text('Level: $_selectedGrade (Min age: ${getMinAgeForGrade(_selectedGrade!)})',
                  style: TextStyle(color: AppTheme.white60)),
              ],
            ),
          ),
        ],
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _verifyAge,
            icon: Icon(_ageVerified ? Icons.check_circle : Icons.verified),
            label: Text(_ageVerified ? 'Age Verified' : 'Verify My Age'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _ageVerified ? AppTheme.primaryGreen : AppTheme.primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        if (_ageVerified) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity, padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.greenBright.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.greenBright),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: AppTheme.greenBright),
                SizedBox(width: 8),
                Text('Age Verified Successfully!', style: TextStyle(color: AppTheme.greenBright, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildFacialRecognitionStep() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _faceCaptured ? AppTheme.greenBright.withValues(alpha: 0.15) : AppTheme.white10,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _faceCaptured ? AppTheme.greenBright : AppTheme.white30,
                  width: 3,
                ),
              ),
              child: Icon(Icons.face, size: 80, color: _faceCaptured ? AppTheme.greenBright : AppTheme.white50),
            ),
            if (_faceCaptured)
              Positioned(
                bottom: 10, right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: AppTheme.white, size: 20),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        const Text('Facial Recognition', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
        const SizedBox(height: 8),
        Text('Capture a clear photo of your face for secure login verification.',
          textAlign: TextAlign.center, style: TextStyle(color: AppTheme.white60)),
        const SizedBox(height: 16),
        if (_faceCaptured && _faceImage != null)
          kIsWeb
              ? CircleAvatar(
                  radius: 50,
                  backgroundColor: AppTheme.gold.withValues(alpha: 0.2),
                  child: const Icon(Icons.check, color: AppTheme.gold, size: 40),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_faceImage!.path),
                ),
        if (_faceCaptured) const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _captureFace,
            icon: Icon(_faceCaptured ? Icons.replay : Icons.camera_alt),
            label: Text(_faceCaptured ? 'Re-capture Face' : 'Capture Face'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        if (_faceCaptured) ...[
          const SizedBox(height: 12),
          Container(
            width: double.infinity, padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.greenBright.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppTheme.greenBright),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: AppTheme.greenBright),
                SizedBox(width: 8),
                Text('Face captured! Proceed to complete registration.',
                  style: TextStyle(color: AppTheme.greenBright, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
