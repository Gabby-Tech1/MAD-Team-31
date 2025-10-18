import 'package:flutter/material.dart';
import 'package:parkright/models/parking_spot.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/components/primary_button.dart';

class ParkingSpotSelectionCard extends StatelessWidget {
  final ParkingSpot spot;
  final VoidCallback onBookNowPressed;

  const ParkingSpotSelectionCard({
    Key? key,
    required this.spot,
    required this.onBookNowPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Parking spot name
          Text(
            spot.name,
            style: AppTextStyles.headline3,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          
          // Address row with icon
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  spot.address,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // Distance and available spots
          Row(
            children: [
              // Distance
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLight,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.directions_walk,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${spot.distanceInMeters}m away',
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.local_parking,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${spot.availableSpots} spots',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              
              // Price
              Text(
                spot.formattedPrice,
                style: AppTextStyles.headline3.copyWith(
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                'per hour',
                style: AppTextStyles.caption,
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Book now button
          SizedBox(
            width: double.infinity,
            child: PrimaryButton(
              text: 'Book Now',
              onPressed: onBookNowPressed,
            ),
          ),
        ],
      ),
    );
  }
}