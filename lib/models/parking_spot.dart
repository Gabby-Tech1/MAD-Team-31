import 'package:latlong2/latlong.dart';

class ParkingSpot {
  final String id;
  final String? ownerId; // Made nullable for system-generated spots
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
  final String? hereApiId; // External HERE API identifier

  ParkingSpot({
    required this.id,
    this.ownerId, // Made optional for system-generated spots
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
    this.hereApiId,
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
      hereApiId: json['here_api_id'],
    );
  }

  Map<String, dynamic> toJson({bool includeId = false}) {
    final json = {
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
      'here_api_id': hereApiId,
    };

    if (ownerId != null) {
      json['owner_id'] = ownerId;
    }

    if (includeId) {
      json['id'] = id;
    }

    return json;
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