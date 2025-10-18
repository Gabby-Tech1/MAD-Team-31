import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:parkright/models/parking_spot.dart';
import 'dart:async';

class MapComponent extends StatefulWidget {
  final Function(ParkingSpot) onSpotSelected;
  final VoidCallback? onMapError;

  const MapComponent({
    super.key,
    required this.onSpotSelected,
    this.onMapError,
  });

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  final MapController _mapController = MapController();
  
  // Initial center position (Saint Louis University, USA)
  static final LatLng _initialCenter = LatLng(38.6368, -90.2336); // Saint Louis University center
  
  // Saint Louis University campus parking spots data
  final List<ParkingSpot> _parkingSpots = [
    ParkingSpot(
      id: '1',
      name: 'Laclede Garage',
      address: 'Laclede Ave',
      position: LatLng(38.6356, -90.2342), // Main campus garage
      pricePerHour: 3,
      availableSpots: 15,
      distanceInMeters: 50,
    ),
    ParkingSpot(
      id: '2',
      name: 'Grand Garage',
      address: 'Grand Blvd',
      position: LatLng(38.6365, -90.2365), // Near Grand entrance
      pricePerHour: 2,
      availableSpots: 20,
      distanceInMeters: 150,
    ),
    ParkingSpot(
      id: '3',
      name: 'Olive Garage',
      address: 'Olive St',
      position: LatLng(38.6378, -90.2351), // North campus area
      pricePerHour: 2,
      availableSpots: 25,
      distanceInMeters: 200,
    ),
    ParkingSpot(
      id: '4',
      name: 'Chaifetz Arena Parking',
      address: 'S Compton Ave',
      position: LatLng(38.6337, -90.2301), // Arena parking
      pricePerHour: 4,
      availableSpots: 30,
      distanceInMeters: 350,
    ),
    ParkingSpot(
      id: '5',
      name: 'Spring Hall Parking',
      address: 'Spring Ave',
      position: LatLng(38.6354, -90.2376), // Residence hall parking
      pricePerHour: 2,
      availableSpots: 10,
      distanceInMeters: 180,
    ),
    ParkingSpot(
      id: '6',
      name: 'Lindell Blvd Parking',
      address: 'Lindell Blvd',
      position: LatLng(38.6392, -90.2341), // North edge of campus
      pricePerHour: 3,
      availableSpots: 8,
      distanceInMeters: 250,
    ),
    ParkingSpot(
      id: '7',
      name: 'Morrissey Hall Lot',
      address: 'Spring Ave',
      position: LatLng(38.6340, -90.2363), // Southwest campus
      pricePerHour: 2,
      availableSpots: 12,
      distanceInMeters: 220,
    ),
    ParkingSpot(
      id: '8',
      name: 'Simon Recreation Center Parking',
      address: 'Laclede Ave',
      position: LatLng(38.6365, -90.2326), // East campus
      pricePerHour: 3,
      availableSpots: 15,
      distanceInMeters: 120,
    ),
    ParkingSpot(
      id: '9',
      name: 'Pius XII Library Parking',
      address: 'W Pine Mall',
      position: LatLng(38.6371, -90.2352), // Central campus
      pricePerHour: 2,
      availableSpots: 7,
      distanceInMeters: 100,
    ),
    ParkingSpot(
      id: '10',
      name: 'Busch Student Center Lot',
      address: 'Grand Blvd',
      position: LatLng(38.6367, -90.2375), // Near student center
      pricePerHour: 3,
      availableSpots: 9,
      distanceInMeters: 140,
    ),
    ParkingSpot(
      id: '11',
      name: 'Medical Center Garage',
      address: 'S Grand Blvd',
      position: LatLng(38.6396, -90.2365), // SLU Hospital area
      pricePerHour: 4,
      availableSpots: 22,
      distanceInMeters: 380,
    ),
    ParkingSpot(
      id: '12',
      name: 'Griesedieck Hall Parking',
      address: 'Laclede Ave',
      position: LatLng(38.6350, -90.2361), // Residence hall area
      pricePerHour: 2,
      availableSpots: 10,
      distanceInMeters: 160,
    ),
    ParkingSpot(
      id: '13',
      name: 'Reinert Hall Lot',
      address: 'W Pine Mall',
      position: LatLng(38.6380, -90.2368), // Northeast residence area
      pricePerHour: 2,
      availableSpots: 8,
      distanceInMeters: 190,
    ),
    ParkingSpot(
      id: '14',
      name: 'Vandeventer Lot',
      address: 'S Vandeventer Ave',
      position: LatLng(38.6355, -90.2395), // Western edge of campus
      pricePerHour: 2,
      availableSpots: 15,
      distanceInMeters: 300,
    ),
  ];
  
  // List of marker layers
  List<Marker> _markers = [];
  bool _isMapLoaded = false;

  @override
  void initState() {
    super.initState();
    _createMarkers();
    
    // Add a slight delay to check if map loads properly
    Future.delayed(Duration(seconds: 2), () {
      if (!_isMapLoaded && mounted) {
        if (widget.onMapError != null) {
          widget.onMapError!();
        }
      }
    });
  }

  // Create map markers from parking spots
  void _createMarkers() {
    _markers = _parkingSpots.map((spot) => 
      Marker(
        point: spot.position,
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => widget.onSpotSelected(spot),
          child: Column(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.red,
                size: 30,
              ),
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  spot.name,
                  style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // OpenStreetMap with error handling
        Builder(
          builder: (context) {
            try {
              return FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _initialCenter,
                  initialZoom: 5.0,
                  onMapReady: () {
                    setState(() {
                      _isMapLoaded = true;
                    });
                    // Move to Saint Louis University campus
                    _mapController.move(LatLng(38.6368, -90.2336), 15.0);
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.parkright.app',
                    maxZoom: 19,
                  ),
                  MarkerLayer(markers: _markers),
                ],
              );
            } catch (e) {
              // Handle map error
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (widget.onMapError != null) {
                  widget.onMapError!();
                }
              });
              return const SizedBox.expand(
                child: ColoredBox(color: Colors.grey),
              );
            }
          },
        ),
        
        // Map Controls
        Positioned(
          bottom: 16,
          right: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Zoom In
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.1 * 255).round()),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(
                      _mapController.camera.center, 
                      currentZoom + 1.0
                    );
                  },
                ),
              ),
              
              // Zoom Out
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.1 * 255).round()),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    final currentZoom = _mapController.camera.zoom;
                    _mapController.move(
                      _mapController.camera.center, 
                      currentZoom - 1.0
                    );
                  },
                ),
              ),
              
              // My Location
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.1 * 255).round()),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: IconButton(
                  icon: Icon(Icons.my_location),
                  onPressed: () {
                    // In a real app, get current location and move map
                    // For now, just move to Saint Louis University campus
                    _mapController.move(LatLng(38.6368, -90.2336), 15.0);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}