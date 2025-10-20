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

State Management: Provider (planned)

Animations: Flutter AnimationController, Fade & Pulse Effects

Maps & Location: Google Maps SDK (via map_initializer.dart)

UI Design System: Material 3 Principles

Storage: SharedPreferences (planned for session management)

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

