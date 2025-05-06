import 'package:equatable/equatable.dart';

class NotificationItemModel extends Equatable {
  final String id;
  final String message;
  final bool isRead;
  final String type;

  const NotificationItemModel({
    required this.id,
    required this.message,
    required this.isRead,
    required this.type,
  });

  factory NotificationItemModel.fromJson(Map<String, dynamic> json) {
    return NotificationItemModel(
      id: json['id'] as String,
      message: json['message'] as String,
      isRead: json['isRead'] as bool? ?? false,
      type: json['type'] as String,
    );
  }

  @override
  List<Object?> get props => [id, message, isRead, type];
}