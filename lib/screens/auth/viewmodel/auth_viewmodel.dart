import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:seiyun_reports_app/screens/auth/data/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSignupMode = true;
  bool get isSignupMode => _isSignupMode;

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthRepository _authRepo = AuthRepository();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void toggleSignupMode() {
    _isSignupMode = !_isSignupMode;
    notifyListeners();
  }

  void forceSignInMode() {
    _isSignupMode = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
  }

  Future<bool> handleEmailAuth({
    required String email,
    required String password,
    String? name,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (_isSignupMode) {
        await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );

        if (name != null && name.trim().isNotEmpty) {
          await _auth.currentUser?.updateDisplayName(name.trim());
          await _auth.currentUser?.reload();
        }
      } else {
        await _auth.signInWithEmailAndPassword(
          email: email.trim(),
          password: password.trim(),
        );
      }

      final user = _auth.currentUser;
      if (user != null) {
        final token = await user.getIdToken();
        debugPrint("FIREBASE_TOKEN: $token");

        await _authRepo.registerUser(
          role: 'citizens',
          name:
              (name != null && name.trim().isNotEmpty)
                  ? name.trim()
                  : (user.displayName ?? "User"),
        );
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? "حدث خطأ غير متوقع";
    } catch (e) {
      _errorMessage = "فشل الربط مع الخادم";
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> handleGoogleSignIn() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final finalName =
            user.displayName ??
            (user.email != null ? user.email!.split('@')[0] : "User");

        await _authRepo.registerUser(role: 'citizens', name: finalName);
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _errorMessage = "فشل تسجيل الدخول بواسطة Google";
      debugPrint("Google SignIn Error: $e");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
}
