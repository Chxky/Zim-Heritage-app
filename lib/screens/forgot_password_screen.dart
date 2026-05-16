import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _sent = false;
  String? _error;

  Future<void> _sendReset() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; _error = null; });

    try {
      await AuthService.sendPasswordReset(_emailController.text.trim());
      if (!mounted) return;
      setState(() { _sent = true; _isLoading = false; });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppTheme.splashGradient),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                // Back button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, color: AppTheme.white),
                  ),
                ),
                const SizedBox(height: 20),
                // Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.gold.withValues(alpha: 0.15),
                    border: Border.all(color: AppTheme.gold.withValues(alpha: 0.3), width: 2),
                    boxShadow: [BoxShadow(color: AppTheme.gold.withValues(alpha: 0.2), blurRadius: 30)],
                  ),
                  child: const Icon(Icons.lock_reset, color: AppTheme.gold, size: 48),
                ),
                const SizedBox(height: 24),
                const Text('Reset Password',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.white)),
                const SizedBox(height: 8),
                Text(
                  _sent
                      ? 'Check your email for a reset link'
                      : 'Enter your email to receive a password reset link',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppTheme.white60, fontSize: 14),
                ),
                const SizedBox(height: 32),

                if (_sent) ...[
                  // Success state
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppTheme.greenBright.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTheme.greenBright.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.mark_email_read, color: AppTheme.greenBright, size: 48),
                        const SizedBox(height: 16),
                        Text('Email sent to\n${_emailController.text.trim()}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppTheme.white, fontSize: 16, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        const Text('Follow the instructions in the email to reset your password.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppTheme.white60, fontSize: 13)),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Back to Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // Form state
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email Address',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Enter your email';
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        if (_error != null) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppTheme.red.withValues(alpha: 0.15),
                              border: Border.all(color: AppTheme.red.withValues(alpha: 0.3)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(_error!,
                              style: const TextStyle(color: AppTheme.redBright, fontSize: 13)),
                          ),
                          const SizedBox(height: 16),
                        ],

                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: _isLoading
                              ? const Center(child: CircularProgressIndicator(color: AppTheme.gold))
                              : ElevatedButton.icon(
                                  onPressed: _sendReset,
                                  icon: const Icon(Icons.send),
                                  label: const Text('Send Reset Link',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('← Back to Login',
                            style: TextStyle(color: AppTheme.white60)),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
