import 'package:flutter/material.dart';
import 'package:parkright/models/parking_spot.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/components/primary_button.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:parkright/providers/parking_provider.dart';
import 'package:parkright/providers/auth_provider.dart';
import 'package:parkright/models/booking.dart';

class BookingReviewScreen extends StatelessWidget {
  final ParkingSpot spot;
  final int hours;
  final String spaceId;
  final int floor;
  final String vehicle;
  
  const BookingReviewScreen({
    super.key,
    required this.spot,
    required this.hours,
    required this.spaceId,
    required this.floor,
    this.vehicle = 'Mercedez Benz Z3', // Default vehicle for demo
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Review Summary',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Price and location summary
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Price for duration
                Text(
                  '\$${spot.calculatePrice(hours)} for $hours hours',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                // Parking spot name
                Text(
                  spot.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                // Distance
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 18, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      '${spot.distanceInMeters}m away',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    
                    // Rating
                    Row(
                      children: [
                        const Icon(Icons.star, size: 18, color: Colors.amber),
                        Text(
                          '4.5',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const Divider(),
          
          // Booking details
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildDetailRow(
                  'Duration:', 
                  '$hours hours', 
                  showUpdate: true,
                  onUpdate: () {
                    // Handle duration update
                    // For demo, we'll just show a message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Duration update feature coming soon')),
                    );
                  },
                ),
                
                _buildDetailRow(
                  'Vehicle', 
                  vehicle, 
                  showUpdate: true,
                  onUpdate: () {
                    // Handle vehicle update
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vehicle update feature coming soon')),
                    );
                  },
                ),
                
                _buildDetailRow(
                  'Parking Spot', 
                  '$spaceId (${_getFloorSuffix(floor)} Floor)', 
                  showUpdate: true,
                  onUpdate: () {
                    // Go back to the parking space selection screen
                    Navigator.pop(context);
                  },
                ),
                
                _buildDetailRow(
                  'Payment', 
                  'Paystack', 
                  showUpdate: true,
                  onUpdate: () {
                    // Handle payment method update
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Payment method update feature coming soon')),
                    );
                  },
                ),
              ],
            ),
          ),
          
          const Spacer(),
          
          // Pay button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: PrimaryButton(
              text: 'Pay and Confirm',
              onPressed: () async {
                // Get providers
                final authProvider = context.read<AuthProvider>();
                final parkingProvider = context.read<ParkingProvider>();
                
                if (authProvider.user == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please log in first')),
                  );
                  return;
                }
                
                // Load user vehicles if not already loaded
                if (parkingProvider.userVehicles.isEmpty) {
                  await parkingProvider.loadUserVehicles(authProvider.user!.id);
                }

                // Check if user has vehicles
                if (parkingProvider.userVehicles.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please add a vehicle first before booking')),
                  );
                  return;
                }

                // Find the vehicle by model/name
                final selectedVehicle = parkingProvider.userVehicles.firstWhere(
                  (v) => v.model == vehicle,
                  orElse: () => parkingProvider.userVehicles.first,
                );
                
                // Create booking
                final booking = Booking(
                  id: '', // Will be set by database
                  userId: authProvider.user!.id,
                  parkingSpotId: spot.id,
                  vehicleId: selectedVehicle.id,
                  startTime: DateTime.now(),
                  endTime: DateTime.now().add(Duration(hours: hours)),
                  totalPrice: spot.calculatePrice(hours),
                  status: 'confirmed',
                  paymentStatus: 'paid',
                  createdAt: DateTime.now(),
                );
                
                final success = await parkingProvider.createBooking(booking);
                
                if (success) {
                  // Navigate to the parking code screen
                  Navigator.pushNamed(
                    context,
                    AppConstants.parkingCodeRoute,
                    arguments: {
                      'spot': spot,
                      'hours': hours,
                      'spaceId': spaceId,
                      'floor': floor,
                      'vehicle': vehicle,
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(parkingProvider.error ?? 'Failed to create booking. Please try again.')),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to get floor suffix (st, nd, rd, th)
  String _getFloorSuffix(int floor) {
    if (floor == 1) return '1st';
    if (floor == 2) return '2nd';
    if (floor == 3) return '3rd';
    return '${floor}th';
  }
  
  // Build a detail row with label and value
  Widget _buildDetailRow(String label, String value, {bool showUpdate = false, VoidCallback? onUpdate}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (showUpdate && onUpdate != null) ...[
            const SizedBox(width: 8),
            InkWell(
              onTap: onUpdate,
              child: const Text(
                'Update',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}