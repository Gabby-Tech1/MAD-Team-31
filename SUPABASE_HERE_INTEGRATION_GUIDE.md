# ParkRight App - Complete Supabase & HERE Maps Integration Guide

## Overview
This guide provides step-by-step instructions to set up the ParkRight Flutter application with Supabase backend services and HERE Maps integration.

## Prerequisites
- Flutter SDK (v3.9.2 or higher)
- Android Studio or VS Code
- Git account
- Internet connection

---

## Phase 1: Supabase Setup

### Step 1: Create Supabase Account
1. Visit https://supabase.com
2. Click "Start your project"
3. Sign up with GitHub, Google, or email
4. Verify your email if using email signup

### Step 2: Create Project
1. Click "New project" in your dashboard
2. Fill in project details:
   - **Name:** `parkright-app`
   - **Database Password:** Create a strong password (save it!)
   - **Region:** Choose closest region (e.g., "West EU (London)")
3. Click "Create new project"
4. Wait 2-3 minutes for setup completion

### Step 3: Get API Keys
1. Go to Settings → API in your project dashboard
2. Copy these values:
   - **Project URL:** `https://xxxxx.supabase.co`
   - **anon/public key:** (starts with `eyJ...`)
   - **service_role key:** (starts with `eyJ...`) - keep secret!

### Step 4: Set Up Authentication
1. Go to Authentication → Settings
2. Enable "Enable phone confirmations"
3. Enable "Enable signup"
4. Save changes

### Step 5: Create Database Tables

#### Profiles Table (extends auth.users)
```sql
-- This table is automatically created by Supabase Auth
-- But you can add additional fields if needed
```

#### Vehicles Table
```sql
CREATE TABLE vehicles (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  make TEXT NOT NULL,
  model TEXT NOT NULL,
  year INTEGER,
  license_plate TEXT NOT NULL,
  color TEXT,
  vehicle_image_url TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### Parking Spots Table
```sql
CREATE TABLE parking_spots (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  owner_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  description TEXT,
  address TEXT NOT NULL,
  latitude DECIMAL(10, 8) NOT NULL,
  longitude DECIMAL(11, 8) NOT NULL,
  price_per_hour DECIMAL(10, 2) NOT NULL,
  is_available BOOLEAN DEFAULT true,
  images TEXT[],
  amenities TEXT[],
  rules TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

#### Bookings Table
```sql
CREATE TABLE bookings (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
  parking_spot_id UUID REFERENCES parking_spots(id) ON DELETE CASCADE,
  vehicle_id UUID REFERENCES vehicles(id) ON DELETE CASCADE,
  start_time TIMESTAMP WITH TIME ZONE NOT NULL,
  end_time TIMESTAMP WITH TIME ZONE NOT NULL,
  total_price DECIMAL(10, 2) NOT NULL,
  status TEXT DEFAULT 'confirmed',
  payment_status TEXT DEFAULT 'pending',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
```

### Step 6: Set Up Storage
1. Go to Storage in your dashboard
2. Create buckets:
   - `vehicle-images` (public)
   - `parking-spot-images` (public)
   - `avatars` (public)

---

## Phase 2: HERE Maps Setup

### Step 1: Create HERE Account
1. Visit https://platform.here.com
2. Click "Get Started" or "Sign Up"
3. Create account with your email
4. Verify email

### Step 2: Create Project
1. Click "Create Project"
2. Name: `parkright-maps`
3. Choose "Freemium" plan (free)
4. Click "Create Project"

### Step 3: Get API Key
1. Go to Projects → your project
2. Go to "API Keys" section
3. Click "Generate API Key"
4. Copy the API Key

---

## Phase 3: Flutter App Configuration

### Step 1: Update Dependencies
Your `pubspec.yaml` should include:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # Existing dependencies...
  cupertino_icons: ^1.0.8
  flutter_svg: ^2.0.9
  page_transition: ^2.1.0
  animated_text_kit: ^4.2.2
  image_picker: ^1.0.7
  permission_handler: ^11.3.0
  flutter_map: ^6.1.0
  latlong2: ^0.9.0
  provider: ^6.1.1
  intl: ^0.19.0

  # New Supabase dependencies
  supabase_flutter: ^2.0.0

  # New HERE Maps dependencies
  http: ^1.1.0
  geocoding: ^2.1.0
  geolocator: ^10.0.0

  # Additional utilities
  shared_preferences: ^2.2.0
  connectivity_plus: ^5.0.0
  cached_network_image: ^3.3.0
```

### Step 2: Configure API Keys
Update `lib/utils/config.dart`:

```dart
class Config {
  // Supabase Configuration - REPLACE WITH YOUR VALUES
  static const String supabaseUrl = 'YOUR_SUPABASE_PROJECT_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // HERE Maps Configuration - REPLACE WITH YOUR VALUES
  static const String hereApiKey = 'YOUR_HERE_API_KEY';

  // App Configuration
  static const String appName = 'ParkRight';
  static const int otpLength = 6;

  // Storage Bucket Names
  static const String vehicleImagesBucket = 'vehicle-images';
  static const String parkingSpotImagesBucket = 'parking-spot-images';
  static const String avatarsBucket = 'avatars';
}
```

### Step 3: Update main.dart
Your `lib/main.dart` should include Supabase initialization:

```dart
import 'package:supabase_flutter/supabase_flutter.dart';
// ... other imports ...

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseAnonKey,
  );

  // Initialize Google Maps
  await MapInitializer.initialize();

  // ... rest of your main function ...

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ParkingProvider()),
      ],
      child: const ParkRightApp(),
    ),
  );
}
```

---

## Phase 4: Testing the Integration

### Step 1: Install Dependencies
```bash
flutter pub get
```

### Step 2: Run the App
```bash
flutter run
```

### Step 3: Test Authentication Flow
1. Open the app
2. Go to Login screen
3. Enter phone number (e.g., +91 9876543210)
4. Click "Send Code"
5. Check Supabase Dashboard → Authentication → Logs for the OTP
6. Enter the 6-digit OTP
7. Should navigate to Home screen

### Step 4: Verify Database
1. Go to Supabase Dashboard → Table Editor
2. Check if user profile was created in `profiles` table
3. Check Authentication → Users for the authenticated user

---

## Phase 5: Troubleshooting

### Common Issues

#### 1. Supabase Connection Issues
- Verify API keys are correct in `config.dart`
- Check Supabase project is not paused
- Ensure project URL doesn't have trailing slashes

#### 2. Authentication Problems
- Verify phone authentication is enabled in Supabase
- Check SMS provider configuration (if using paid plan)
- Ensure correct phone number format (+country code)

#### 3. HERE Maps Issues
- Verify API key is valid and not expired
- Check HERE project has correct permissions
- Ensure API key restrictions allow your app

#### 4. Build Errors
- Run `flutter clean` then `flutter pub get`
- Check Flutter version compatibility
- Verify all imports are correct

### Debug Commands
```bash
# Check Flutter setup
flutter doctor

# Clean and rebuild
flutter clean
flutter pub get
flutter run

# Check for linting issues
flutter analyze

# Run tests
flutter test
```

---

## Phase 6: Next Steps

### Features to Implement
1. **Map Integration**: Update map screens to use HERE Maps
2. **Real Data**: Replace mock data with API calls
3. **Image Upload**: Implement Supabase Storage for photos
4. **Push Notifications**: Add real-time booking updates
5. **Payment Integration**: Add Stripe/PayPal payment processing
6. **Offline Support**: Cache data for offline usage

### Security Considerations
1. Never commit API keys to version control
2. Use environment variables for production
3. Implement proper error handling
4. Add input validation
5. Regular security audits

### Performance Optimization
1. Implement data caching
2. Optimize image loading
3. Use pagination for large datasets
4. Minimize API calls
5. Add loading states

---

## Support

If you encounter issues:
1. Check this documentation first
2. Review Supabase and HERE documentation
3. Check Flutter community forums
4. Create GitHub issues for bugs

## Version History

- **v1.0.0**: Initial Supabase & HERE Maps integration
- Basic authentication flow
- Database schema setup
- API service layer implementation

---

*This integration provides a solid foundation for a production-ready parking application with real backend services and professional mapping capabilities.*