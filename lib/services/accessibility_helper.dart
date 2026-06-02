import 'package:flutter/material.dart';

class AccessibilityHelper {
  static Semantics label(String label, {String? hint}) {
    return Semantics(
      label: label,
      hint: hint,
      child: const SizedBox.shrink(),
    );
  }

  static Widget wrapButton(Widget child, {required String label, String? hint}) {
    return Semantics(
      label: label,
      hint: hint,
      button: true,
      child: child,
    );
  }

  static Widget wrapImage(Widget child, {required String label}) {
    return Semantics(
      label: label,
      image: true,
      child: child,
    );
  }

  static Widget wrapHeader(Widget child, {required String label}) {
    return Semantics(
      label: label,
      header: true,
      child: child,
    );
  }

  static Widget wrapTextField(Widget child, {required String label, String? hint}) {
    return Semantics(
      label: label,
      hint: hint,
      textField: true,
      child: child,
    );
  }

  static void announce(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 3)),
    );
  }
}
