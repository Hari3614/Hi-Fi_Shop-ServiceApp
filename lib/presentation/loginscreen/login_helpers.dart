import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

Widget buildLogo() {
  return Column(
    children: [
      const SizedBox(height: 50),
      Image.asset(
        'assets/images/login_illustration.png',
        height: 200,
      ),
      const SizedBox(height: 20),
      const Text(
        'Login',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 10),
    ],
  );
}

Widget buildEmailField(TextEditingController emailController) {
  return TextFormField(
    controller: emailController,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.email_outlined),
      labelText: 'Email ID',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );
}

Widget buildPasswordField(TextEditingController passwordController) {
  return TextFormField(
    controller: passwordController,
    decoration: InputDecoration(
      prefixIcon: const Icon(Icons.lock_outline),
      labelText: 'Password',
      suffixIcon: IconButton(
        icon: const Icon(Icons.visibility_off),
        onPressed: () {},
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    obscureText: true,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      return null;
    },
  );
}

Widget buildForgotPassword() {
  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: () {},
      child: const Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.blue),
      ),
    ),
  );
}

Widget buildErrorMessage(String? errorMessage) {
  if (errorMessage != null) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        errorMessage,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
  return SizedBox.shrink();
}

Widget buildLoginButton(bool isLoading, Function onLogin) {
  return isLoading
      ? const Center(child: CircularProgressIndicator())
      : SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => onLogin(),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        );
}

Widget buildDividerWithText() {
  return const Row(
    children: [
      Expanded(child: Divider()),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Text('OR'),
      ),
      Expanded(child: Divider()),
    ],
  );
}

Widget buildGoogleLoginButton() {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(EvaIcons.google),
      label: const Text('Login with Google'),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}

Widget buildRegisterText() {
  return Center(
    child: TextButton(
      onPressed: () {},
      child: RichText(
        text: const TextSpan(
          text: 'New to Logistics? ',
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'Register',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    ),
  );
}
