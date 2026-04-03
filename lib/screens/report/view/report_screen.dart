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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    Text(
                      "نوع البلاغ *",
                      style: sectionTitleStyle.copyWith(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const CategoryGrid(),
                    const SizedBox(height: 30),
                    Text(
                      "الأولوية *",
                      style: sectionTitleStyle.copyWith(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const PrioritySelector(),
                    const SizedBox(height: 30),
                    Text(
                      "الموقع *",
                      style: sectionTitleStyle.copyWith(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const LocationCard(),
                    const SizedBox(height: 30),
                    Text(
                      "الصورة (اختياري)",
                      style: sectionTitleStyle.copyWith(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const ImagePickerWidget(),
                    const SizedBox(height: 30),
                    Text(
                      "ملاحظات إضافية",
                      style: sectionTitleStyle.copyWith(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 15),
                    _buildDescriptionField(),
                    const SizedBox(height: 35),
                    const PointsInfo(),
                    const SizedBox(height: 35),
                    _buildSubmitButton(context),
                    const SizedBox(height: 100),
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
      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
      decoration: InputDecoration(
        hintText: "صف المشكلة بدقة لمساعدة الفريق الميداني...",
        hintStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
    );
  }


 Widget _buildSubmitButton(BuildContext context) {
  final reportVM = context.watch<ReportViewModel>();

  return ElevatedButton(
    // في حال ضغط الزر يصير تحميل عشان مايضغط اكثر من مره ويعلق
     onPressed: reportVM.isUploading 
        ? null 
        : () {
          // الدالة المسؤولة عن ارسال البلاغات للسيرفر 
            reportVM.sendNewReport(
              context, 
              "بلاغ جديد ", //هنا عدلي واضيفي textField  عشان يدخل العنوان 
              _descriptionController.text,
            //  هنا ارسلنا البيانات النصية كبرامتر بينما بقية البيانات زي الموقع والصورة والنوع هي مخزنة مسبقا داخل الفيو مودل كحالة 

            );
          },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF27ae60),
        disabledBackgroundColor: const Color(0xFF27ae60).withOpacity(0.6), // لون باهت عند التحميل
        minimumSize: const Size(double.infinity, 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      //اظهار علامة تحميل 
      child: reportVM.isUploading
        ? const SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          )
   
           : const Text(
          "إرسال البلاغ للصندوق",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
  );
}}