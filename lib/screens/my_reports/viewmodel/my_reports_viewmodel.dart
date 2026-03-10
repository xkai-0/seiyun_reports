import 'package:flutter/material.dart';
import 'package:seiyun_reports_app/screens/my_reports/data/models/report_model.dart';

class MyReportsViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // هذه القائمة ستُعبأ من الـ API
  // إذا كانت فارغة []، ستظهر واجهة "لا يوجد بلاغات"
  List<ReportModel> reportsList = [
    ReportModel(
      id: "1",
      title: "تراكم القمامة في شارع الجزائر",
      description:
          "كمية كبيرة من القمامة تحجب المشي على الأرصفة وتسبب روائح كريهة.",
      location: "شارع الجزائر، بجانب سوق النساء",
      date: "2025-12-01",
      status: "قيد المعالجة",
      imageUrl:
          "https://images.unsplash.com/photo-1530587191325-3db32d826c18?q=80&w=500",
      category: "تراكم نفايات",
    ),
    ReportModel(
      id: "2",
      title: "رمي عشوائي في الحديقة",
      description: "مخلفات بناء مرمية في وسط الحديقة العامة.",
      location: "حديقة سيئون، البوابة الشمالية",
      date: "2025-12-01",
      status: "جديد",
      imageUrl:
          "https://images.unsplash.com/photo-1611284446314-60a58ac0deb9?q=80&w=500",
      category: "تراكم نفايات",
    ),
  ];

  // دالة وهمية لمحاكاة جلب البيانات
  Future<void> fetchReportsFromLaravel() async {
    _isLoading = true;
    notifyListeners();

    // محاكاة تأخير الشبكة
    await Future.delayed(const Duration(seconds: 2));

    // هنا يتم جلب البيانات وتحديث reportsList
    _isLoading = false;
    notifyListeners();
  }
}
