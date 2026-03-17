class NewsModel {
  final int id;
  final int adminId;
  final String title;
  final String content;
  final String? image;
  final int isActive;
  final String type; // 'news' أو 'tips'
  final String category;
  final String publishDate;
  final String createdAt;

  NewsModel({
    required this.id,
    required this.adminId,
    required this.title,
    required this.content,
    this.image,
    required this.isActive,
    required this.type,
    required this.category,
    required this.publishDate,
    required this.createdAt,
  });

  // تحويل الـ JSON القادم من Laravel (Postman) إلى كائن Dart
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    // 1. استخراج اسم الصورة من البيانات القادمة من السيرفر
  String imageName = json['image'] ?? "";
  
  // 2. تجهيز متغير للرابط الكامل
  String imageUrl = imageName.isNotEmpty 
      ? "https://medicalhouse-ye.net/uploads/EnvironmentalTip/main/$imageName"
      : "https://via.placeholder.com/150";
   
  
    return NewsModel(
      id: json['id'] ?? 0,
      adminId: json['admin_id'] ?? 0,
      title: json['title'] ?? 'بدون عنوان',
      content: json['content'] ?? '',
      image: imageUrl,
      isActive: json['is_active'] ?? 0,
      type: json['type'] ?? 'news',
      category: json['category'] ?? 'عام',
      publishDate: json['publish_date'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  // تحويل الكائن إلى Map (نحتاجه إذا أردنا حفظ البيانات في SQLite للمواطن)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'admin_id': adminId,
      'title': title,
      'content': content,
      'image': image,
      'is_active': isActive,
      'type': type,
      'category': category,
      'publish_date': publishDate,
      'created_at': createdAt,
    };
  }
}