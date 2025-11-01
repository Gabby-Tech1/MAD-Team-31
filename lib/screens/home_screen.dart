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
import 'package:parkright/services/map_service.dart';
import 'package:parkright/providers/parking_provider.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final MapService _mapService = MapService();
  ParkingSpot? _selectedSpot;
  bool _isMapAvailable = true;
  bool _isLoadingParking = true;
  List<ParkingSpot> _hereApiParkingSpots = [];
  
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
    _loadParkingSpotsFromHereApi();
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
                hereApiParkingSpots: _hereApiParkingSpots,
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

  // Load parking spots from HERE API
  Future<void> _loadParkingSpotsFromHereApi() async {
    try {
      setState(() {
        _isLoadingParking = true;
      });

      // Default location (Saint Louis University area)
      final center = LatLng(38.6368, -90.2336);
      final places = await _mapService.searchParkingSpots(center, radius: 5000);

      print('HERE API returned ${places.length} parking spots');

      // Get parking provider
      final parkingProvider = context.read<ParkingProvider>();

      // If no spots from API, create mock spots for testing
      if (places.isEmpty) {
        print('No spots from HERE API, creating mock spots');
        _hereApiParkingSpots = [
          ParkingSpot(
            id: '', // Will be set by database
            ownerId: null, // System-generated spots have no owner
            title: 'SLU Parking Garage',
            address: '221 N Grand Blvd, St. Louis, MO 63103',
            location: LatLng(38.6368, -90.2336),
            pricePerHour: 2.5,
            isAvailable: true,
            images: [],
            amenities: ['Covered', 'Security'],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            hereApiId: 'mock_1',
          ),
          ParkingSpot(
            id: '', // Will be set by database
            ownerId: null,
            title: 'Busch Stadium Parking',
            address: '3501 Geyer Ave, St. Louis, MO 63104',
            location: LatLng(38.6226, -90.1928),
            pricePerHour: 3.0,
            isAvailable: true,
            images: [],
            amenities: ['Event Parking', 'Covered'],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            hereApiId: 'mock_2',
          ),
          ParkingSpot(
            id: '', // Will be set by database
            ownerId: null,
            title: 'Central West End Parking',
            address: '3536 Washington Ave, St. Louis, MO 63103',
            location: LatLng(38.6358, -90.2334),
            pricePerHour: 2.0,
            isAvailable: true,
            images: [],
            amenities: ['Street Parking', 'Metered'],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            hereApiId: 'mock_3',
          ),
        ];

        // Create spots in database
        final createdSpots = <ParkingSpot>[];
        for (var spot in _hereApiParkingSpots) {
          try {
            final createdSpot = await parkingProvider.createParkingSpot(spot);
            createdSpots.add(createdSpot);
          } catch (e) {
            print('Failed to create parking spot ${spot.title}: $e');
          }
        }
        _hereApiParkingSpots = createdSpots;
      } else {
        // Convert places to parking spots and store in database
        final spotsToCreate = places.map((place) {
          final index = places.indexOf(place);
          return ParkingSpot(
            id: '', // Will be set by database
            ownerId: null, // System-generated from HERE API
            title: place.title,
            address: place.address,
            location: place.position,
            pricePerHour: 2.0 + (index % 3), // Random price between 2-4
            isAvailable: true,
            images: [],
            amenities: ['HERE Maps API'],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            hereApiId: 'here_$index', // Store the HERE API reference
          );
        }).toList();

        _hereApiParkingSpots = [];
        for (var spot in spotsToCreate) {
          try {
            final createdSpot = await parkingProvider.createParkingSpot(spot);
            _hereApiParkingSpots.add(createdSpot);
          } catch (e) {
            print('Failed to create parking spot ${spot.title}: $e');
          }
        }
      }

      print('Final parking spots count: ${_hereApiParkingSpots.length}');

      // Force map component to reload with new spots
      setState(() {});

    } catch (e) {
      print('Error loading parking spots from HERE API: $e');
      // Fallback to mock spots
      _hereApiParkingSpots = [
        ParkingSpot(
          id: 'fallback_1',
          ownerId: null, // System-generated fallback spot
          title: 'Mock Parking Spot 1',
          address: 'Mock Address 1',
          location: LatLng(38.6368, -90.2336),
          pricePerHour: 2.0,
          isAvailable: true,
          images: [],
          amenities: ['Mock Data'],
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          hereApiId: 'fallback',
        ),
      ];
    } finally {
      setState(() {
        _isLoadingParking = false;
      });
    }
  }
}