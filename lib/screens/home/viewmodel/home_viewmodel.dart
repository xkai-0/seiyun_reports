import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;

  HomeViewModel() {
    _fetchUser();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  void _fetchUser() {
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  // Future logic to fetch reports / data from remote APIs will be added here
}
