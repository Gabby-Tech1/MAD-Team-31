import 'package:flutter/material.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/models/parking_history_item.dart';
import 'package:parkright/components/parking_history_card.dart';
import 'package:parkright/components/empty_state_component.dart';
import 'package:provider/provider.dart';
import 'package:parkright/providers/auth_provider.dart';
import 'package:parkright/providers/parking_provider.dart';
import 'package:parkright/models/booking.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    _loadUserBookings();
  }

  Future<void> _loadUserBookings() async {
    final authProvider = context.read<AuthProvider>();
    final parkingProvider = context.read<ParkingProvider>();

    if (authProvider.user != null) {
      await parkingProvider.loadUserBookings(authProvider.user!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingProvider>(
      builder: (context, parkingProvider, child) {
        final bookings = parkingProvider.userBookings;
        final historyItems = _convertBookingsToHistoryItems(bookings);

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              title: const Text(
                'Parking History',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: const TabBar(
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.textSecondary,
                indicatorColor: AppColors.primary,
                tabs: [
                  Tab(text: 'Ongoing'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                // Ongoing tab
                _buildHistoryList(
                  historyItems.where((item) => !item.isCompleted).toList(),
                  isOngoing: true,
                ),

                // Completed tab
                _buildHistoryList(
                  historyItems.where((item) => item.isCompleted).toList(),
                  isOngoing: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHistoryList(List<ParkingHistoryItem> items, {required bool isOngoing}) {
    if (items.isEmpty) {
      return EmptyStateComponent(
        icon: isOngoing ? Icons.local_parking : Icons.history,
        title: isOngoing ? 'No Ongoing Parking' : 'No Parking History',
        subtitle: isOngoing
            ? 'You don\'t have any ongoing parking bookings'
            : 'Your completed parking bookings will appear here',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return ParkingHistoryCard(
          historyItem: items[index],
          onTap: () {
            // Handle history item tap
          },
        );
      },
    );
  }

  List<ParkingHistoryItem> _convertBookingsToHistoryItems(List<Booking> bookings) {
    return bookings.map((booking) {
      // For now, we'll need to get parking spot details and vehicle details
      // This is a simplified conversion - in a real app you'd join this data
      return ParkingHistoryItem(
        id: booking.id,
        spotName: 'Parking Spot ${booking.parkingSpotId}', // TODO: Get actual spot name
        address: 'Address not available', // TODO: Get actual address
        startTime: booking.startTime,
        endTime: booking.endTime,
        spaceId: 'Space ID', // TODO: Get actual space ID
        floor: 1, // TODO: Get actual floor
        vehicle: 'Vehicle ${booking.vehicleId}', // TODO: Get actual vehicle name
        amount: booking.totalPrice,
        isCompleted: booking.status == 'completed',
      );
    }).toList();
  }
}