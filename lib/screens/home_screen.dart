import 'package:flutter/material.dart';
import 'package:parkright/screens/feedback_screen.dart';
import 'package:parkright/utils/app_constants.dart';
import 'package:parkright/models/parking_spot.dart';
import 'package:parkright/models/parking_category.dart';
import 'package:parkright/components/map_component.dart';
import 'package:parkright/components/map_placeholder.dart';
import 'package:parkright/components/search_bar_component.dart';
import 'package:parkright/components/category_selector_component.dart';
import 'package:parkright/components/parking_spot_selection_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  ParkingSpot? _selectedSpot;
  bool _isMapAvailable = true;
  
  // Example categories
  final List<ParkingCategory> _categories = [
    const ParkingCategory(id: '1', name: 'All', icon: Icons.apps),
    const ParkingCategory(id: '2', name: 'Car', icon: Icons.directions_car),
    const ParkingCategory(id: '3', name: 'Bike', icon: Icons.motorcycle),
    const ParkingCategory(id: '4', name: 'Handicapped', icon: Icons.accessible),
    const ParkingCategory(id: '5', name: 'Truck', icon: Icons.local_shipping),
  ];
  
  late ParkingCategory _selectedCategory;
  
  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories[0]; // Default to 'All'
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        // Map Component or Placeholder
        _isMapAvailable
            ? MapComponent(
                onSpotSelected: (spot) {
                  setState(() {
                    _selectedSpot = spot;
                  });
                },
                onMapError: () {
                  setState(() {
                    _isMapAvailable = false;
                  });
                },
              )
            : MapPlaceholder(
                onTap: () {
                  setState(() {
                    _isMapAvailable = true;
                  });
                },
              ),

        // Search Bar at the top
        SafeArea(
          child: Column(
            children: [
              SearchBarComponent(
                controller: _searchController,
                onSearchChanged: _onSearchChanged,
                onFilterTap: _onFilterTap,
                locationName: 'Sylhet, India',
              ),

              // Category selector
              CategorySelectorComponent(
                categories: _categories,
                selectedCategory: _selectedCategory,
                onCategorySelected: (category) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
            ],
          ),
        ),

        // Selected spot card
        if (_selectedSpot != null)
          Positioned(
            left: 0,
            right: 0,
            bottom: 16, // Give some space from bottom
            child: ParkingSpotSelectionCard(
              spot: _selectedSpot!,
              onBookNowPressed: () => _navigateToDetail(_selectedSpot!),
            ),
          ),
      ],
    ),

    // 💬 Floating Feedback Button
    floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const FeedbackScreen()),
        );
      },
      icon: const Icon(Icons.feedback),
      label: const Text('Feedback'),
    ),
  );
}
  

  
  void _onSearchChanged(String query) {
    // Handle search query changes
    print('Search query: $query');
  }
  
  void _onFilterTap() {
    // Show filter options
    print('Filter tapped');
  }
  
  void _navigateToDetail(ParkingSpot spot) {
    Navigator.pushNamed(
      context,
      AppConstants.parkingDetailRoute,
      arguments: {'spot': spot},
    );
  }
}