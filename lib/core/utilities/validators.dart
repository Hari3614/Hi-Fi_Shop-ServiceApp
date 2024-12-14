class Validators {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$');
    return emailRegex.hasMatch(email);
  }

  static bool isValidPrice(String price) {
    return double.tryParse(price) != null;
  }
}
