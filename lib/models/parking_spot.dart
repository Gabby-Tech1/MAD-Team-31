import 'package:latlong2/latlong.dart';

class ParkingSpot {
  final String id;
  final String ownerId;
  final String title;
  final String? description;
  final String address;
  final LatLng location;
  final double pricePerHour;
  final bool isAvailable;
  final List<String> images;
  final List<String> amenities;
  final String? rules;
  final DateTime createdAt;
  final DateTime updatedAt;

  ParkingSpot({
    required this.id,
    required this.ownerId,
    required this.title,
    this.description,
    required this.address,
    required this.location,
    required this.pricePerHour,
    required this.isAvailable,
    required this.images,
    required this.amenities,
    this.rules,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParkingSpot.fromJson(Map<String, dynamic> json) {
    return ParkingSpot(
      id: json['id'],
      ownerId: json['owner_id'],
      title: json['title'],
      description: json['description'],
      address: json['address'],
      location: LatLng(json['latitude'], json['longitude']),
      pricePerHour: json['price_per_hour'].toDouble(),
      isAvailable: json['is_available'] ?? true,
      images: List<String>.from(json['images'] ?? []),
      amenities: List<String>.from(json['amenities'] ?? []),
      rules: json['rules'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': ownerId,
      'title': title,
      'description': description,
      'address': address,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'price_per_hour': pricePerHour,
      'is_available': isAvailable,
      'images': images,
      'amenities': amenities,
      'rules': rules,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  // Legacy getters for backward compatibility
  String get name => title;
  LatLng get position => location;
  int get availableSpots => isAvailable ? 1 : 0;
  int get distanceInMeters => 0; // This would need to be calculated based on user location

  // Get formatted price
  String get formattedPrice => '\$${pricePerHour.toStringAsFixed(2)}';

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
  double calculatePrice(int hours) {
    return pricePerHour * hours;
  }
}