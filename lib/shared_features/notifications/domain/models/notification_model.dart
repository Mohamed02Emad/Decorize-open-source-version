List<NotificationModel> notificationsFromJson(dynamic json) =>
    List<NotificationModel>.from(
        json.map((x) => NotificationModel.fromJson(x)));

class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String merchantCategory;
  final String serial;
  final int? chatId;
  final String type;
  final int dataId;
  final bool isSeen;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.merchantCategory,
    required this.serial,
    this.chatId,
    required this.type,
    required this.dataId,
    required this.isSeen,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return NotificationModel(
      id: json['id'],
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      merchantCategory: data['merchant_category'] ?? '',
      serial: data['serial'] ?? '',
      chatId: data['chat_id'],
      type: data['type'] ?? '',
      dataId: data['id'] ?? 0,
      isSeen: json['is_seen'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
