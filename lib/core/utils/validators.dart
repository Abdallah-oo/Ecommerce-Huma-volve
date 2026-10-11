class Validators {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required field';
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required field';
    final emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Enter a valid email';
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required field';
    if (value.length < 8) return 'Password must be at least 8 characters';
    return null;
  }
}
