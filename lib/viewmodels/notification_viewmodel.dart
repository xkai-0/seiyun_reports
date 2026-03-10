import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationViewModel extends ChangeNotifier {
  String? _token;
  String? get token => _token;

  RemoteMessage? _lastMessage;
  RemoteMessage? get lastMessage => _lastMessage;

  bool _isSending = false;
  bool get isSending => _isSending;

  NotificationViewModel() {
    _initFCM();
    _listenToMessages();
  }

  Future<void> _initFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint("إذن الإشعارات: ${settings.authorizationStatus}");

    try {
      String? fcmToken = await messaging.getToken();
      if (fcmToken != null) {
        _token = fcmToken;
        notifyListeners();
        
        debugPrint("FCM Token: $_token");
        await _sendTokenToServer(fcmToken);
      }
    } catch (e) {
      debugPrint("خطأ في جلب التوكن: $e");
    }
  }

  void _listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("رسالة جديدة: ${message.notification?.title}");
      _lastMessage = message;
      notifyListeners();
    });
  }

  Future<void> _sendTokenToServer(String fcmToken) async {
    _isSending = true;
    notifyListeners();
    
    try {
      final response = await http.post(
        Uri.parse("https://60e573cbec47e8.lhr.life/api/update-fcm-token"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode({
          "fcm_token": fcmToken,
          "idToken": "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFjMzIxOTgzNGRhNTBlMjBmYWVhZWE3Yzg2Y2U3YjU1MzhmMTdiZTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcmVwb3J0cy1hcHAtZGMwNDYiLCJhdWQiOiJyZXBvcnRzLWFwcC1kYzA0NiIsImF1dGhfdGltZSI6MTc2OTQ1ODE5NSwidXNlcl9pZCI6IlJ3cG1Qb3ZQdHpSU1Jhc25CQ2ZMcU5WOTFxdjIiLCJzdWIiOiJSd3BtUG92UHR6UlNSYXNuQkNmTHFOVjkxcXYyIiwiaWF0IjoxNzY5NDU4MTk1LCJleHAiOjE3Njk0NjE3OTUsImVtYWlsIjoiYXNvam9icmFuM0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsiYXNvam9icmFuM0BnbWFpbC5jb20iXX0sInNpZ25faW5fcHJvdmlkZXIiOiJwYXNzd29yZCJ9fQ.Biiqzul_GPgu4xc8JKyY7LrmFCfhMmcaKX2zmlrGblMc9qsxaHucKw54J8DaBLViROfgwsIGENW26A9HJAldWZ27UDYEUJudN4nkUif7PC59_-NZ-SMdZWiCwUq5Jd6YaC8Ej5PqS_HERXluUkqSxn7M5hUtXxaYRw6QaQeNm6EmdK4HrYhntjHvN8PpMllmZmf2HjqI8ALiaj1aXTYfiX5EcvNeNimlzEgE_qDLGbvKOKilye9aKRbUinnXyjEZyJ3v_Z4OL_QqTboRRoah5s0wDOqIMynb3eNUClra9hWaYA5JbmMcX-ItzxeKUWaKWCgc9StfLz3b3C1gcIDSMg", 
        }),
      );

      debugPrint("رد السيرفر: ${response.body}");
    } catch (e) {
      debugPrint("خطأ في الاتصال بالسيرفر: $e");
    }
    
    _isSending = false;
    notifyListeners();
  }
}
