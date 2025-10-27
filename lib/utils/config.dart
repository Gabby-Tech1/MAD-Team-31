class Config {
  // Supabase Configuration
  static const String supabaseUrl = 'https://qsfcnnatkwwzieigftrf.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFzZmNubmF0a3d3emllaWdmdHJmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE0MzU3NDksImV4cCI6MjA3NzAxMTc0OX0.xc6cw3tC-P1kx-Lanj5lfeK3up2_MXu9f7Gc1rWPdQI';

  // HERE Maps Configuration
  static const String hereApiKey = 'PUHHzIgjYra4TWDAisBgc9DWQwwIJ5_Y16yOi9fWBCY';
  static const String hereGeocodeUrl = 'https://geocode.search.hereapi.com/v1/geocode';
  static const String hereRoutingUrl = 'https://router.hereapi.com/v8/routes';
  static const String herePlacesUrl = 'https://places.ls.hereapi.com/places/v1/discover/search';

  // App Configuration
  static const String appName = 'ParkRight';
  static const int otpLength = 6;
  static const int otpTimeoutSeconds = 300; // 5 minutes
  static const double defaultSearchRadius = 5000; // 5km in meters
  static const int maxRetryAttempts = 3;

  // Storage Bucket Names
  static const String vehicleImagesBucket = 'vehicle-images';
  static const String parkingSpotImagesBucket = 'parking-spot-images';
  static const String avatarsBucket = 'avatars';
}