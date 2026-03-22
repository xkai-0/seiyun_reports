import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../data/report_repository.dart';
import 'package:seiyun_reports_app/core/network/api_service.dart';
import 'package:seiyun_reports_app/core/network/dio_client.dart';
import '../data/report_service.dart';
import '../data/report_repository.dart';

class ReportViewModel extends ChangeNotifier {
final ReportRepository _repository = ReportRepository(
    ReportService(ApiService(DioClient()))
  );  



  String _selectedCategory = 'نفايات';
  String get selectedCategory => _selectedCategory;

  String _selectedPriority = 'مرتفعة';
  String get selectedPriority => _selectedPriority;

  File? _image;
  File? get image => _image;

  String _locationStatus = "سيئون ، حي الوحدة";
  String get locationStatus => _locationStatus;

  bool _isLoadingLocation = false;
  bool get isLoadingLocation => _isLoadingLocation;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setPriority(String priority) {
    _selectedPriority = priority;
    notifyListeners();
  }

  void removeImage() {
    _image = null;
    notifyListeners();
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? photo = await picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (photo != null) {
        _image = File(photo.path);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> getCurrentLocation() async {
    _isLoadingLocation = true;
    notifyListeners();

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
       
        _locationStatus =
            "إحداثيات: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
      } else {
        _locationStatus = "تعذر الحصول على الصلاحية";
      }
    } catch (e) {
      debugPrint("Error location: $e");
      _locationStatus = "خطأ في جلب الموقع";
    }

    _isLoadingLocation = false;
    notifyListeners();
  }
}
