class CitizenReportModel {
  final int id;
  final String title;
  final String description;
  final String status;
  final int likesCount;
  final int viewsCount;
  final int commentsCount;
  final String report_image; 
  final String? imageAfterProcessing;
  final String created_at;
  final String user_name; 
  final String user_profile; 
  bool isLiked; // سنستخدمها للتعامل مع زر اللايك محلياً

  CitizenReportModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.likesCount,
    required this.viewsCount,
    required this.commentsCount,
    required this.report_image,
    this.imageAfterProcessing,
    required this.created_at,
    required this.user_name,
    required this.user_profile,
    this.isLiked = false,
  });

  factory CitizenReportModel.fromJson(Map<String, dynamic> json) {
    return CitizenReportModel(
      id: json['id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      status: json['status'] ?? "",
      likesCount: json['likes'] ?? 0,
      viewsCount: json['views'] ?? 0,
      commentsCount: json['comments'] ?? 0,
      report_image: json['report_image'] ?? "",
      imageAfterProcessing: json['Image_after_processing'],
      created_at: json['created_at'] ?? "",
      user_name: json['user_name'] ?? "مواطن",
      user_profile: json['user_profile'] ?? "",
    );
  }
   // يمكن اغيرها في حال استخدمت sqlite  خلوها مؤقتا 
  // نحتاج هذه الدالة لتحديث حالة اللايك في الـ ViewModel
  CitizenReportModel copyWith({bool? isLiked, int? likesCount}) {
    return CitizenReportModel(
      id: id,
      title: title,
      description: description,
      status: status,
      likesCount: likesCount ?? this.likesCount,
      viewsCount: viewsCount,
      commentsCount: commentsCount,
      report_image: report_image,
      imageAfterProcessing: imageAfterProcessing,
      created_at: created_at,
      user_name: user_name,
      user_profile: user_profile,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}