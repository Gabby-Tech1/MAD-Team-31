import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../services/api_service.dart';
import '../models/parking_spot.dart';
import '../models/booking.dart';
import '../models/vehicle.dart';

class ParkingProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<ParkingSpot> _parkingSpots = [];
  List<Booking> _userBookings = [];
  List<Vehicle> _userVehicles = [];
  bool _isLoading = false;
  String? _error;

  List<ParkingSpot> get parkingSpots => _parkingSpots;
  List<Booking> get userBookings => _userBookings;
  List<Vehicle> get userVehicles => _userVehicles;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Load nearby parking spots
  Future<void> loadNearbyParkingSpots(LatLng location, {double radius = 5000}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _parkingSpots = await _apiService.getNearbyParkingSpots(location, radius);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create parking spot
  Future<bool> createParkingSpot(ParkingSpot spot) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newSpot = await _apiService.createParkingSpot(spot);
      _parkingSpots.add(newSpot);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load user vehicles
  Future<void> loadUserVehicles(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userVehicles = await _apiService.getUserVehicles(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create vehicle
  Future<bool> createVehicle(Vehicle vehicle) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newVehicle = await _apiService.createVehicle(vehicle);
      _userVehicles.add(newVehicle);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Load user bookings
  Future<void> loadUserBookings(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userBookings = await _apiService.getUserBookings(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Create booking
  Future<bool> createBooking(Booking booking) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final newBooking = await _apiService.createBooking(booking);
      _userBookings.add(newBooking);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Failed to create booking: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Update booking status
  Future<bool> updateBookingStatus(String bookingId, String status) async {
    try {
      await _apiService.updateBooking(bookingId, {'status': status});
      final index = _userBookings.indexWhere((b) => b.id == bookingId);
      if (index != -1) {
        _userBookings[index] = Booking(
          id: _userBookings[index].id,
          userId: _userBookings[index].userId,
          parkingSpotId: _userBookings[index].parkingSpotId,
          vehicleId: _userBookings[index].vehicleId,
          startTime: _userBookings[index].startTime,
          endTime: _userBookings[index].endTime,
          totalPrice: _userBookings[index].totalPrice,
          status: status,
          paymentStatus: _userBookings[index].paymentStatus,
          createdAt: _userBookings[index].createdAt,
        );
        notifyListeners();
      }
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Upload image
  Future<String?> uploadImage(String bucket, String fileName, List<int> bytes, String contentType) async {
    try {
      return await _apiService.uploadImage(bucket, fileName, bytes, contentType);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}