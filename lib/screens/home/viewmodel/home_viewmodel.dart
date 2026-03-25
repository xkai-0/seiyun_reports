import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/core/services/location_service.dart';

class HomeViewModel extends ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;

  String _currentArea = 'جاري تحديد الموقع...';
  String get currentArea => _currentArea;

  HomeViewModel() {
    _fetchUser();
    _fetchLocation();
    FirebaseAuth.instance.userChanges().listen((User? user) {
      _currentUser = user;
      notifyListeners();
    });
  }

  Future<void> _fetchLocation() async {
    _currentArea = await LocationService.getCurrentAreaName();
    notifyListeners();
  }

  void _fetchUser() {
    _currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setPage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Future logic to fetch reports / data from remote APIs will be added here
}
