class ReportModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String date;
  final String status; // 'جديد', 'قيد المعالجة', 'تم الإنجاز'
  final String imageUrl;
  final String category;

  ReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.status,
    required this.imageUrl,
    required this.category,
  });
}
