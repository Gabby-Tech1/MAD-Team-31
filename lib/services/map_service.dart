import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import '../utils/config.dart';

class Place {
  final String title;
  final String address;
  final LatLng position;

  Place({required this.title, required this.address, required this.position});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'] ?? 'Unknown Place',
      address: json['address']?['label'] ?? 'Unknown Address',
      position: LatLng(
        json['position']?['lat'] ?? 0.0,
        json['position']?['lng'] ?? 0.0,
      ),
    );
  }
}

class MapService {
  final String _apiKey = Config.hereApiKey;

  // Search for parking spots
  Future<List<Place>> searchParkingSpots(LatLng center, {double radius = 5000}) async {
    // Use HERE Discover API (works with standard API key)
    final url = Uri.parse(
      'https://discover.search.hereapi.com/v1/discover?at=${center.latitude},${center.longitude}&q=parking&limit=20&apiKey=$_apiKey'
    );

    try {
      final response = await http.get(url);
      print('HERE API Response Status: ${response.statusCode}');
      print('HERE API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List;
        print('HERE API returned ${items.length} items');

        return items.map((item) => Place.fromJson(item)).toList();
      } else {
        throw Exception('Failed to search parking spots: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Network error in searchParkingSpots: $e');
      throw Exception('Network error: $e');
    }
  }

  // Geocode address to coordinates
  Future<LatLng> geocodeAddress(String address) async {
    final url = Uri.parse(
      'https://geocode.search.hereapi.com/v1/geocode?q=${Uri.encodeComponent(address)}&apiKey=$_apiKey'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List;
        if (items.isNotEmpty) {
          final position = items[0]['position'];
          return LatLng(position['lat'], position['lng']);
        } else {
          throw Exception('Address not found');
        }
      } else {
        throw Exception('Failed to geocode address: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Reverse geocode coordinates to address
  Future<String> reverseGeocode(LatLng position) async {
    final url = Uri.parse(
      'https://revgeocode.search.hereapi.com/v1/revgeocode?at=${position.latitude},${position.longitude}&apiKey=$_apiKey'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'] as List;
        if (items.isNotEmpty) {
          return items[0]['address']['label'] ?? 'Unknown location';
        } else {
          return 'Unknown location';
        }
      } else {
        throw Exception('Failed to reverse geocode: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Get route between two points
  Future<Map<String, dynamic>> getRoute(LatLng origin, LatLng destination) async {
    final url = Uri.parse(
      'https://router.hereapi.com/v8/routes?transportMode=car&origin=${origin.latitude},${origin.longitude}&destination=${destination.latitude},${destination.longitude}&return=summary&apiKey=$_apiKey'
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to get route: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}