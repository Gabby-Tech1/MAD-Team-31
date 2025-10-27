class Vehicle {
  final String id;
  final String userId;
  final String make;
  final String model;
  final int? year;
  final String licensePlate;
  final String? color;
  final String? vehicleImageUrl;
  final DateTime createdAt;

  Vehicle({
    required this.id,
    required this.userId,
    required this.make,
    required this.model,
    this.year,
    required this.licensePlate,
    this.color,
    this.vehicleImageUrl,
    required this.createdAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      userId: json['user_id'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
      licensePlate: json['license_plate'],
      color: json['color'],
      vehicleImageUrl: json['vehicle_image_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'user_id': userId,
      'make': make,
      'model': model,
      'license_plate': licensePlate,
    };
    
    if (year != null) data['year'] = year;
    if (color != null) data['color'] = color;
    if (vehicleImageUrl != null) data['vehicle_image_url'] = vehicleImageUrl;
    
    return data;
  }

  String get displayName => '$year $make $model';
}