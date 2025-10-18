import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:parkright/components/fade_slide_animation.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/utils/app_theme.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({Key? key}) : super(key: key);

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {
  final TextEditingController _licensePlateController = TextEditingController();
  final TextEditingController _carModelController = TextEditingController();
  String _selectedVehicleType = 'Car'; // Default value
  File? _vehicleImage;
  final ImagePicker _picker = ImagePicker();
  
  // List of vehicle types for dropdown
  final List<String> _vehicleTypes = ['Car', 'SUV', 'Truck', 'Motorcycle', 'Van'];
  
  @override
  void dispose() {
    _licensePlateController.dispose();
    _carModelController.dispose();
    super.dispose();
  }
  
  void _navigateToHome() {
    // Check if all fields are filled
    if (_licensePlateController.text.isEmpty || 
        _carModelController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Vehicle added successfully!')),
    );
    
    // In a real app, we would save the vehicle data
    // For UI implementation, just navigate to the home screen
    Navigator.pushNamedAndRemoveUntil(
      context, 
      AppConstants.homeRoute, 
      (route) => false
    );
  }
  
  // Check and request camera and storage permissions
  Future<bool> _requestPermissions(bool isCamera) async {
    // Determine which permissions to request based on Android version and source
    List<Permission> permissions = [];
    
    // Camera permission is needed for camera
    if (isCamera) {
      permissions.add(Permission.camera);
    }
    
    // Storage permissions based on Android version
    if (Platform.isAndroid) {
      // Check Android version for appropriate permissions
      try {
        // For Android 13+ (SDK 33+) use media permissions
        permissions.add(Permission.photos);
      } catch (e) {
        // Fallback to storage for older versions
        permissions.add(Permission.storage);
      }
    } else if (Platform.isIOS) {
      // For iOS, add photos permission
      permissions.add(Permission.photos);
    }
    
    // Check current permission status first
    Map<Permission, PermissionStatus> statuses = {};
    for (var permission in permissions) {
      statuses[permission] = await permission.status;
    }
    
    // Request permissions that aren't granted
    List<Permission> permissionsToRequest = permissions
        .where((permission) => statuses[permission] != PermissionStatus.granted)
        .toList();
    
    if (permissionsToRequest.isNotEmpty) {
      statuses = await permissionsToRequest.request();
    }
    
    // Check if all required permissions are granted
    bool allGranted = permissions.every(
      (permission) => statuses[permission] == PermissionStatus.granted
    );
    
    // If permissions are permanently denied, show settings dialog
    bool isPermanentlyDenied = permissions.any(
      (permission) => statuses[permission] == PermissionStatus.permanentlyDenied
    );
    
    if (isPermanentlyDenied && mounted) {
      _showPermissionSettingsDialog();
      return false;
    }
    
    return allGranted;
  }
  
  // Show dialog to guide user to settings when permissions are permanently denied
  void _showPermissionSettingsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: const Text(
            'Camera and storage permissions are required for this feature. '
            'Please open app settings and enable the required permissions.'
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    );
  }
  
  // Pick image from gallery
  Future<void> _pickImageFromGallery() async {
    if (await _requestPermissions(false)) {
      try {
        final XFile? image = await _picker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );
        
        if (image != null && mounted) {
          setState(() {
            _vehicleImage = File(image.path);
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error accessing gallery: ${e.toString()}')),
          );
        }
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Storage permission is required to pick images'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  // Take photo with camera
  Future<void> _takePhoto() async {
    if (await _requestPermissions(true)) {
      try {
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 80,
        );
        
        if (photo != null && mounted) {
          setState(() {
            _vehicleImage = File(photo.path);
          });
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error accessing camera: ${e.toString()}')),
          );
        }
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Camera permission is required to take photos'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  
  // Show bottom sheet with image source options
  void _pickImage() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Image Source',
                  style: AppTextStyles.headline3,
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.photo_library, color: AppColors.primary),
                  title: Text('Gallery', style: AppTextStyles.bodyMedium),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImageFromGallery();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: AppColors.primary),
                  title: Text('Camera', style: AppTextStyles.bodyMedium),
                  onTap: () {
                    Navigator.pop(context);
                    _takePhoto();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              FadeSlideAnimation(
                child: Text(
                  'Add a Vehicle',
                  style: AppTextStyles.headline2,
                ),
              ),
              const SizedBox(height: 24),
              // Vehicle image picker
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 100),
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundLight,
                      border: Border.all(color: AppColors.primary, width: 1),
                      borderRadius: BorderRadius.circular(8),
                      image: _vehicleImage != null
                          ? DecorationImage(
                              image: FileImage(_vehicleImage!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _vehicleImage == null
                        ? const Center(
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 48,
                              color: AppColors.textLight,
                            ),
                          )
                        : Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Positioned(
                                bottom: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Vehicle details section
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 200),
                child: Text(
                  'Vehicle details',
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 250),
                child: Text(
                  'Add your vehicle details below',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Vehicle type dropdown
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 300),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.directions_car_outlined,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TYPE',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            DropdownButton<String>(
                              value: _selectedVehicleType,
                              icon: const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColors.textSecondary,
                              ),
                              iconSize: 24,
                              elevation: 2,
                              isExpanded: true,
                              underline: const SizedBox(), // Remove default underline
                              style: AppTextStyles.bodyMedium,
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    _selectedVehicleType = newValue;
                                  });
                                }
                              },
                              items: _vehicleTypes.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // License plate number
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.tag,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'LICENSE PLATE NO',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            TextField(
                              controller: _licensePlateController,
                              decoration: const InputDecoration(
                                hintText: '7D10 4570 876',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () async {
                          // Take photo of license plate
                          if (await _requestPermissions(true)) {
                            try {
                              final XFile? photo = await _picker.pickImage(
                                source: ImageSource.camera,
                                imageQuality: 80,
                              );
                              
                              if (photo != null && mounted) {
                                // Here you could implement license plate OCR
                                // For now, just show the filename as an example
                                final String filename = photo.path.split('/').last;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Captured: $filename')),
                                );
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error: ${e.toString()}')),
                                );
                              }
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Car model
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 500),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.settings_outlined,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CAR MODEL',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            TextField(
                              controller: _carModelController,
                              decoration: const InputDecoration(
                                hintText: 'Mercedes Benz 23',
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: AppTextStyles.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Add vehicle button
              FadeSlideAnimation(
                delay: const Duration(milliseconds: 600),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _navigateToHome,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.buttonText,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add Vehicle',
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.buttonText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}