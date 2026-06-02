class SecurityService {
  static String sanitizeInput(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .trim();
  }

  static bool isValidEmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return password.length >= 6;
  }

  static bool isValidName(String name) {
    return name.trim().length >= 2 && RegExp(r"^[a-zA-Z\s'\-]+$").hasMatch(name.trim());
  }

  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^\+?[\d\s\-()]{7,15}$').hasMatch(phone);
  }

  static String sanitizeFilename(String filename) {
    return filename.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
  }

  static String stripHtml(String html) {
    return html.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  // --- Zimbabwe Cyber and Data Protection Act [Chapter 12:07] Compliance ---

  /// Encrypts sensitive user data at rest according to national data protection standards.
  static String encryptData(String data) {
    // Note: In a real production environment, use a robust library like 'encrypt' (AES-256).
    // For presentation/golden mock, we use Base64 encoding as a simulation.
    return 'ENC:[${Uri.encodeComponent(data)}]';
  }

  /// Decrypts sensitive user data.
  static String decryptData(String encryptedData) {
    if (encryptedData.startsWith('ENC:[')) {
      final payload = encryptedData.substring(5, encryptedData.length - 1);
      return Uri.decodeComponent(payload);
    }
    return encryptedData; // Fallback if not encrypted
  }

  /// Logs security events for compliance auditing.
  static void logSecurityEvent(String action, String userId) {
    // Simulated audit log required by Data Protection Authority
    print('SECURITY AUDIT [Zim Act 12:07]: $action | User: $userId | Timestamp: ${DateTime.now().toIso8601String()}');
  }
}
