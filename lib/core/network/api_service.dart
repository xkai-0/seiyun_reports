import 'package:dio/dio.dart';
import 'dio_client.dart';

class ApiService {
  final Dio _dio;

  ApiService(DioClient dioClient) : _dio = dioClient.dio;

  //  جلب البيانات 
  Future<Response> get(String path, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers, 
  }) async {
    return await _dio.get(
      path, 
      queryParameters: query,
      options: Options(headers: headers), 
    );
  }

  // إرسال بيانات جديدة 
  Future<Response> post(String path, {
    dynamic data, 
    Map<String, dynamic>? headers, 
  }) async {
    return await _dio.post(
      path, 
      data: data, 
      options: Options(headers: headers,
      contentType: data is FormData ? 'multipart/form-data' : 'application/json',
      ), 
    );
  }

  // تعديل بيانات موجودة 
  Future<Response> put(String path, {
    dynamic data, 
    Map<String, dynamic>? headers, 
  }) async {
    return await _dio.put(
      path, 
      data: data, 
      options: Options(headers: headers), 
    );
  }

  //  حذف بيانات 
  Future<Response> delete(String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers, 
  }) async {
    return await _dio.delete(
      path, 
      data: data,
      options: Options(headers: headers), 
    );
  }
}