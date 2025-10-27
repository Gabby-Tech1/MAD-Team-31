import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:parkright/models/parking_spot.dart';
import 'package:parkright/providers/parking_provider.dart';
import 'package:parkright/services/map_service.dart';
import 'dart:async';

class MapComponent extends StatefulWidget {
  final Function(ParkingSpot) onSpotSelected;
  final VoidCallback? onMapError;
  final List<ParkingSpot>? hereApiParkingSpots;

  const MapComponent({
    super.key,
    required this.onSpotSelected,
    this.onMapError,
    this.hereApiParkingSpots,
  });

  @override
  State<MapComponent> createState() => _MapComponentState();
}

class _MapComponentState extends State<MapComponent> {
  final MapController _mapController = MapController();
  final MapService _mapService = MapService();

  // Initial center position (Saint Louis University, USA)
  static final LatLng _initialCenter = LatLng(38.6368, -90.2336); // Saint Louis University center

  // List of marker layers
  List<Marker> _markers = [];
  bool _isMapLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadParkingSpots();

    // Add a slight delay to check if map loads properly
    Future.delayed(Duration(seconds: 2), () {
      if (!_isMapLoaded && mounted) {
        if (widget.onMapError != null) {
          widget.onMapError!();
        }
      }
    });
  }

  @override
  void didUpdateWidget(MapComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if HERE API spots have changed
    if (widget.hereApiParkingSpots != oldWidget.hereApiParkingSpots) {
      print('HERE API spots updated, reloading markers');
      _loadParkingSpots();
    }
  }

  // Load parking spots from provider
  void _loadParkingSpots() async {
    final parkingProvider = Provider.of<ParkingProvider>(context, listen: false);
    await parkingProvider.loadNearbyParkingSpots(_initialCenter, radius: 2000);

    // Combine Supabase spots with HERE API spots
    final allSpots = [...parkingProvider.parkingSpots];
    if (widget.hereApiParkingSpots != null) {
      allSpots.addAll(widget.hereApiParkingSpots!);
      print('MapComponent received ${widget.hereApiParkingSpots!.length} HERE API spots');
    }

    print('Total spots to display: ${allSpots.length}');
    _createMarkers(allSpots);
  }

  // Search for location using HERE API
  Future<void> _searchLocation(String query) async {
    try {
      final latLng = await _mapService.geocodeAddress(query);

      // Move map to searched location
      _mapController.move(latLng, 15.0);

      // Load parking spots near the searched location
      final parkingProvider = Provider.of<ParkingProvider>(context, listen: false);
      await parkingProvider.loadNearbyParkingSpots(latLng, radius: 2000);

      // Combine Supabase spots with HERE API spots
      final allSpots = [...parkingProvider.parkingSpots];
      if (widget.hereApiParkingSpots != null) {
        allSpots.addAll(widget.hereApiParkingSpots!);
      }

      _createMarkers(allSpots);
    } catch (e) {
      // Handle search error
      print('Search error: $e');
    }
  }

  // Create map markers from parking spots
  void _createMarkers(List<ParkingSpot> parkingSpots) {
    setState(() {
      _markers = parkingSpots.map((spot) => 
        Marker(
          point: spot.location,
          width: 60,  // Increased width
          height: 60, // Increased height
          child: GestureDetector(
            onTap: () => widget.onSpotSelected(spot),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Important: take minimum vertical space
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
                    spot.title,
                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis, // Handle text overflow
                    maxLines: 1, // Limit to one line
                  ),
                )
              ],
            ),
          ),
        )
      ).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParkingProvider>(
      builder: (context, parkingProvider, child) {
        // Only update markers if we don't have HERE API spots
        // (HERE API spots are handled in _loadParkingSpots)
        if (widget.hereApiParkingSpots == null && parkingProvider.parkingSpots.isNotEmpty && _markers.length != parkingProvider.parkingSpots.length) {
          _createMarkers(parkingProvider.parkingSpots);
        }

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
                        // Center map on Saint Louis University campus
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
        
        // Search Bar
        Positioned(
          top: 16,
          left: 16,
          right: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              onSubmitted: _searchLocation,
            ),
          ),
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
                    // For now, center map on Saint Louis University campus
                    _mapController.move(LatLng(38.6368, -90.2336), 15.0);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
        );
      },
    );
  }
}