import 'package:flutter/material.dart';
import 'package:parkright/models/parking_spot.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/components/primary_button.dart';
import 'package:intl/intl.dart';

class ParkingDetailComponent extends StatefulWidget {
  final ParkingSpot spot;

  const ParkingDetailComponent({
    Key? key,
    required this.spot,
  }) : super(key: key);

  @override
  State<ParkingDetailComponent> createState() => _ParkingDetailComponentState();
}

class _ParkingDetailComponentState extends State<ParkingDetailComponent> {
  int _selectedHours = 1;
  final List<int> _availableHours = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Back button and title
        Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              color: AppColors.textPrimary,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.textLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 48), // Balance space for back button
          ],
        ),
        
        // Parking spot name and address
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.spot.name,
                style: AppTextStyles.headline2,
              ),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.textSecondary,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    widget.spot.address,
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
        
        // Distance and available spots
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              // Distance
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.directions_walk,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.spot.distanceInMeters}m away',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              
              // Available spots
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_parking,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.spot.availableSpots} spots',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        
        // Action buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.call,
                label: 'Call',
                onTap: () {
                  // Call action
                },
              ),
              _buildActionButton(
                icon: Icons.directions,
                label: 'Direction',
                onTap: () {
                  // Direction action
                },
              ),
              _buildActionButton(
                icon: Icons.share,
                label: 'Share',
                onTap: () {
                  // Share action
                },
              ),
            ],
          ),
        ),
        
        const Divider(height: 32, thickness: 1),
        
        // Info section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Info',
                style: AppTextStyles.headline3,
              ),
              const SizedBox(height: 8),
              Text(
                widget.spot.description ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla facilisi. Integer ac ligula sed lorem feugiat euismod. Vivamus dictum, nisi sed pretium posuere, tellus risus lacinia arcu. Suspendisse potenti. Cras ac odio vel sapien volutpati.',
                style: AppTextStyles.bodySmall,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Read more action
                  },
                  child: const Text(
                    'Read More',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Parking time selector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parking Time',
                style: AppTextStyles.headline3,
              ),
              const SizedBox(height: 16),
              
              // Time options
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _availableHours.map((hours) {
                  final bool isSelected = _selectedHours == hours;
                  
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedHours = hours;
                      });
                    },
                    child: Container(
                      width: (MediaQuery.of(context).size.width - 64) / 3,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected 
                              ? AppColors.primary 
                              : AppColors.divider,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '$hours hour',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected 
                                  ? Colors.white 
                                  : AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${widget.spot.calculatePrice(hours)}',
                            style: TextStyle(
                              color: isSelected 
                                  ? Colors.white 
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        
        // Book button
        Padding(
          padding: const EdgeInsets.all(16),
          child: PrimaryButton(
            text: 'Book for \$${widget.spot.calculatePrice(_selectedHours)}',
            onPressed: () {
              // Book action
              _showBookingConfirmation(context);
            },
          ),
        ),
      ],
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.backgroundLight,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.caption,
            ),
          ],
        ),
      ),
    );
  }
  
  void _showBookingConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Spot: ${widget.spot.name}'),
            const SizedBox(height: 8),
            Text('Duration: $_selectedHours hour(s)'),
            const SizedBox(height: 8),
            Text('Price: \$${widget.spot.calculatePrice(_selectedHours)}'),
            const SizedBox(height: 8),
            Text('Date: ${DateFormat('MMM dd, yyyy').format(DateTime.now())}'),
            const SizedBox(height: 8),
            Text('Time: ${DateFormat('hh:mm a').format(DateTime.now())}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              
              // Navigate to parking space selection screen
              Navigator.pushNamed(
                context,
                AppConstants.parkingSpaceSelectionRoute,
                arguments: {
                  'spot': widget.spot,
                  'hours': _selectedHours,
                },
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}