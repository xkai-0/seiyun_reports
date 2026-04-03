import 'package:seiyun_reports_app/core/network/dio_client.dart';
import 'package:seiyun_reports_app/core/network/api_service.dart';
import 'AuthService.dart';
import 'package:seiyun_reports_app/core/utils/pref_helper.dart';
import 'user_model.dart';

class AuthRepository {
  late AuthService _authService;

  AuthRepository() {
    final dioClient = DioClient();
    final apiService = ApiService(dioClient);
    _authService = AuthService(apiService);
  }

  Future<UserModel> registerUser({
    required String role,
    required String name,
  }) async {

    final response = await _authService.createUser(
      role: role,
      name: name,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final userModel = UserModel.fromJson(response.data['data']);

      await PrefHelper.saveLoginStatus(true);
      await PrefHelper.saveRole(userModel.role);
      await PrefHelper.saveUserId(userModel.id);
      await PrefHelper.saveUserName(userModel.name);

      return userModel;
    } else {
      throw Exception('Server Error: ${response.data['message']}');
    }
  }
}
