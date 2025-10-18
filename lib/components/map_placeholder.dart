import 'package:flutter/material.dart';
import 'package:parkright/utils/app_theme.dart';

class MapPlaceholder extends StatelessWidget {
  final VoidCallback? onTap;
  
  const MapPlaceholder({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Map placeholder icon
              Icon(
                Icons.map_outlined,
                size: 64,
                color: AppColors.primary,
              ),
              const SizedBox(height: 16),
              
              // Message
              Text(
                'Map unavailable',
                style: AppTextStyles.headline3,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              
              // Instructions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  'Please add your Google Maps API key in the AndroidManifest.xml and Info.plist files.',
                  style: AppTextStyles.bodySmall,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              
              // Button
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}