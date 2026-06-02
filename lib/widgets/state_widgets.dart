import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class LoadingState extends StatelessWidget {
  final String? message;
  final Color? color;

  const LoadingState({super.key, this.message, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color ?? AppTheme.gold),
            strokeWidth: 3,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Semantics(
              label: message,
              child: Text(message!, style: const TextStyle(color: AppTheme.white60, fontSize: 14)),
            ),
          ],
        ],
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final IconData icon;

  const ErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              label: 'Error',
              child: Icon(icon, size: 64, color: AppTheme.redBright.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: 16),
            Semantics(
              label: message,
              child: Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.white60, fontSize: 15)),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              Semantics(
                label: 'Try Again',
                button: true,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                    foregroundColor: AppTheme.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final String message;
  final String? subtitle;
  final IconData icon;
  final Widget? action;

  const EmptyState({
    super.key,
    required this.message,
    this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Semantics(
              label: 'No data',
              child: Icon(icon, size: 64, color: AppTheme.white30),
            ),
            const SizedBox(height: 16),
            Semantics(
              label: message,
              child: Text(message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.white60, fontSize: 15, fontWeight: FontWeight.w500)),
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(subtitle!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppTheme.white30, fontSize: 13)),
            ],
            if (action != null) ...[
              const SizedBox(height: 20),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
