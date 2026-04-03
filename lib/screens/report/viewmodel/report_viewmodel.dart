import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seiyun_reports_app/screens/report/data/report_model.dart';
import '../data/report_repository.dart';
class ReportViewModel extends ChangeNotifier {
  final ReportRepository _repository;
  ReportViewModel(this._repository);

  String _selectedCategory = 'نفايات';
  String get selectedCategory => _selectedCategory;

  String _selectedPriority = 'مرتفعة';
  String get selectedPriority => _selectedPriority;

  File? _image;
  File? get image => _image;

  String _locationStatus = "يرجى الضغط لتحديد الموقع";
  String get locationStatus => _locationStatus;

  bool _isLoadingLocation = false;
  bool get isLoadingLocation => _isLoadingLocation;

  void setCategory(String category)  {
     _selectedCategory = category;
      notifyListeners();
       }

  void setPriority(String priority) {
     _selectedPriority = priority;
      notifyListeners() ;
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
         imageQuality: 70
         );
      if (photo != null)
       { _image = File(photo.path); notifyListeners(); }
    } catch (e) { debugPrint("Error picking image: $e"); }
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
        desiredAccuracy: LocationAccuracy.high
        );
      _locationStatus = "إحداثيات: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}";
    }
    else {
        _locationStatus = "تعذر الحصول على الصلاحية";
      }}
       catch (e) {
         debugPrint("Error location: $e");
        _locationStatus = "خطأ في جلب الموقع";
      }
    _isLoadingLocation = false;
    notifyListeners();
  }

  
  List<ReportModel> _reportsList = []; 
  List<ReportModel> get reportsList => _reportsList;

  bool _isLoadingReports = false; // حالة تحميل القائمة
  bool get isLoadingReports => _isLoadingReports;

  bool _isUploading = false; // حالة تحميل الزر عند الإرسال
  bool get isUploading => _isUploading;

  //  دالة جلب البلاغات المستخدم  من قاعدة البيانات
  Future<void> fetchReportsFromLaravel() async {
    _isLoadingReports = true;
    notifyListeners();
    try {
      _reportsList = await _repository.fetchMyReports();//ياخذ البيانات من الريبوزتري 
    } catch (e) {
      debugPrint("خطأ في جلب البلاغات: $e");
    } finally {
      _isLoadingReports = false;
      notifyListeners();
    } 
  }

  // دالة ارسال البلاغ 
  Future<void> sendNewReport(BuildContext context,String title, String description) async {
    //تحقق من وجود صورة
    if (_image == null) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("الرجاء إرفاق صورة"), backgroundColor: Colors.orange));
    return;
  }

  //  تحقق من العنوان والوصف
  if (title.isEmpty || description.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("الرجاء كتابة العنوان والوصف"), backgroundColor: Colors.orange));
    return;
  }
    
    _isUploading = true;
    notifyListeners();
   // قيم افتراضية للاحداثيات 
    String lat = "0.0";  
    String lng = "0.0";
  //هذا لضمان ارسال بيانات الاحداثيات صحيحة يقبلها السيرفر
    if (_locationStatus.contains(":") && _locationStatus.contains(",")) {
  try {
   //تقص النص عشان ناخذ الارقام ونخزنها في المتغيرات 
    var parts = _locationStatus.split(":")[1].split(",");
    lat = parts[0].trim();
    lng = parts[1].trim();
  } catch (e) {
    debugPrint("خطأ في تحليل النص: $e");
  }
  //نستدعي الريبو عشان نرسل البيانات الى السيرفر 
    bool success = await _repository.sendNewReport(
      title: title,
      description: description,
      type: _selectedCategory,
      priority: _selectedPriority,
      lat: lat,
      lng: lng,
      imageFile: _image!,
    );

    _isUploading = false;
    notifyListeners();
  // في حال نجح ارسال البلاغ نستدعي دالة جلب البلاغات لاجل ان تتحدث قائمة بلاغاتي ويوضع فيها البلاغ الجديد
    if (success) {
      fetchReportsFromLaravel();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم الإرسال بنجاح"), backgroundColor: Colors.green));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("فشل الإرسال"), backgroundColor: Colors.red));
    }
  }
  }
}