import 'package:flutter/material.dart';
import 'package:parkright/models/parking_spot.dart';
import 'package:parkright/utils/app_constants.dart';

class ParkingCodeScreen extends StatelessWidget {
  final ParkingSpot spot;
  final int hours;
  final String spaceId;
  final int floor;
  final String vehicle;
  
  const ParkingCodeScreen({
    super.key,
    required this.spot,
    required this.hours,
    required this.spaceId,
    required this.floor,
    required this.vehicle,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate booking time
    final DateTime now = DateTime.now();
    final DateTime endTime = now.add(Duration(hours: hours));
    
    // Format times
    final String startTimeStr = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
    final String endTimeStr = '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    
    // Format date
    final String dateStr = 'Oct ${now.day}';
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Parking Code',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // Go back to home when done
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppConstants.homeRoute,
              (route) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          // QR Code
          Container(
            width: 200,
            height: 200,
            margin: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha(50),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Image.network(
              'https://api.qrserver.com/v1/create-qr-code/?size=200x200&data=PARKING_${spot.id}_${spaceId}_${floor}_${dateStr.replaceAll(' ', '')}_$startTimeStr',
              fit: BoxFit.contain,
            ),
          ),
          
          // Details grid
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Row 1: Name and Phone
                _buildDetailRow(
                  'Name',
                  'Gabby Addo',
                  'Phone',
                  '+233 591234567',
                ),
                
                const SizedBox(height: 16),
                
                // Row 2: Vehicle and Parking Pass
                _buildDetailRow(
                  'Vehicle',
                  vehicle,
                  'Parking Pass',
                  '#32-56-76',
                ),
                
                const SizedBox(height: 16),
                
                // Row 3: Parking Slot and Date From
                _buildDetailRow(
                  'Parking Slot',
                  '#$spaceId (F 0$floor)',
                  'Date From',
                  '$dateStr / $startTimeStr',
                ),
                
                const SizedBox(height: 16),
                
                // Row 4: Parking Address and Date To
                _buildDetailRow(
                  'Parking Address',
                  '${spot.name}, 95\n${spot.address}',
                  'Date To',
                  '$dateStr / $endTimeStr',
                  isMultiLine: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Build a detail row with two label-value pairs
  Widget _buildDetailRow(String label1, String value1, String label2, String value2, {bool isMultiLine = false}) {
    return Row(
      crossAxisAlignment: isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Left side
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label1,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value1,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        
        // Right side
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label2,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value2,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}