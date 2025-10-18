# ParkRight Map Implementation

This document describes the map implementation in the ParkRight app.

## Overview

ParkRight uses OpenStreetMap through the `flutter_map` package instead of Google Maps. This implementation provides the following advantages:

1. **No API Key Required**: OpenStreetMap is free to use without any API key.
2. **Open Source**: OpenStreetMap is a collaborative open-source project.
3. **Custom Styling**: Full control over the map appearance.
4. **No Usage Limitations**: Not restricted by Google Maps API usage limits.

## Implementation Details

The map is implemented using:
- `flutter_map` package (v6.1.0)
- `latlong2` package (v0.9.0) for geographical coordinates

### Key Components

1. **MapComponent**: Displays the map with parking spots as markers.
2. **MapPlaceholder**: Shown when the map fails to load for any reason.
3. **MapInitializer**: Initializes the map resources during app startup.

### Structure

- `lib/components/map_component.dart`: Main map implementation
- `lib/components/map_placeholder.dart`: Fallback UI for map errors
- `lib/utils/map_initializer.dart`: Map initialization logic

## Usage

The MapComponent is designed to be used as follows:

```dart
MapComponent(
  onSpotSelected: (spot) {
    // Handle when a parking spot is selected
  },
  onMapError: () {
    // Handle any map loading errors
  },
)
```

## Customization

### Tile Sources

By default, the map uses OpenStreetMap's standard tile server:

```dart
TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'com.parkright.app',
)
```

You can customize this to use other tile sources or styling options.

### Markers

Markers are customizable through the `MarkerLayer` component. The current implementation uses a simple location icon with the spot name beneath it.

## Permissions

While no API key is required, the app still needs location permissions to show the user's current location on the map. Make sure the proper permissions are set in:

- Android: AndroidManifest.xml
- iOS: Info.plist

## Attribution

When using OpenStreetMap, proper attribution is required according to their license:

```
© OpenStreetMap contributors
```

This is typically shown in a corner of the map.