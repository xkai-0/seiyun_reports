import 'package:firebase_auth/firebase_auth.dart';
import 'package:seiyun_reports_app/core/utils/pref_helper.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();

  File? _profileImage;
  File? get profileImage => _profileImage;

  bool _notificationsEnabled = true;
  bool get notificationsEnabled => _notificationsEnabled;

  String? _userName;
  String? get userName => _userName;

  String? _userPhone;
  String? get userPhone => _userPhone;

  String? _userAddress;
  String? get userAddress => _userAddress;

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  ProfileViewModel() {
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final String? path = await PrefHelper.getProfileImagePath();
    if (path != null && path.isNotEmpty) {
      final file = File(path);
      if (await file.exists()) {
        _profileImage = file;
      }
    }

    _notificationsEnabled = await PrefHelper.isNotificationsEnabled();
    _userName = await PrefHelper.getUserName();
    _userPhone = await PrefHelper.getUserPhone();
    _userAddress = await PrefHelper.getUserAddress();
    _isDarkMode = await PrefHelper.isDarkMode();

    notifyListeners();
  }

  User? get currentUser => _auth.currentUser;

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
        await PrefHelper.saveProfileImagePath(pickedFile.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    _notificationsEnabled = value;
    await PrefHelper.saveNotificationsEnabled(value);
    notifyListeners();
  }

  Future<void> updateUserName(String name) async {
    _userName = name;
    await PrefHelper.saveUserName(name);
    notifyListeners();
  }

  Future<void> updateUserPhone(String phone) async {
    _userPhone = phone;
    await PrefHelper.saveUserPhone(phone);
    notifyListeners();
  }

  Future<void> updateUserAddress(String address) async {
    _userAddress = address;
    await PrefHelper.saveUserAddress(address);
    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;
    await PrefHelper.saveDarkMode(value);
    notifyListeners();
  }
}
