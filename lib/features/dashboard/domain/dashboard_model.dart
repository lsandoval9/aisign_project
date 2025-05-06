import 'package:aisign_project/features/dashboard/domain/notification_item_model.dart';
import 'package:equatable/equatable.dart';

class DashboardDataModel extends Equatable {
  final String userName;
  final String greeting;
  final List<NotificationItemModel> notifications;

  const DashboardDataModel({
    required this.userName,
    required this.greeting,
    required this.notifications,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) {
    return DashboardDataModel(
      userName: json['userName'] as String? ?? 'User',
      greeting: json['greeting'] as String? ?? 'Hello',
      notifications: (json['notifications'] as List<dynamic>? ?? [])
          .map((item) => NotificationItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [userName, greeting, notifications];
}