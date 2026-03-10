import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seiyun_reports_app/screens/report/viewmodel/report_viewmodel.dart';
import 'package:seiyun_reports_app/screens/report/view/widgets/report_header.dart';
import 'package:seiyun_reports_app/screens/report/view/widgets/category_grid.dart';
import 'package:seiyun_reports_app/screens/report/view/widgets/priority_selector.dart';
import 'package:seiyun_reports_app/screens/report/view/widgets/location_card.dart';
import 'package:seiyun_reports_app/screens/report/view/widgets/image_picker_widget.dart';
import 'package:seiyun_reports_app/screens/report/view/widgets/points_info.dart';

const sectionTitleStyle = TextStyle(
  fontSize: 16,
  color: Color(0xFF0f172a),
  fontWeight: FontWeight.bold,
);

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf8f9fa),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ReportHeader(),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("نوع البلاغ *", style: sectionTitleStyle),
                    const SizedBox(height: 15),
                    const CategoryGrid(),
                    const SizedBox(height: 30),
                    const Text("الأولوية *", style: sectionTitleStyle),
                    const SizedBox(height: 15),
                    const PrioritySelector(),
                    const SizedBox(height: 30),
                    const Text("الموقع *", style: sectionTitleStyle),
                    const SizedBox(height: 15),
                    const LocationCard(),
                    const SizedBox(height: 30),
                    const Text("الصورة (اختياري)", style: sectionTitleStyle),
                    const SizedBox(height: 15),
                    const ImagePickerWidget(),
                    const SizedBox(height: 30),
                    const Text("ملاحظات إضافية", style: sectionTitleStyle),
                    const SizedBox(height: 15),
                    _buildDescriptionField(),
                    const SizedBox(height: 35),
                    const PointsInfo(),
                    const SizedBox(height: 35),
                    _buildSubmitButton(context),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextField(
      controller: _descriptionController,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: "صف المشكلة بدقة لمساعدة الفريق الميداني...",
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFe2e8f0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Color(0xFFe2e8f0)),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final reportVM = context.read<ReportViewModel>();

    return ElevatedButton(
      onPressed: () {
        debugPrint(
          "Sending: ${reportVM.selectedCategory}, Location: ${reportVM.locationStatus}, Image: ${reportVM.image?.path}, Description: ${_descriptionController.text}",
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF27ae60),
        minimumSize: const Size(double.infinity, 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Text(
        "إرسال البلاغ للصندوق",
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
