class Booking {
  final String id;
  final String userId;
  final String parkingSpotId;
  final String vehicleId;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice;
  final String status;
  final String paymentStatus;
  final DateTime createdAt;

  Booking({
    required this.id,
    required this.userId,
    required this.parkingSpotId,
    required this.vehicleId,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'],
      userId: json['user_id'],
      parkingSpotId: json['parking_spot_id'],
      vehicleId: json['vehicle_id'],
      startTime: DateTime.parse(json['start_time']),
      endTime: DateTime.parse(json['end_time']),
      totalPrice: json['total_price'].toDouble(),
      status: json['status'] ?? 'confirmed',
      paymentStatus: json['payment_status'] ?? 'pending',
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'parking_spot_id': parkingSpotId,
      'vehicle_id': vehicleId,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'total_price': totalPrice,
      'status': status,
      'payment_status': paymentStatus,
    };
  }

  Duration get duration => endTime.difference(startTime);
  int get hours => duration.inHours;
  double get pricePerHour => hours > 0 ? totalPrice / hours : 0;

  bool get isActive => status == 'active';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';
  bool get isPaid => paymentStatus == 'paid';
}