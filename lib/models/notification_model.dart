class NotificationModel {
  String? id;
  int? pkid;
  String? notificationType;
  int? recipient;
  int? author;
  String? title;
  String? message;
  bool? isRead;
  String? createdAt;

  NotificationModel(
      {this.id,
      this.pkid,
      this.notificationType,
      this.recipient,
      this.author,
      this.title,
      this.message,
      this.isRead,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pkid = json['pkid'];
    notificationType = json['notificationType'];
    recipient = json['recipient'];
    author = json['author'];
    title = json['title'];
    message = json['message'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pkid'] = this.pkid;
    data['notificationType'] = this.notificationType;
    data['recipient'] = this.recipient;
    data['author'] = this.author;
    data['title'] = this.title;
    data['message'] = this.message;
    data['is_read'] = this.isRead;
    data['created_at'] = this.createdAt;
    return data;
  }
}
