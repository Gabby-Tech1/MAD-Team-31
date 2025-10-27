# 🚗 ParkRight – Smart Parking Slot Finder & Booking

**Internship:** Mobile App Development with Flutter (Early Remote Internship)  
**Team:** MAD Team 31  

---

## 📘 Project Overview

Finding a free parking space wastes time, energy, and patience — especially on college campuses during peak hours.  
**ParkRight** aims to streamline the parking process for students, staff, and administrators by allowing users to find and reserve parking slots in real time.

### 🎯 Purpose
- Locate vacant parking spaces instantly  
- Compare by price, distance, or parking rules  
- Book slots in advance  
- Get navigation and QR entry pass  
- Help admins track and manage parking efficiently  

---

## 🧑‍🤝‍🧑 Users

**Primary Users (Learners / Drivers):**  
Students, faculty, and staff who want to find, reserve, and pay for parking easily.  

**Secondary Users (Admins / Managers):**  
Campus facility or parking lot administrators managing slot availability, payments, and reports.

---

## 🔑 Key Features

| Feature | Description |
|----------|-------------|
| Real-Time Slot Detection | See live parking availability |
| Map-Based Interface | View and navigate to parking lots |
| Advance Booking | Reserve slots before arrival |
| Digital QR Permit | Get a digital pass for entry |
| Secure Payment | Pay with card or campus ID |
| Parking History | View previous bookings and payments |

---

## 🧭 Short User Journey

### 🚘 Learner / Driver Journey
Splash → *App intro*  
Onboarding → *Feature overview*  
Login / Sign Up → *User verification*  
Add Vehicle → *Enter car info*  
Home Map → *View nearby slots*  
Select Location → *Check availability*  
Choose Slot → *Pick time & rate*  
Payment → *Secure checkout*  
QR Code → *Digital entry pass*  
Scan at Gate → *Easy access*  
Park → *Occupy reserved slot*  
History → *View past bookings*

---

### 🧑‍💼 Admin Journey
Login → *Admin authentication*  
Dashboard → *Overview of lots*  
Slot Status → *Track live occupancy*  
Edit Slots → *Update price/timing*  
Monitor Bookings → *Check active users*  
Payment Summary → *View transactions*  
Reports → *Analyze usage trends*

---

## 🧩 Resources & Links

- 📄 [Project Proposal (DOCX)](./ParkRight_ProjectProposal.docx)  
- 🎨 [Figma Wireframe Design](https://www.figma.com/design/DgMsmf9gNq2AjGFZ8iqopb/MAD-Team-31?node-id=0-1&t=0DIiXRJG0E4RrAfa-1)  
- 💻 [GitHub Repository](https://github.com/Gabby-Tech1/MAD-Team-31)

---

🚗 Development Progress
What We've Accomplished

Week 1 - UI Implementation & App Architecture Setup

📱 Core UI Screens Developed

Splash Screen – App logo with fade transition animation to onboarding

Onboarding Screens – Introductory slides explaining app features with page indicators and animations

Login & Register Screens – User authentication interface with text fields and validation

Verification Screen – OTP verification layout for secure login

Home Screen – Central dashboard showing parking categories, nearby spots, and search bar

Parking Space Selection Screen – Map integration with selectable parking spots and live availability

Parking Detail Screen – Displays detailed information about the parking space, timings, and price

Booking Review Screen – Booking confirmation interface with price breakdown and summary

Parking Code Screen – Displays the generated parking access code after booking

History Screen – Shows user’s previous parking bookings with date, time, and location

Notifications Screen – Displays alerts and booking updates

Profile Screen – User profile with account info, settings, and logout option

---

🧩 Reusable Component Library

Custom text fields with validation

Primary button with rounded corners and animations

Bottom navigation bar with smooth page transitions

Search bar with icon and placeholder

Parking detail and history cards

Category selector component

Fade and pulse animations for interactivity

Empty state and onboarding title components

---

🎨 Design System Implementation

Color Palette: Blue (#007BFF), Light Gray (#F5F5F5), Black (#000000)

Typography: Poppins (Regular, Medium, SemiBold)

Layout System: Consistent spacing, rounded corners, and elevation for depth

Theme: Implemented through centralized app_theme.dart for dark/light modes

---

🔄 Navigation & User Flow

Bottom navigation with 4 main tabs (Home, History, Notifications, Profile)

Page-based routing handled by app_router.dart

Smooth transitions and animation between onboarding → login → main navigation flow

Map component initialized through map_initializer.dart for live location and parking spot selection

---

🗂️ Current Folder Structure

<img width="508" height="651" alt="Screenshot 2025-10-19 at 10 54 03 PM" src="https://github.com/user-attachments/assets/4bb664f3-fe90-4a26-8979-e6acfc3532de" />

---

🏗️ Architecture Explanation
1. Components/ - Reusable UI Components

Purpose: Contains shared widgets and UI elements used throughout the app.

Includes:

Buttons, text fields, and cards

Animation components (fade, pulse)

Category selectors and placeholders

Notification, profile, and onboarding UI parts

Benefits:

🚗 Reusability across screens

🧹 Cleaner codebase

🎨 Easy customization and updates

---

2. Screens/ - App UI and Feature Screens

Purpose: Contains all visual and interactive screens for the user journey.

Authentication Flow: Splash → Onboarding → Login → Register → Verification
Main App Flow: Home → Parking Selection → Parking Detail → Review → Code
User Management: History, Notifications, Profile

Benefits:

🚀 Feature-based modular organization

🔄 Easy navigation setup

📈 Supports future scalability

---

3. Utils/ - App Utilities & Configuration

Purpose: Holds constants, theming, and routing logic.

Files:

app_constants.dart: Global constant values

app_theme.dart: Defines color scheme, text styles, and theming

app_router.dart: Handles named routes and navigation

map_initializer.dart: Configures map integration and permissions

Benefits:

🧩 Centralized configuration

🔧 Easier maintenance

🌐 Consistent app-wide behavior

---

🛠️ Technologies Used

Framework: Flutter (Dart)

Architecture: Modular + Component-Based

Navigation: Custom router (app_router.dart)

State Management: Provider

Animations: Flutter AnimationController, Fade & Pulse Effects

Maps & Location: HERE Maps API for real-time parking data

Backend: Supabase (PostgreSQL database, authentication, real-time subscriptions)

UI Design System: Material 3 Principles

Storage: SharedPreferences for session management

Fonts: Poppins (Google Fonts)

---

Onboarding, Splash Screens

<img width="496" height="648" alt="image" src="https://github.com/user-attachments/assets/1e23b970-b516-42b8-b740-aa1e9516d983" />

---

Login Screens

<img width="496" height="648" alt="image" src="https://github.com/user-attachments/assets/22716184-1b19-4763-a574-a138b9570d26" />

---

Add Vehicle Screen

<img width="126" height="273" alt="image" src="https://github.com/user-attachments/assets/788d3447-ac17-40e2-8e8d-13b4e4fe7707" />

---

Location Selection Screen

<img width="295" height="269" alt="image" src="https://github.com/user-attachments/assets/6f7bfa40-2c6b-432a-9bdc-39288551a59c" />

---

Parking Detail Screen

<img width="119" height="258" alt="image" src="https://github.com/user-attachments/assets/bbb3e59c-f469-4f89-8fef-890c3ee2b01e" />

---

Booking Confirmation Screen

<img width="306" height="199" alt="image" src="https://github.com/user-attachments/assets/b1c697b7-a333-4b6d-bae9-8d501cd425d0" />

---

Parking Space Selection Screen

<img width="279" height="186" alt="image" src="https://github.com/user-attachments/assets/297ea09c-b457-405d-9c63-9c457e77f9c1" />

---

Parking Code Screen

<img width="119" height="259" alt="image" src="https://github.com/user-attachments/assets/8c78ac59-86d9-4c66-bae0-7c55e3de95e0" />

---

ParkRight Profile, Notifications, History Screens

<img width="468" height="313" alt="image" src="https://github.com/user-attachments/assets/0ef83c48-637d-4960-86b7-54965d4ab8a5" />

---

## 🔧 Backend Integration

### Supabase Setup
- **Database**: PostgreSQL with Row Level Security (RLS) policies
- **Authentication**: User login/signup with email verification
- **Tables**: 
  - `users`: User profiles and authentication data
  - `vehicles`: User vehicle information
  - `bookings`: Parking booking records with status and payment tracking
  - `parking_spots`: HERE API parking data integration
- **Real-time**: Live updates for parking availability and booking status

### Key Features Implemented
- User authentication with secure login/logout
- Vehicle management for booking purposes
- Booking creation with payment status tracking
- Real-time parking spot availability via HERE Maps integration

---

## 🌐 API Integrations

### HERE Maps API
- **Purpose**: Real-time parking spot discovery and location data
- **Features**: 
  - Nearby parking search within specified radius
  - Parking garage and lot information
  - Location coordinates and accessibility data
  - Distance calculations from user location
- **Integration**: RESTful API calls with JSON response parsing
- **Rate Limiting**: Configured for optimal performance

---

## 🚀 Recent Developments & Fixes

### Week 2-3 - Backend Integration & Booking System

#### ✅ Completed Features
- **Supabase Integration**: Full backend setup with authentication and database
- **HERE Maps Integration**: Real-time parking spot data fetching and display
- **Booking System**: Complete booking flow from selection to confirmation
- **User Authentication**: Login, registration, and profile management
- **Vehicle Management**: Add, edit, and select vehicles for booking
- **Map Interface**: Interactive map with parking spot markers and selection

#### 🔧 Code Fixes & Improvements
- **Booking Model Serialization**: Fixed `toJson()` method to exclude auto-generated fields (`id`, `created_at`)
- **Error Handling**: Enhanced error messages for missing vehicles and booking failures
- **Vehicle Validation**: Added checks to ensure selected vehicle exists before booking
- **Payment Status**: Implemented proper payment status tracking in bookings
- **UI Responsiveness**: Fixed layout issues and improved user experience

#### 🐛 Known Issues & Feedback
- **RLS Policy Configuration**: Booking creation fails due to Supabase Row Level Security policies blocking inserts. Users must configure RLS policies in Supabase dashboard to allow authenticated users to create bookings.
- **Payment Status Constraint**: Database constraint violation for `bookings_payment_status_check` - ensure payment status values match allowed enum values.
- **UI Layout Issues**: 
  - `setState()` called during build phase in map component
  - RenderFlex overflow in some screens (248 pixels on right)
- **Performance**: Multiple HERE API calls during map initialization causing temporary UI freezes
- **Linting Warnings**: Numerous deprecated member uses (e.g., `withOpacity`) and unused code that should be cleaned up

---

## 📋 Setup Instructions

### Prerequisites
- Flutter SDK (3.9.2+)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Supabase account and project
- HERE Maps API key

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Gabby-Tech1/MAD-Team-31.git
   cd parkright
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Supabase**
   - Create a new project at [supabase.com](https://supabase.com)
   - Copy your project URL and anon key
   - Update `lib/services/api_service.dart` with your credentials:
     ```dart
     static const String supabaseUrl = 'your-supabase-url';
     static const String supabaseAnonKey = 'your-anon-key';
     ```

4. **Configure HERE Maps API**
   - Get API key from [HERE Developer Portal](https://developer.here.com/)
   - Update `lib/services/map_service.dart` with your API key:
     ```dart
     static const String apiKey = 'your-here-api-key';
     ```

5. **Database Setup**
   - Run the SQL scripts in Supabase dashboard to create tables
   - Configure Row Level Security (RLS) policies for bookings table:
     ```sql
     -- Allow authenticated users to insert their own bookings
     CREATE POLICY "Users can create their own bookings" ON bookings
     FOR INSERT WITH CHECK (auth.uid() = user_id);
     ```

6. **Run the App**
   ```bash
   flutter run
   ```

### Environment Configuration
- Copy `credentials.properties.example` to `credentials.properties`
- Fill in your API keys and configuration values

---

## 📦 Dependencies

### Core Dependencies
- `flutter`: UI framework
- `supabase_flutter`: Backend integration
- `provider`: State management
- `flutter_map`: Map display
- `geolocator`: Location services
- `http`: API calls

### UI & Animation
- `flutter_svg`: SVG image support
- `google_fonts`: Custom typography
- `intl`: Internationalization
- `shared_preferences`: Local storage

### Development
- `flutter_lints`: Code linting
- `flutter_test`: Unit testing

For a complete list, see `pubspec.yaml`.

---

## 🐛 Troubleshooting

### Common Issues

1. **Booking Creation Fails**
   - Check Supabase RLS policies are enabled and configured correctly
   - Verify user authentication status
   - Ensure selected vehicle exists in database

2. **HERE Maps Not Loading**
   - Verify API key is valid and has correct permissions
   - Check internet connection
   - Ensure location permissions are granted

3. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Check Flutter and Dart versions
   - Resolve any dependency conflicts

4. **UI Layout Issues**
   - Test on different screen sizes
   - Check for overflow errors in console
   - Adjust responsive design breakpoints

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is part of the Mobile App Development Internship program.

---

## 🛠️ Flutter Setup (Default)

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

### ✨ Developed by MAD Team 31
*Innovating smarter mobility for campus communities.*

