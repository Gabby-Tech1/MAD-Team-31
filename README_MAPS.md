# ParkRight App Setup

## Google Maps Configuration

To make the map feature work correctly in this app, you need to add your Google Maps API key:

### For Android:

1. Open `android/app/src/main/AndroidManifest.xml`
2. Find this section:
   ```xml
   <meta-data
       android:name="com.google.android.geo.API_KEY"
       android:value="YOUR_API_KEY_HERE" />
   ```
3. Replace `YOUR_API_KEY_HERE` with your actual Google Maps API key

### For iOS:

1. Open `ios/Runner/Info.plist`
2. Find this section:
   ```xml
   <key>GMSApiKey</key>
   <string>YOUR_API_KEY_HERE</string>
   ```
3. Replace `YOUR_API_KEY_HERE` with your actual Google Maps API key

## Getting a Google Maps API Key

1. Go to the [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project (or select an existing one)
3. Enable the Google Maps API for Android and iOS
4. Create credentials to get your API key
5. Add restrictions to your API key for security

## Running the app

After adding your API key, run the app using:

```
flutter pub get
flutter run
```

## Features

The app includes:
- Map view with parking spot markers
- Parking spot selection
- Detailed view of parking spots
- Booking functionality for parking spots