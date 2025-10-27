import 'dart:typed_data';
import 'dart:math';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:latlong2/latlong.dart';
import '../models/parking_spot.dart';
import '../models/booking.dart';
import '../models/vehicle.dart';

class ApiService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Get nearby parking spots
  Future<List<ParkingSpot>> getNearbyParkingSpots(LatLng location, double radius) async {
    try {
      final data = await _supabase
          .from('parking_spots')
          .select()
          .eq('is_available', true);

      final spots = (data as List).map((json) => ParkingSpot.fromJson(json)).toList();
      
      // Filter spots by distance (temporary client-side filtering)
      // In production, this should be done with PostGIS geospatial queries
      return spots.where((spot) {
        final distance = _calculateDistance(location, spot.location);
        return distance <= radius;
      }).toList();
    } catch (e) {
      throw Exception('Failed to load parking spots: $e');
    }
  }

  // Calculate distance between two LatLng points using Haversine formula
  double _calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371000; // Earth's radius in meters
    
    final double lat1Rad = point1.latitude * (pi / 180);
    final double lat2Rad = point2.latitude * (pi / 180);
    final double deltaLatRad = (point2.latitude - point1.latitude) * (pi / 180);
    final double deltaLngRad = (point2.longitude - point1.longitude) * (pi / 180);
    
    final double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(deltaLngRad / 2) * sin(deltaLngRad / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    
    return earthRadius * c;
  }

  // Create parking spot
  Future<ParkingSpot> createParkingSpot(ParkingSpot spot) async {
    try {
      final data = await _supabase
          .from('parking_spots')
          .insert(spot.toJson())
          .single();

      return ParkingSpot.fromJson(data);
    } catch (e) {
      throw Exception('Failed to create parking spot: $e');
    }
  }

  // Update parking spot
  Future<void> updateParkingSpot(String spotId, Map<String, dynamic> updates) async {
    try {
      await _supabase
          .from('parking_spots')
          .update(updates)
          .eq('id', spotId);
    } catch (e) {
      throw Exception('Failed to update parking spot: $e');
    }
  }

  // Get user vehicles
  Future<List<Vehicle>> getUserVehicles(String userId) async {
    try {
      final data = await _supabase
          .from('vehicles')
          .select()
          .eq('user_id', userId);

      return (data as List).map((json) => Vehicle.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load vehicles: $e');
    }
  }

  // Create vehicle
  Future<Vehicle> createVehicle(Vehicle vehicle) async {
    try {
      final data = await _supabase
          .from('vehicles')
          .insert(vehicle.toJson())
          .select()
          .single();

      return Vehicle.fromJson(data);
    } catch (e) {
      throw Exception('Failed to create vehicle: $e');
    }
  }

  // Update vehicle
  Future<void> updateVehicle(String vehicleId, Map<String, dynamic> updates) async {
    try {
      await _supabase
          .from('vehicles')
          .update(updates)
          .eq('user_id', vehicleId);
    } catch (e) {
      throw Exception('Failed to update vehicle: $e');
    }
  }

  // Get user bookings
  Future<List<Booking>> getUserBookings(String userId) async {
    try {
      final data = await _supabase
          .from('bookings')
          .select()
          .eq('user_id', userId)
          .order('created_at');

      return (data as List).map((json) => Booking.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load bookings: $e');
    }
  }

  // Create booking
  Future<Booking> createBooking(Booking booking) async {
    try {
      print('Creating booking with data: ${booking.toJson()}');
      final data = await _supabase
          .from('bookings')
          .insert(booking.toJson())
          .select()
          .single();

      print('Booking created successfully: $data');
      return Booking.fromJson(data);
    } catch (e) {
      print('Error creating booking: $e');
      throw Exception('Failed to create booking: $e');
    }
  }

  // Update booking
  Future<void> updateBooking(String bookingId, Map<String, dynamic> updates) async {
    try {
      await _supabase
          .from('bookings')
          .update(updates)
          .eq('id', bookingId);
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }

  // Upload image to storage
  Future<String> uploadImage(String bucket, String fileName, List<int> bytes, String contentType) async {
    try {
      final filePath = fileName;
      await _supabase.storage.from(bucket).uploadBinary(
        filePath,
        Uint8List.fromList(bytes),
        fileOptions: FileOptions(contentType: contentType),
      );

      final publicUrl = _supabase.storage.from(bucket).getPublicUrl(filePath);
      return publicUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Delete image from storage
  Future<void> deleteImage(String bucket, String fileName) async {
    try {
      await _supabase.storage.from(bucket).remove([fileName]);
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }
}