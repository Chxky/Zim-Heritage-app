import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final double blurIntensity;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.borderColor,
    this.boxShadow,
    this.gradient,
    this.onTap,
    this.blurIntensity = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurIntensity, sigmaY: blurIntensity),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: gradient ?? AppTheme.cardGradient,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? AppTheme.white15,
                width: 1,
              ),
              boxShadow: boxShadow,
            ),
            child: onTap != null
                ? Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: child,
                    ),
                  )
                : child,
          ),
        ),
      ),
    );
  }
}

class GlassCardAlt extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? accentColor;

  const GlassCardAlt({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (accentColor ?? AppTheme.primaryGreen).withValues(alpha: 0.12),
            (accentColor ?? AppTheme.primaryGreen).withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: (accentColor ?? AppTheme.primaryGreen).withValues(alpha: 0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (accentColor ?? AppTheme.primaryGreen).withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );
  }
}

class FlagBar extends StatelessWidget {
  final double height;

  const FlagBar({super.key, this.height = 3});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: const BoxDecoration(
        gradient: AppTheme.flagBarGradient,
      ),
    );
  }
}

class GlowingNumber extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  final double fontSize;

  const GlowingNumber({
    super.key,
    required this.value,
    required this.label,
    this.color = AppTheme.greenBright,
    this.fontSize = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: color,
            shadows: [
              Shadow(
                color: color.withValues(alpha: 0.4),
                blurRadius: 20,
              ),
            ],
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppTheme.white60,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
