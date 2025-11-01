import 'package:flutter/material.dart';
import 'package:parkright/utils/app_theme.dart';
import 'package:parkright/components/profile_list_tile.dart';
import 'package:parkright/models/user_profile.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:parkright/providers/auth_provider.dart';
import 'package:parkright/providers/parking_provider.dart';
import 'package:parkright/models/vehicle.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? userProfile;
  bool isDarkMode = false;
  bool notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    final authProvider = context.read<AuthProvider>();
    final parkingProvider = context.read<ParkingProvider>();

    if (authProvider.user != null) {
      await parkingProvider.loadUserVehicles(authProvider.user!.id);

      setState(() {
        userProfile = UserProfile(
          name: authProvider.user?.userMetadata?['full_name']?.toString() ?? 'User',
          email: authProvider.user?.email ?? '',
          phoneNumber: authProvider.user?.userMetadata?['phone']?.toString() ?? '',
          vehicles: parkingProvider.userVehicles.map((v) => v.model).toList(),
        );
      });
    } else {
      setState(() {
        userProfile = UserProfile(
          name: 'Guest User',
          email: '',
          phoneNumber: '',
          vehicles: [],
        );
      });
    }
  }

  void _editProfile() {
    if (userProfile == null) return;

    final nameController = TextEditingController(text: userProfile!.name);
    final emailController = TextEditingController(text: userProfile!.email);
    final phoneController = TextEditingController(text: userProfile!.phoneNumber);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Name'),
                controller: nameController,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              TextField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                controller: phoneController,
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              nameController.dispose();
              emailController.dispose();
              phoneController.dispose();
              Navigator.of(context).pop();
            },
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                userProfile = UserProfile(
                  name: nameController.text.trim().isEmpty
                      ? userProfile!.name
                      : nameController.text.trim(),
                  email: emailController.text.trim().isEmpty
                      ? userProfile!.email
                      : emailController.text.trim(),
                  phoneNumber: phoneController.text.trim().isEmpty
                      ? userProfile!.phoneNumber
                      : phoneController.text.trim(),
                  vehicles: userProfile!.vehicles,
                );
              });

              nameController.dispose();
              emailController.dispose();
              phoneController.dispose();

              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
            },
            child: const Text('SAVE'),
          ),
        ],
      ),
    );
  }

  void _showVehicleOptions(List<Vehicle> vehicles) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Vehicles',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            if (vehicles.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('No vehicles added yet.'),
              ),
            ...vehicles.map((vehicle) => ListTile(
                  leading: const Icon(Icons.directions_car, color: AppColors.primary),
                  title: Text(vehicle.model),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Vehicle deletion coming soon')),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                )),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, AppConstants.addVehicleRoute);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Vehicle'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About ParkRight'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ParkRight v1.0.0'),
            SizedBox(height: 8),
            Text('Find, book and pay for parking easily.'),
            SizedBox(height: 16),
            Text('© 2025 ParkRight LLC'),
            Text('All rights reserved'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(UserProfile profile) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                profile.initials,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(profile.name,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(profile.email,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 4),
                Text(profile.phoneNumber,
                    style: const TextStyle(
                        fontSize: 14, color: AppColors.textSecondary)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: AppColors.primary),
            onPressed: _editProfile,
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          ...items,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
        return false;
      },
      child: Consumer2<AuthProvider, ParkingProvider>(
        builder: (context, authProvider, parkingProvider, child) {
          final user = authProvider.user;
          final vehicles = parkingProvider.userVehicles;

          final currentProfile = userProfile ??
              UserProfile(
                name: user?.userMetadata?['full_name']?.toString() ?? 'User',
                email: user?.email ?? '',
                phoneNumber: user?.userMetadata?['phone']?.toString() ?? '',
                vehicles: vehicles.map((v) => v.model).toList(),
              );

          if (userProfile == null && (user == null && vehicles.isEmpty)) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }

          return Scaffold(
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Profile',
                style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppConstants.homeRoute);
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined,
                      color: AppColors.textPrimary),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Settings coming soon!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _buildProfileCard(currentProfile),
                  const SizedBox(height: 16),
                  _buildSection('Account', [
                    ProfileListTile(
                      icon: Icons.person_outline,
                      title: 'Personal Information',
                      onTap: _editProfile,
                    ),
                    ProfileListTile(
                      icon: Icons.directions_car_outlined,
                      title: 'My Vehicles',
                      onTap: () => _showVehicleOptions(vehicles),
                      subtitle: '${vehicles.length} vehicles',
                    ),
                    ProfileListTile(
                      icon: Icons.payment_outlined,
                      title: 'Payment Methods',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Payment methods coming soon!'),
                              duration: Duration(seconds: 1)),
                        );
                      },
                    ),
                  ]),
                  const SizedBox(height: 16),
                  _buildSection('Settings', [
                    SwitchListTile(
                      title: const Text('Dark Mode'),
                      secondary: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                      value: isDarkMode,
                      onChanged: (value) {
                        setState(() => isDarkMode = value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                isDarkMode ? 'Dark mode enabled' : 'Light mode enabled'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    const Divider(height: 1, indent: 72),
                    SwitchListTile(
                      title: const Text('Notifications'),
                      secondary: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          notificationsEnabled
                              ? Icons.notifications
                              : Icons.notifications_off,
                          color: AppColors.primary,
                          size: 22,
                        ),
                      ),
                      value: notificationsEnabled,
                      onChanged: (value) {
                        setState(() => notificationsEnabled = value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(notificationsEnabled
                                ? 'Notifications enabled'
                                : 'Notifications disabled'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    const Divider(height: 1, indent: 72),
                    ProfileListTile(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Help & Support coming soon!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                    ProfileListTile(
                      icon: Icons.info_outline,
                      title: 'About ParkRight',
                      onTap: _showAboutDialog,
                      subtitle: 'Version 1.0.0',
                    ),
                  ]),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirm Logout'),
                            content: const Text('Are you sure you want to log out?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('CANCEL'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacementNamed(
                                      context, AppConstants.loginRoute);
                                },
                                child: const Text('LOG OUT'),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade50,
                        foregroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Log Out'),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}