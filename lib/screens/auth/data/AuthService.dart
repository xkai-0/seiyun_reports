import 'package:dio/dio.dart';
import 'package:seiyun_reports_app/core/network/api_service.dart';

//هذا الملف هو اللي نكتب فيه الروابط  اللي  في لارفل
class AuthService {
  final ApiService _apiService;

  AuthService(this._apiService);

  Future<Response> createUser({
    required String firebaseToken,
    required String role,
    required String name,
  }) async {
    return await _apiService.post(
      '/createUser',
      data: {'idToken': firebaseToken, 'role': role, 'name': name},
    );
  }
}
