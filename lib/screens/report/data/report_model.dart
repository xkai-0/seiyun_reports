class ReportModel {
  final int id;
  final int citizenId;
  final String title;
  final int? areaId;
  final String description;
  final String image;
  final String status;
  final String reportType;
  final String lat;
  final String lng;
  final String createdAt;

  ReportModel({
    required this.id,
    required this.citizenId,
    required this.title,
    this.areaId,
    required this.description,
    required this.image,
    required this.status,
    required this.reportType,
    required this.lat,
    required this.lng,
    required this.createdAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    String imageName = json['image'] ?? "";
    String imageUrl = imageName.isNotEmpty 
      ? "https://medicalhouse-ye.net/uploads/EnvironmentalTip/main/$imageName"
      : "https://via.placeholder.com/150";

    return ReportModel(
      id: json['id'] ?? 0,
      citizenId: json['citizen_id'] ?? 0,
      title: json['title'] ?? 'بلاغ بدون عنوان',
      areaId: json['area_id'],
      description: json['description'] ?? '',
      image: imageUrl, 
      status: json['status'] ?? 'قيد الانتظار',
      reportType: json['report_type'] ?? 'رفع',
      lat: json['lat']?.toString() ?? '0.0',
      lng: json['lng']?.toString() ?? '0.0',
      createdAt: json['created_at'] ?? '',
    );
  }
}