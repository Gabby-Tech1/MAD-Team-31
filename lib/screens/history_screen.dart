import 'package:flutter/material.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/models/parking_history_item.dart';
import 'package:parkright/components/parking_history_card.dart';
import 'package:parkright/components/empty_state_component.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<ParkingHistoryItem> historyItems = _getHistoryItems();
    
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

  // Sample history items
  List<ParkingHistoryItem> _getHistoryItems() {
    final now = DateTime.now();
    
    return [
      // Ongoing parking
      ParkingHistoryItem(
        id: '1',
        spotName: 'Marley Square Parking',
        address: '123 Marley St, New York',
        startTime: now.subtract(const Duration(hours: 1)),
        endTime: now.add(const Duration(hours: 2)),
        spaceId: 'A24',
        floor: 2,
        vehicle: 'Toyota Camry',
        amount: 15.00,
        isCompleted: false,
      ),
      
      // Completed parking
      ParkingHistoryItem(
        id: '2',
        spotName: 'Ocean View Lot',
        address: '456 Ocean Ave, New York',
        startTime: now.subtract(const Duration(days: 2, hours: 3)),
        endTime: now.subtract(const Duration(days: 2, hours: 1)),
        spaceId: 'B12',
        floor: 1,
        vehicle: 'Toyota Camry',
        amount: 10.00,
        isCompleted: true,
      ),
      ParkingHistoryItem(
        id: '3',
        spotName: 'Central Plaza Garage',
        address: '789 Central Blvd, New York',
        startTime: now.subtract(const Duration(days: 5, hours: 4)),
        endTime: now.subtract(const Duration(days: 5, hours: 2)),
        spaceId: 'C08',
        floor: 3,
        vehicle: 'Honda Accord',
        amount: 8.50,
        isCompleted: true,
      ),
      ParkingHistoryItem(
        id: '4',
        spotName: 'Downtown Parking Complex',
        address: '321 Main St, New York',
        startTime: now.subtract(const Duration(days: 10, hours: 5)),
        endTime: now.subtract(const Duration(days: 10, hours: 3)),
        spaceId: 'D15',
        floor: 4,
        vehicle: 'Toyota Camry',
        amount: 12.00,
        isCompleted: true,
      ),
    ];
  }
}