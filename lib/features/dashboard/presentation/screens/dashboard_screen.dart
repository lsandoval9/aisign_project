import 'package:aisign_project/features/dashboard/domain/dashboard_model.dart';
import 'package:aisign_project/features/dashboard/presentation/providers/dashboard_data_provider.dart';
import 'package:aisign_project/shared/errors/base/failure_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  // Helper to map icon names to IconData
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'edit_document':
        return Icons.edit_document;
      case 'send':
        return Icons.send_outlined;
      case 'file_copy':
        return Icons.file_copy_outlined;
      case 'history':
        return Icons.history_outlined;
      case 'signature_received':
        return Icons.check_circle_outline;
      case 'reminder':
        return Icons.notifications_active_outlined;
      default:
        return Icons.help_outline; // Default icon
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dashboardDataAsync = ref.watch(dashboardDataProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade300,
            Colors.blue.shade300,
            Colors.pink.shade100,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: dashboardDataAsync.when(
        data: (data) => _buildDashboardContent(context, data, ref),
        loading: () => const Center(child: Text("Loading")),
        error: (err, stack) => Center(
          child: Text("Error: ${err is Failure ? err.message : 'An unknown error occurred.'}"),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, DashboardDataModel data, WidgetRef ref) {

    return RefreshIndicator(
      onRefresh: () async => {},
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Greeting
          Text(
            '${data.greeting}, ${data.userName}!',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24),
          // Notifications (Optional, if you want to show a few)
          _buildSectionTitle(context, 'Notifications', Colors.white70),
          const SizedBox(height: 12),
          if (data.notifications.isEmpty)
            _buildEmptyStateCard('No new notifications.')
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: data.notifications.take(2).length, // Show max 2
              itemBuilder: (context, index) {
                final notif = data.notifications[index];
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 8),
                  color: notif.isRead ? Colors.white.withValues(alpha: 0.7) : Colors.blue.shade50.withValues(alpha: 0.9),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  child: ListTile(
                    leading: Icon(_getIconData(notif.type), color: notif.isRead ? Colors.grey.shade500 : Colors.blue.shade600),
                    title: Text(notif.message, style: TextStyle(fontSize: 13, fontWeight: notif.isRead ? FontWeight.normal : FontWeight.w500, color: Colors.grey.shade800)),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('This should open the notification details')));
                    },
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, Color color) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(color: color, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildEmptyStateCard(String message) {
    return Card(
      color: Colors.white.withValues(alpha: 0.75),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Center(
          child: Text(
            message,
            style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}