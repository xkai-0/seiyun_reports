import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiyun_reports_app/screens/auth/viewmodel/auth_viewmodel.dart';
import 'package:seiyun_reports_app/core/theme/app_theme.dart';
import 'widgets/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final authVM = Provider.of<AuthViewModel>(context);

    return Scaffold(
      body: Stack(
        children: [
          /// خلفية الشاشة
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.darkGreen, Colors.green],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// زر الرجوع في حالة تسجيل الدخول
          if (!authVM.isSignupMode)
            Positioned(
              top: 50,
              left: 20,
              child: TextButton.icon(
                onPressed: () {
                  authVM.toggleSignupMode();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 18,
                ),
                label: const Text(
                  "Back",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

          /// واجهة الإدخال
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child:
                  authVM.isLoading
                      ? const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.primaryGreen,
                        ),
                      )
                      : const AuthForm(),
            ),
          ),
        ],
      ),
    );
  }
}
