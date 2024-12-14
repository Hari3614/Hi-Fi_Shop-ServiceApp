import 'package:flutter/material.dart';
import 'package:project1/data/repositories/auth_repository.dart';
import 'package:project1/presentation/homescreen/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_helpers.dart'; // Import the helper functions

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _authRepository = AuthRepository();

  bool _isLoading = false;
  String? _errorMessage;

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await _authRepository.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        setState(() {
          _errorMessage = 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceAll('Exception:', '').trim();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildLogo(),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildEmailField(_emailController),
                  const SizedBox(height: 16),
                  buildPasswordField(_passwordController),
                  buildForgotPassword(),
                  buildErrorMessage(_errorMessage),
                  const SizedBox(height: 20),
                  buildLoginButton(_isLoading, _login),
                  const SizedBox(height: 10),
                  buildDividerWithText(),
                  const SizedBox(height: 10),
                  buildGoogleLoginButton(),
                  const SizedBox(height: 20),
                  buildRegisterText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
