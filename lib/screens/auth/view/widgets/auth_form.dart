import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiyun_reports_app/screens/home/view/home_screen.dart';
import 'package:seiyun_reports_app/screens/auth/viewmodel/auth_viewmodel.dart';
import 'auth_text_field.dart';
import 'auth_button.dart';
import 'google_signin_button.dart';
import 'package:seiyun_reports_app/core/theme/app_theme.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message, [ScaffoldMessengerState? messenger]) {
    (messenger ?? ScaffoldMessenger.of(context)).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.errorColor,
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  bool _validateInputs(AuthViewModel authVM) {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      _showErrorSnackBar("يرجى إدخال البريد الإلكتروني وكلمة المرور");
      return false;
    }

    if (authVM.isSignupMode && _nameController.text.trim().isEmpty) {
      _showErrorSnackBar("يرجى إدخال الاسم الكامل");
      return false;
    }

    return true;
  }

  Future<void> _handleEmailAuth() async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    if (!_validateInputs(authVM)) return;

    final success = await authVM.handleEmailAuth(
      email: _emailController.text,
      password: _passwordController.text,
      name: authVM.isSignupMode ? _nameController.text : null,
    );

    if (!mounted) return;

    if (success) {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      if (authVM.errorMessage != null) {
        _showErrorSnackBar(authVM.errorMessage!, scaffoldMessenger);
        authVM.clearError();
      }
    }
  }

  Future<void> _handleGoogleSignIn() async {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final success = await authVM.handleGoogleSignIn();

    if (!mounted) return;

    if (success) {
      navigator.pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else {
      if (authVM.errorMessage != null) {
        _showErrorSnackBar(authVM.errorMessage!, scaffoldMessenger);
        authVM.clearError();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const Icon(
            Icons.forest_rounded,
            color: AppTheme.primaryGreen,
            size: 40,
          ),
          const SizedBox(height: 10),
          Text(
            authVM.isSignupMode ? 'Get Started' : 'Welcome Back',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGreen,
            ),
          ),
          const SizedBox(height: 30),
          if (authVM.isSignupMode) ...[
            AuthTextField(
              label: "Full Name",
              hint: "Enter Full Name",
              controller: _nameController,
            ),
            const SizedBox(height: 20),
          ],
          AuthTextField(
            label: "Email",
            hint: "Enter Email",
            controller: _emailController,
          ),
          const SizedBox(height: 20),
          AuthTextField(
            label: "Password",
            hint: "Enter Password",
            controller: _passwordController,
            isPassword: true,
          ),
          const SizedBox(height: 30),
          AuthButton(
            text: authVM.isSignupMode ? 'Sign up' : 'Log in',
            onPressed: _handleEmailAuth,
          ),
          const SizedBox(height: 25),
          GoogleSignInButton(
            text:
                authVM.isSignupMode
                    ? "Sign up with Google"
                    : "Log in with Google",
            onTap: _handleGoogleSignIn,
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                authVM.isSignupMode
                    ? "Already have an account? "
                    : "Don't have an account? ",
              ),
              GestureDetector(
                onTap: () {
                  authVM.toggleSignupMode();
                },
                child: Text(
                  authVM.isSignupMode ? "Log in" : "Sign up",
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
