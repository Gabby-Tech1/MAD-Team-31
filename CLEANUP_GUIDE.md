# Flutter Code Cleanup Guide

We've fixed several linting issues in your codebase after replacing Google Maps with OpenStreetMap. Here's a summary of the changes made and recommendations for addressing the remaining issues.

## Fixed Issues

1. **Fixed unused imports**:
   - Removed `custom_text_field.dart` import from `add_vehicle_screen.dart`
   - Removed unnecessary `flutter/foundation.dart` import from `map_initializer.dart`

2. **Fixed deprecated methods**:
   - Replaced `Colors.black.withOpacity(0.1)` with `Colors.black.withAlpha((0.1 * 255).round())` in map_component.dart 

3. **Updated to use super parameters**:
   - Changed `MapComponent` constructor to use `super.key`
   - Changed `MapPlaceholder` constructor to use `super.key`

## Remaining Issues to Address

### 1. Super Parameter Usage

Replace the pattern `Key? key, ... }) : super(key: key);` with `super.key, ... });` in all the following files:

- `lib/components/category_selector_component.dart`
- `lib/components/custom_text_field.dart`
- `lib/components/fade_slide_animation.dart`
- `lib/components/onboarding_title.dart`
- `lib/components/page_indicator.dart`
- `lib/components/parking_detail_component.dart`
- `lib/components/parking_spot_selection_card.dart`
- `lib/components/primary_button.dart`
- `lib/components/pulse_animation.dart`
- `lib/components/search_bar_component.dart`
- `lib/components/svg_image.dart`
- `lib/screens/add_vehicle_screen.dart`
- `lib/screens/home_screen.dart`
- `lib/screens/login_screen.dart`
- `lib/screens/onboarding_screen.dart`
- `lib/screens/parking_detail_screen.dart`
- `lib/screens/register_screen.dart`
- `lib/screens/splash_screen.dart`
- `lib/screens/verification_screen.dart`

### 2. Replace `withOpacity` with `withAlpha`

Replace all occurrences of `.withOpacity(0.x)` with `.withAlpha((0.x * 255).round())` in:

- `lib/components/parking_spot_selection_card.dart`
- `lib/components/search_bar_component.dart`
- `lib/screens/home_screen.dart`
- `lib/screens/login_screen.dart`
- `lib/screens/register_screen.dart`

### 3. Other Issues

- In `primary_button.dart`: Replace the `Padding(padding: ...)` with `const SizedBox(width: ...)` for whitespace
- In `models/parking_spot.dart`: Remove unnecessary braces in string interpolation (`'${pricePerHour}'` -> `'$pricePerHour'`)
- In `screens/home_screen.dart` and `screens/splash_screen.dart`: Fix `use_build_context_synchronously` issues by checking the `mounted` property

## OpenStreetMap Implementation

The app now uses OpenStreetMap via the `flutter_map` package instead of Google Maps. This implementation:

1. Doesn't require an API key
2. Uses freely available map tiles
3. Provides custom controls for zoom and location
4. Has a fallback UI for when the map can't load

## Testing

After making these changes, you should test the application to ensure:
1. The map loads correctly
2. Markers display properly
3. Interactions work as expected (zooming, panning, selecting spots)
4. The fallback UI shows when necessary

## Future Improvements

1. Consider adding map caching for offline use
2. Implement custom map styles
3. Add proper attribution for OpenStreetMap as required by their license
4. Add actual geolocation using the device's GPS