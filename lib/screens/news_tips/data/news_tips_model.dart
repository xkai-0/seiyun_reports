class NewsModel {
  final int id;
  final int adminId;
  final String title;
  final String content;
  final String? image;
  final int isActive;
  final String type;
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

  factory NewsModel.fromJson(Map<String, dynamic> json) {
  
    return NewsModel(
      id: json['id'] ?? 0,
      adminId: json['admin_id'] ?? 0,
      title: json['title'] ?? 'بدون عنوان',
      content: json['content'] ?? '',
      image: json['image'] != null && json['image'].toString().isNotEmpty 
           ? json['image'].toString() 
           : "https://via.placeholder.com/150",
      isActive: json['is_active'] ?? 0,
      type: json['type'] ?? 'news',
      category: json['category'] ?? 'عام',
      publishDate: json['publish_date'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

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