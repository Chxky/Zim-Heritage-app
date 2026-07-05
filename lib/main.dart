import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:local_auth/local_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'theme/app_theme.dart';
import 'models/user.dart' as models;
import 'data/zimbabwe_curriculum.dart';
import 'data/cambridge_curriculum.dart';
import 'services/auth_service.dart';
import 'services/env_config.dart';
import 'services/seeding_service.dart';
import 'services/user_repository.dart';
import 'services/submission_repository.dart';
import 'services/homework_repository.dart';
import 'services/sentry_service.dart';
import 'services/di_container.dart';
import 'services/notification_service.dart';
import 'services/l10n_service.dart';
import 'services/local_persistence_service.dart';
import 'services/privacy_service.dart';
import 'services/security_service.dart';
import 'services/deep_link_service.dart';
import 'services/update_service.dart';
import 'services/security_service.dart';
import 'screens/student/student_dashboard.dart';
import 'screens/teacher/teacher_dashboard.dart';
import 'screens/parent/parent_dashboard.dart';
import 'screens/registration_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/parent_child_detail_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/admin_user_management_screen.dart';
import 'screens/teacher/homework_create_screen.dart';
import 'screens/national/national_dashboard.dart';
import 'screens/national/exam_predictor_screen.dart';
import 'screens/national/learner_passport_screen.dart';
import 'screens/national/heritage_preservation_screen.dart';
import 'screens/ministry_dashboard_screen.dart';
import 'screens/zimbabwe_map_screen.dart';
import 'screens/virtual_tour_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/cyber_security_screen.dart';
import 'screens/student/digital_library_screen.dart';
import 'screens/student/heritage_learning_hub.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/challenges_screen.dart';
import 'screens/report_card_screen.dart';
import 'screens/student/attendance_screen.dart';
import 'screens/messaging/conversation_list_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/student/ai_assistant_screen.dart';
import 'widgets/glass_card.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvConfig.load();

  try {
    await setupDependencyInjection();
  } catch (e) {
    debugPrint('DI setup failed (non-fatal): $e');
  }

  if (EnvConfig.useFirebase) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    try {
      await NotificationService.init();
      await SeedingService.seedAllIfNeeded();
    } catch (e) {
      SentryService.captureError(e, StackTrace.current, hint: 'Firebase init');
    }
  } else {
    try {
      await SeedingService.seedAllIfNeeded();
    } catch (_) {}
  }

  try {
    await SentryService.init();
  } catch (e) {
    debugPrint('Sentry init failed (non-fatal): $e');
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const ZimHeritageApp());
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

class ZimHeritageApp extends StatelessWidget {
  const ZimHeritageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZimHeritage - Zimbabwe Heritage Curriculum',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      onGenerateRoute: _generateRoute,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: L10nService.supportedLocales,
      locale: _resolveLocale,
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (final supported in supportedLocales) {
            if (supported.languageCode == locale.languageCode) {
              return supported;
            }
          }
        }
        return L10nService.fallbackLocale;
      },
    );
  }

  Locale? get _resolveLocale {
    try {
      final code = EnvConfig.appLocale;
      if (code == 'sn') return const Locale('sn');
      if (code == 'nd') return const Locale('nd');
    } catch (_) {}
    return null;
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case '/login':
        return _slideRoute(const LoginScreen());
      case '/register':
        return _slideRoute(const RegistrationScreen());
      case '/security':
        return _slideRoute(const CyberSecurityScreen());
      case '/digital-library':
        return _slideRoute(const DigitalLibraryScreen());
      case '/heritage-learning':
        return _slideRoute(const HeritageLearningHub());
      case '/forgot-password':
        return _slideRoute(const ForgotPasswordScreen());
      case '/edit-profile':
        final user1 = settings.arguments;
        if (user1 is! models.User) return MaterialPageRoute(builder: (_) => const LoginScreen());
        return _slideRoute(EditProfileScreen(user: user1));
      case '/notifications':
        final user2 = settings.arguments;
        if (user2 is! models.User) return MaterialPageRoute(builder: (_) => const LoginScreen());
        return _slideRoute(NotificationsScreen(user: user2));
      case '/settings':
        final user3 = settings.arguments;
        if (user3 is! models.User) return MaterialPageRoute(builder: (_) => const LoginScreen());
        return _slideRoute(SettingsScreen(user: user3));
      case '/homework-create':
        final user4 = settings.arguments;
        if (user4 is! models.User) return MaterialPageRoute(builder: (_) => const LoginScreen());
        return _slideRoute(HomeworkCreateScreen(user: user4));
      case '/national-dashboard':
        return _slideRoute(const NationalDashboard());
      case '/heritage':
        return _slideRoute(const HeritagePreservationScreen());
      case '/exam-predictor':
        final grade = settings.arguments as String? ?? 'Grade 7';
        return _slideRoute(ExamPredictorScreen(gradeLevel: grade));
      case '/learner-passport':
        final args = settings.arguments as Map<String, String>?;
        return _slideRoute(LearnerPassportScreen(
          studentName: args?['name'] ?? 'Student',
          gradeLevel: args?['grade'] ?? 'Grade 7',
          school: args?['school'] ?? 'Zimbabwe School',
          studentId: args?['id'] ?? 'demo_001',
        ));
      case '/ministry-dashboard':
        return _slideRoute(const MinistryDashboardScreen());
      case '/virtual-tour':
        final site = settings.arguments as String? ?? 'Great Zimbabwe';
        return _slideRoute(VirtualTourScreen(siteName: site));
      case '/zimbabwe-map':
        return _slideRoute(const ZimbabweMapScreen());
      case '/leaderboard':
        return _slideRoute(const LeaderboardScreen());
      case '/challenges':
        return _slideRoute(const ChallengesScreen());
      case '/report-card':
        final rcUser = settings.arguments;
        if (rcUser is! models.User) return MaterialPageRoute(builder: (_) => const LoginScreen());
        return _slideRoute(ReportCardScreen(student: rcUser));
      case '/attendance':
        final attUser = settings.arguments;
        if (attUser is! models.User) return MaterialPageRoute(builder: (_) => const LoginScreen());
        return _slideRoute(AttendanceScreen(user: attUser));
      case '/messages':
        final msgUser = settings.arguments;
        if (msgUser is! models.User) return MaterialPageRoute(builder: (_) => const LoginScreen());
        return _slideRoute(ConversationListScreen(currentUserId: msgUser.id, currentUserName: msgUser.name));
      case '/calendar':
        return _slideRoute(const CalendarScreen());
      case '/ai-assistant':
        return _slideRoute(const AiAssistantScreen());
      case '/user-management':
        return _slideRoute(const AdminUserManagementScreen());
      case '/dashboard':
        final user = settings.arguments;
        if (user is! models.User) return MaterialPageRoute(builder: (_) => const LoginScreen());
        return _slideRoute(_getDashboardForRole(user));
      default:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
    }
  }

  PageRouteBuilder _slideRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _getDashboardForRole(models.User user) {
    switch (user.role) {
      case 'student':
        return StudentDashboard(user: user);
      case 'teacher':
        return TeacherDashboard(user: user);
      case 'parent':
        return ParentDashboard(user: user);
      case 'admin':
        return AdminDashboard(user: user);
      default:
        return StudentDashboard(user: user);
    }
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleUp;
  late Animation<Offset> _slideUp;
  late Animation<double> _glowPulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _fadeIn = CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.5, curve: Curves.easeIn));
    _scaleUp = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.6, curve: Curves.elasticOut)),
    );
    _slideUp = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.4, 1.0, curve: Curves.easeOut)),
    );
    _glowPulse = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.2, 0.8, curve: Curves.easeInOut)),
    );
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () async {
      if (!mounted) return;
      try {
        final user = await AuthService.getCurrentUserFromSession().timeout(
          const Duration(seconds: 5),
          onTimeout: () async => null,
        );
        if (!mounted) return;
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      } catch (_) {
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
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
                opacity: 0.04,
                child: SvgPicture.asset(
                  'assets/images/flag_pattern.svg',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) => Container(),
                ),
              ),
            ),
            Positioned(
              top: -100, right: -100,
              child: Container(
                width: 300, height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.greenBright.withValues(alpha: 0.03),
                ),
              ),
            ),
            Positioned(
              bottom: -60, left: -60,
              child: Container(
                width: 200, height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.gold.withValues(alpha: 0.05),
                ),
              ),
            ),
            Center(
              child: FadeTransition(
                opacity: _fadeIn,
                child: ScaleTransition(
                  scale: _scaleUp,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedBuilder(
                        animation: _glowPulse,
                        builder: (context, child) {
                          return Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.gold.withValues(alpha: 0.3 * _glowPulse.value),
                                  blurRadius: 40 * _glowPulse.value,
                                  spreadRadius: 10 * _glowPulse.value,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: SvgPicture.asset(
                                'assets/images/zimbabwe_bird_logo.svg',
                                fit: BoxFit.cover,
                                placeholderBuilder: (context) => Container(
                                  color: AppTheme.gold.withValues(alpha: 0.3),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      Text('REPUBLIC OF ZIMBABWE'.toUpperCase(),
                        style: const TextStyle(fontSize: 11, color: AppTheme.white50, letterSpacing: 4, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      const Text('Ministry of Primary & Secondary Education',
                        style: TextStyle(fontSize: 12, color: AppTheme.white30, letterSpacing: 1)),
                      const SizedBox(height: 20),
                      const Text('ZimHeritage',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.white,
                          letterSpacing: 2,
                          shadows: [
                            Shadow(color: AppTheme.gold, blurRadius: 30),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text('Heritage-Based Curriculum Platform',
                        style: TextStyle(fontSize: 15, color: AppTheme.gold, letterSpacing: 0.5, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 4),
                      const Text('National Digital Education Infrastructure',
                        style: TextStyle(fontSize: 11, color: AppTheme.white30, letterSpacing: 0.5)),
                      const SizedBox(height: 16),
                      SlideTransition(
                        position: _slideUp,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [AppTheme.gold.withValues(alpha: 0.15), AppTheme.gold.withValues(alpha: 0.05)],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.verified, color: AppTheme.gold, size: 14),
                              SizedBox(width: 8),
                              Text('ECD • Primary • O-Level • A-Level',
                                style: TextStyle(fontSize: 12, color: AppTheme.gold, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SlideTransition(
                        position: _slideUp,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.5)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.wifi_off, color: AppTheme.greenBright, size: 12),
                              SizedBox(width: 6),
                              Text('RURAL OFFLINE AI READY',
                                style: TextStyle(fontSize: 10, color: AppTheme.greenBright, fontWeight: FontWeight.bold, letterSpacing: 1)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SlideTransition(
                        position: _slideUp,
                        child: const Text('9,872 Schools • 4.8M Students • 148,200 Teachers',
                          style: TextStyle(fontSize: 10, color: AppTheme.white20, letterSpacing: 0.5)),
                      ),
                      const SizedBox(height: 40),
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.gold),
                        strokeWidth: 3,
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
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _error;
  String _selectedCurriculum = 'ZIMSEC (Core Heritage Curriculum)';
  final List<String> _curricula = [
    'ZIMSEC (Core Heritage Curriculum)',
    'Cambridge (Supplementary Pathway)'
  ];
  late AnimationController _spinController;
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() { _isLoading = true; _error = null; });

      try {
        final user = await AuthService.login(
          SecurityService.sanitizeInput(_emailController.text.trim()),
          _passwordController.text,
        );
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
      } catch (e) {
        if (!mounted) return;
        setState(() {
          _isLoading = false;
          _error = e.toString().replaceFirst('Exception: ', '');
        });
      }
    }
  }

  Future<void> _loginWithBiometrics() async {
    try {
      final bool canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final bool canAuthenticate = canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();
      
      if (canAuthenticate) {
        final bool didAuthenticate = await _localAuth.authenticate(
          localizedReason: 'Authenticate to access your ZimHeritage account',
          options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true),
        );
        
        if (didAuthenticate) {
          setState(() { _isLoading = true; _error = null; });
          final user = await AuthService.login('student@demo.com', '123456');
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
        }
      } else {
        setState(() { _error = 'Biometrics not supported on this device.'; });
      }
    } catch (e) {
      setState(() { _error = 'Biometric authentication failed: $e'; });
    }
  }

  @override
  void dispose() {
    _spinController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
                child: SvgPicture.asset(
                  'assets/images/flag_pattern.svg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    AnimatedBuilder(
                      animation: _spinController,
                      builder: (context, child) {
                        return Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: AppTheme.gold.withValues(alpha: 0.4), width: 2),
                            boxShadow: [
                              BoxShadow(color: AppTheme.gold.withValues(alpha: 0.4), blurRadius: 30),
                              BoxShadow(color: AppTheme.primaryGreen.withValues(alpha: 0.2), blurRadius: 50, spreadRadius: 10),
                            ],
                          ),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(_spinController.value * 2.0 * 3.141592653589793),
                            child: ClipOval(
                              child: Image.asset('assets/images/zim_bird_real.png', fit: BoxFit.cover),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
                      ),
                      child: const Text('In Partnership with the Ministry of Primary and Secondary Education',
                        style: TextStyle(fontSize: 10, color: AppTheme.gold, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('ZimHeritage',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.white, letterSpacing: 1)),
                    const SizedBox(height: 4),
                    const Text('National Education Infrastructure',
                      style: TextStyle(fontSize: 13, color: AppTheme.gold, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    const Text('Secure Login Portal',
                      style: TextStyle(fontSize: 13, color: AppTheme.white50)),
                    const SizedBox(height: 32),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppTheme.white.withValues(alpha: 0.10),
                                  AppTheme.white.withValues(alpha: 0.04),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: AppTheme.white20, width: 1),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  DropdownButtonFormField<String>(
                                    initialValue: _selectedCurriculum,
                                    decoration: const InputDecoration(
                                      labelText: 'Curriculum Pathway',
                                      prefixIcon: Icon(Icons.menu_book),
                                    ),
                                    dropdownColor: AppTheme.surfaceDark,
                                    style: const TextStyle(color: AppTheme.white, fontSize: 13),
                                    items: _curricula.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCurriculum = newValue!;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email_outlined),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (v) => (v == null || v.isEmpty) ? 'Enter your email' : null,
                                  ),
                                  const SizedBox(height: 16),
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
                                    validator: (v) => (v == null || v.isEmpty) ? 'Enter your password' : null,
                                  ),
                                  const SizedBox(height: 8),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
                                      child: const Text('Forgot Password?',
                                        style: TextStyle(color: AppTheme.gold, fontSize: 13)),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (_error != null)
                                    Container(
                                      width: double.infinity, padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppTheme.red.withValues(alpha: 0.15),
                                        border: Border.all(color: AppTheme.red.withValues(alpha: 0.3)),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(_error!, style: const TextStyle(color: AppTheme.redBright, fontSize: 13)),
                                    ),
                                  if (_error != null) const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity, height: 50,
                                    child: _isLoading
                                        ? const Center(child: CircularProgressIndicator(color: AppTheme.gold))
                                        : ElevatedButton(
                                            onPressed: _login,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppTheme.primaryGreen,
                                              foregroundColor: AppTheme.white,
                                              side: const BorderSide(color: AppTheme.greenBright, width: 1),
                                            ),
                                            child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                          ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity, height: 50,
                                    child: OutlinedButton.icon(
                                      onPressed: () async {
                                        setState(() { _isLoading = true; _error = null; });
                                        try {
                                          await launchUrl(Uri.parse('https://accounts.google.com/signup'), mode: LaunchMode.externalApplication);
                                        } catch (_) {}
                                        try {
                                          final user = await AuthService.signInWithGoogle();
                                          if (!context.mounted) return;
                                          Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
                                        } catch (e) {
                                          if (!context.mounted) return;
                                          setState(() {
                                            _isLoading = false;
                                            _error = e.toString().replaceFirst('Exception: ', '');
                                          });
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
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity, height: 50,
                                    child: OutlinedButton.icon(
                                      onPressed: _loginWithBiometrics,
                                      icon: const Icon(Icons.fingerprint, size: 28),
                                      label: const Text('Login with Face ID / Fingerprint'),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        side: const BorderSide(color: AppTheme.white50),
                                        foregroundColor: AppTheme.white80,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton.icon(
                                      onPressed: () => Navigator.pushNamed(context, '/register'),
                                      icon: const Icon(Icons.person_add_outlined),
                                      label: const Text('Create New Account'),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        side: const BorderSide(color: AppTheme.gold),
                                        foregroundColor: AppTheme.gold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () async {
                                        setState(() { _isLoading = true; _error = null; });
                                        try {
                                          final user = await AuthService.login('student@demo.com', '123456');
                                          if (!context.mounted) return;
                                          Navigator.pushReplacementNamed(context, '/dashboard', arguments: user);
                                        } catch (e) {
                                          if (!context.mounted) return;
                                          setState(() {
                                            _isLoading = false;
                                            _error = e.toString().replaceFirst('Exception: ', '');
                                          });
                                        }
                                      },
                                      icon: const Icon(Icons.play_circle_fill),
                                      label: const Text('Demo Login (Student)'),
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                        backgroundColor: AppTheme.gold.withValues(alpha: 0.2),
                                        foregroundColor: AppTheme.gold,
                                        side: const BorderSide(color: AppTheme.gold, width: 1),
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
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class ParentDashboard extends StatefulWidget {
  final models.User user;
  const ParentDashboard({super.key, required this.user});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  List<models.User> _children = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  Future<void> _loadChildren() async {
    final allUsers = await UserRepository.getAllUsers();
    final students = allUsers.where((u) => u.role == 'student').toList();
    if (mounted) {
      setState(() {
        _children = students;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parent Portal'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset('assets/images/zim_flag_real.png', height: 20, width: 30, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: CircleAvatar(
              backgroundColor: AppTheme.gold.withValues(alpha: 0.2),
              child: Text(widget.user.name[0], style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            tooltip: 'Logout',
            onPressed: () async {
              await AuthService.logout();
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassCard(
              padding: const EdgeInsets.all(24),
              borderColor: AppTheme.gold.withValues(alpha: 0.2),
              boxShadow: AppTheme.goldGlow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
                        ),
                        child: const Icon(Icons.family_restroom, color: AppTheme.gold, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome, ${widget.user.name.split(' ').first}',
                              style: const TextStyle(color: AppTheme.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            const Text('Track your children\'s educational journey',
                              style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const FlagBar(height: 3),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(20),
              borderColor: AppTheme.greenBright.withValues(alpha: 0.3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.smart_toy_outlined, color: AppTheme.greenBright),
                      SizedBox(width: 8),
                      Text('Smart Learning Advisor', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (_children.isNotEmpty)
                    Text('AI Analysis: ${_children.first.name.split(' ').first} excels in Heritage Studies and Science. We recommend focusing on practical experiments and folk literature.',
                      style: const TextStyle(color: AppTheme.white70, fontSize: 13, height: 1.4)),
                  if (_children.isEmpty)
                    const Text('Link a child to receive personalized AI learning paths and subject strength analysis.',
                      style: TextStyle(color: AppTheme.white70, fontSize: 13, height: 1.4)),
                  const SizedBox(height: 12),
                  if (_children.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.greenBright.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.trending_up, color: AppTheme.greenBright, size: 20),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text('Recommended: Advanced Ngano (Folk Tales) module.',
                              style: TextStyle(color: AppTheme.greenBright, fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('My Children',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.white)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.greenBright.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
                  ),
                  child: Text('${_children.length} enrolled', style: const TextStyle(fontSize: 12, color: AppTheme.greenBright, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_children.isEmpty)
              const GlassCard(
                padding: EdgeInsets.all(20),
                child: Text('No children linked to your account yet.',
                  style: TextStyle(color: AppTheme.white60)),
              )
            else
              ..._children.map((child) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildChildCard(context, child),
              )),
            const SizedBox(height: 24),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.notifications, color: AppTheme.gold, size: 20),
                      SizedBox(width: 8),
                      Text('School Updates',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildUpdateItem(Icons.assignment, 'Homework pending for Chipo', 'Due in 2 days', Colors.orange),
                  const Divider(height: 20),
                  _buildUpdateItem(Icons.check_circle, 'Tendai\'s homework reviewed', 'Score: 10/11', Colors.green),
                  const Divider(height: 20),
                  _buildUpdateItem(Icons.event, 'Parent-Teacher meeting', 'Next term', Colors.blue),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildCard(BuildContext context, models.User child) {
    final IconData icon = child.gradeLevel.startsWith('ECD') ? Icons.auto_awesome :
        ['Grade 1', 'Grade 2', 'Grade 3', 'Grade 4', 'Grade 5', 'Grade 6', 'Grade 7'].contains(child.gradeLevel)
            ? Icons.book : Icons.school;
    final Color color = child.gradeLevel.startsWith('ECD') ? Colors.orange :
        child.gradeLevel.startsWith('Grade') ? Colors.blue : Colors.purple;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ParentChildDetailScreen(child: child),
          ),
        );
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(child.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.white)),
                const SizedBox(height: 4),
                Text('Grade ${child.gradeLevel}', style: const TextStyle(color: AppTheme.white60, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppTheme.gold.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.visibility, size: 14, color: AppTheme.gold),
                SizedBox(width: 4),
                Text('View', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.gold),),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateItem(IconData icon, String title, String subtitle, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppTheme.white80)),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
            ],
          ),
        ),
      ],
    );
  }
}

class AdminDashboard extends StatefulWidget {
  final models.User user;
  const AdminDashboard({super.key, required this.user});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _totalStudents = 0;
  int _totalHomeworks = 0;
  int _totalSubmissions = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadMetrics();
  }

  Future<void> _loadMetrics() async {
    try {
      final students = await UserRepository.getUserCount();
      final homeworks = await HomeworkRepository.getHomeworkCount();
      final submissions = await SubmissionRepository.getSubmissionCount();
      if (mounted) {
        setState(() {
          _totalStudents = students;
          _totalHomeworks = homeworks;
          _totalSubmissions = submissions;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalLevels = getGradeLevels().length;
    final totalSubjects = getAllSubjects().length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Console'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppTheme.surfaceDark, AppTheme.surfaceMid],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: CircleAvatar(
              backgroundColor: AppTheme.gold.withValues(alpha: 0.2),
              child: Text(widget.user.name[0], style: const TextStyle(color: AppTheme.gold, fontWeight: FontWeight.bold)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, size: 20),
            tooltip: 'Logout',
            onPressed: () async {
              await AuthService.logout();
              if (!context.mounted) return;
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassCard(
              padding: const EdgeInsets.all(24),
              borderColor: AppTheme.gold.withValues(alpha: 0.2),
              boxShadow: AppTheme.goldGlow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppTheme.gold.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppTheme.gold.withValues(alpha: 0.2)),
                        ),
                        child: const Icon(Icons.admin_panel_settings, color: AppTheme.gold, size: 28),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.user.name,
                            style: const TextStyle(color: AppTheme.white, fontSize: 20, fontWeight: FontWeight.bold)),
                          const Text('Platform Administrator',
                            style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const FlagBar(height: 3),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Grade Levels', '$totalLevels', Icons.school, Colors.blue, 'curriculum')),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricCard('Subjects', '$totalSubjects', Icons.book, AppTheme.greenBright, 'total')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Students', '$_totalStudents', Icons.people, Colors.orange, 'enrolled')),
                const SizedBox(width: 12),
                Expanded(child: _buildMetricCard('Homeworks', '$_totalHomeworks', Icons.assignment, Colors.purple, 'created')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildMetricCard('Submissions', '$_totalSubmissions', Icons.rate_review, Colors.cyan, 'total')),
              ],
            ),
            const SizedBox(height: 24),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.settings, color: AppTheme.gold, size: 20),
                      SizedBox(width: 8),
                      Text('Admin Actions',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildAdminAction(context, Icons.dashboard, 'National Command Centre', Colors.amber, () {
                    Navigator.pushNamed(context, '/national-dashboard');
                  }),
                  const SizedBox(height: 8),
                  _buildAdminAction(context, Icons.analytics, 'Ministry Intelligence Dashboard', const Color(0xFFFFC72C), () {
                    Navigator.pushNamed(context, '/ministry-dashboard');
                  }),
                  const SizedBox(height: 8),
                  _buildAdminAction(context, Icons.map_outlined, 'Zimbabwe Education Map', Colors.teal, () {
                    Navigator.pushNamed(context, '/zimbabwe-map');
                  }),
                  const SizedBox(height: 8),
                  _buildAdminAction(context, Icons.people, 'User Management', Colors.blue, () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminUserManagementScreen()));
                  }),
                  const SizedBox(height: 8),
                  _buildAdminAction(context, Icons.leaderboard, 'National Leaderboard', Colors.orange, () {
                    Navigator.pushNamed(context, '/leaderboard');
                  }),
                  const SizedBox(height: 8),
                  _buildAdminAction(context, Icons.calendar_month, 'School Calendar', Colors.indigo, () {
                    Navigator.pushNamed(context, '/calendar');
                  }),
                  const SizedBox(height: 8),
                  _buildAdminAction(context, Icons.chat, 'Messages', Colors.cyan, () {
                    Navigator.pushNamed(context, '/messages', arguments: widget.user);
                  }),
                  const SizedBox(height: 8),
                  _buildAdminAction(context, Icons.landscape, 'Heritage Preservation', Colors.purple, () {
                    Navigator.pushNamed(context, '/heritage');
                  }),
                  const SizedBox(height: 8),
                  _buildAdminAction(context, Icons.flag, 'Challenges & Rewards', Colors.deepOrange, () {
                    Navigator.pushNamed(context, '/challenges');
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.account_tree, color: AppTheme.gold, size: 20),
                      SizedBox(width: 8),
                      Text('Curriculum Overview',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.white)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ...getGradeLevels().map((level) => _buildGradeItem(level)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminAction(BuildContext context, IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: AppTheme.white, fontWeight: FontWeight.w500)),
            const Spacer(),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color, String sub) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderColor: color.withValues(alpha: 0.2),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
          Text(label, style: const TextStyle(color: AppTheme.white60, fontSize: 12)),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(sub, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeItem(String level) {
    final subjects = getSubjectsForGrade(level);
    final cambridgeSubjects = getCambridgeSubjectsForGrade(level);
    String badge;
    Color badgeColor;
    if (level.startsWith('ECD')) { badge = 'ECD'; badgeColor = Colors.orange; }
    else if (level.startsWith('Grade')) { badge = 'PRI'; badgeColor = Colors.blue; }
    else if (['Form 1', 'Form 2', 'Form 3', 'Form 4'].contains(level)) { badge = 'O'; badgeColor = Colors.purple; }
    else { badge = 'A'; badgeColor = Colors.teal; }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: badgeColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: badgeColor.withValues(alpha: 0.2)),
            ),
            child: Center(
              child: Text(badge, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: badgeColor)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(level, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppTheme.white)),
                Text('ZIMSEC: ${subjects.length} | Cambridge: ${cambridgeSubjects.length}', style: const TextStyle(fontSize: 11, color: AppTheme.white50)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.greenBright.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
            ),
            child: const Text('Active', style: TextStyle(fontSize: 10, color: AppTheme.greenBright, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
