class NotificationModel {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isRead;
  final bool? isSeen;
  final String? icon;
  final String? type;
  final String? title;
  final String? url;
  final int? userId;

  NotificationModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isRead,
    this.isSeen,
    this.icon,
    this.type,
    this.title,
    this.url,
    this.userId,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      isRead: map['is_read'],
      isSeen: map['is_seen'],
      icon: map['icon'],
      type: map['type'],
      title: map['title'],
      url: map['url'],
      userId: map['user_id'],
    );
  }
}
