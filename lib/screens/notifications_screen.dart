import 'package:flutter/material.dart';
import 'package:parkright/components/empty_state_component.dart';
import 'package:parkright/models/notification_item.dart';
import 'package:parkright/components/notification_item_card.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/utils/app_constants.dart'; // ✅ add this import

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<NotificationItem> notifications = _getNotifications();

    return WillPopScope(
      onWillPop: () async {
        // ✅ When user presses Android back button
        Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () {
              // ✅ When back arrow pressed in AppBar
              Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
            },
          ),
          title: const Text(
            'Notifications',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Mark all as read action
              },
              child: const Text(
                'Mark all as read',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        body: notifications.isEmpty
            ? const EmptyStateComponent(
                icon: Icons.notifications_off_outlined,
                title: 'No Notifications',
                subtitle: 'You don\'t have any notifications yet',
              )
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return NotificationItemCard(
                    notification: notifications[index],
                    onTap: () {
                      // Handle notification tap
                    },
                  );
                },
              ),
      ),
    );
  }

  // ✅ Sample notifications (no change)
  List<NotificationItem> _getNotifications() {
    return [
      NotificationItem(
        id: '1',
        title: 'Booking Confirmed',
        message: 'Your parking booking for Marley Square has been confirmed.',
        dateTime: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: true,
        type: NotificationType.success,
      ),
      NotificationItem(
        id: '2',
        title: 'Payment Successful',
        message:
            'Your payment of \$12.50 for 2 hours parking has been processed successfully.',
        dateTime: DateTime.now().subtract(const Duration(days: 1)),
        isRead: false,
        type: NotificationType.payment,
      ),
      NotificationItem(
        id: '3',
        title: 'Parking Time Ending Soon',
        message:
            'You have 15 minutes remaining for your parking at Ocean View Lot.',
        dateTime: DateTime.now().subtract(const Duration(days: 2)),
        isRead: false,
        type: NotificationType.warning,
      ),
      NotificationItem(
        id: '4',
        title: 'Special Offer',
        message:
            'Get 25% off your next parking booking at any Downtown location.',
        dateTime: DateTime.now().subtract(const Duration(days: 5)),
        isRead: true,
        type: NotificationType.promotion,
      ),
    ];
  }
}