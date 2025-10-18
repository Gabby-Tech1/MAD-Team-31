import 'package:latlong2/latlong.dart';

class ParkingSpot {
  final String id;
  final String name;
  final String address;
  final LatLng position;
  final int pricePerHour;
  final int availableSpots;
  final int distanceInMeters;
  final String? description;
  
  ParkingSpot({
    required this.id,
    required this.name,
    required this.address,
    required this.position,
    required this.pricePerHour,
    required this.availableSpots,
    required this.distanceInMeters,
    this.description,
  });
  
  // Get formatted price
  String get formattedPrice => '\$${pricePerHour}';
  
  // Get formatted distance
  String get formattedDistance {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters}m';
    } else {
      final double kilometers = distanceInMeters / 1000;
      return '${kilometers.toStringAsFixed(1)}km';
    }
  }
  
  // Calculate price for specified hours
  int calculatePrice(int hours) {
    return pricePerHour * hours;
  }
}