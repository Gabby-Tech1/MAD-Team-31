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

## 🚗 Development Progress
What We've Accomplished

## Week 1 - UI Implementation & App Architecture Setup

--

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

--

## 🧩 Reusable Component Library

Custom text fields with validation

Primary button with rounded corners and animations

Bottom navigation bar with smooth page transitions

Search bar with icon and placeholder

Parking detail and history cards

Category selector component

Fade and pulse animations for interactivity

Empty state and onboarding title components

--

## 🎨 Design System Implementation

Color Palette: Blue (#007BFF), Light Gray (#F5F5F5), Black (#000000)

Typography: Poppins (Regular, Medium, SemiBold)

Layout System: Consistent spacing, rounded corners, and elevation for depth

Theme: Implemented through centralized app_theme.dart for dark/light modes

--

## 🔄 Navigation & User Flow

Bottom navigation with 4 main tabs (Home, History, Notifications, Profile)

Page-based routing handled by app_router.dart

Smooth transitions and animation between onboarding → login → main navigation flow

Map component initialized through map_initializer.dart for live location and parking spot selection

--

## 🗂️ Current Folder Structure
lib/
│
├── components/                  # Reusable and shared UI components
│   ├── bottom_nav_bar.dart
│   ├── category_selector_component.dart
│   ├── custom_text_field.dart
│   ├── primary_button.dart
│   ├── search_bar_component.dart
│   ├── parking_detail_component.dart
│   ├── parking_history_card.dart
│   ├── parking_spot_selection_card.dart
│   ├── notification_item_card.dart
│   ├── empty_state_component.dart
│   ├── fade_slide_animation.dart
│   ├── pulse_animation.dart
│   └── svg_image.dart
│
├── screens/                     # App Screens (UI layer)
│   ├── splash_screen.dart
│   ├── onboarding_screen.dart
│   ├── login_screen.dart
│   ├── register_screen.dart
│   ├── verification_screen.dart
│   ├── home_screen.dart
│   ├── parking_space_selection_screen.dart
│   ├── parking_detail_screen.dart
│   ├── booking_review_screen.dart
│   ├── parking_code_screen.dart
│   ├── history_screen.dart
│   ├── notifications_screen.dart
│   ├── profile_screen.dart
│   └── main_navigation_screen.dart
│
├── utils/
│   ├── app_constants.dart
│   ├── app_router.dart
│   ├── app_theme.dart
│   └── map_initializer.dart
│
└── main.dart                    # App entry point


--

## 🏗️ Architecture Explanation
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

--

## 2. Screens/ - App UI and Feature Screens

Purpose: Contains all visual and interactive screens for the user journey.

Authentication Flow: Splash → Onboarding → Login → Register → Verification
Main App Flow: Home → Parking Selection → Parking Detail → Review → Code
User Management: History, Notifications, Profile

Benefits:

🚀 Feature-based modular organization

🔄 Easy navigation setup

📈 Supports future scalability

--

## 3. Utils/ - App Utilities & Configuration

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

--

## 🛠️ Technologies Used

Framework: Flutter (Dart)

Architecture: Modular + Component-Based

Navigation: Custom router (app_router.dart)

State Management: Provider (planned)

Animations: Flutter AnimationController, Fade & Pulse Effects

Maps & Location: Google Maps SDK (via map_initializer.dart)

UI Design System: Material 3 Principles

Storage: SharedPreferences (planned for session management)

Fonts: Poppins (Google Fonts)
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

