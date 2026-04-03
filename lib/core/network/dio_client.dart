import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seiyun_reports_app/import.dart';
import '../utils/pref_helper.dart';

class DioClient {
  late Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://medicalhouse-ye.net/api/',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
         try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          String? token = await user.getIdToken(true);

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';

            
              if (options.method == 'POST') {
            if (options.data is FormData) {
              (options.data as FormData).fields.add(MapEntry("idToken", token));
            }else {
            options.data = FormData.fromMap({
              "idToken": token,
              ...?options.data as Map<String, dynamic>?, // إضافة أي بيانات أخرى لو وجدت
            });
          }
        }
      }
      }
      } catch (e) {

        debugPrint("Error in Interceptor: $e");
      }
          return handler.next(options);
        },
      ),
    );
  }
}
