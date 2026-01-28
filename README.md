# Mokrabela

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-v3.10.7-blue.svg" alt="Flutter Version">
  <img src="https://img.shields.io/badge/Firebase-Supported-orange.svg" alt="Firebase Support">
  <img src="https://img.shields.io/badge/Platforms-Android%20%7C%20iOS%20%7C%20Windows-green.svg" alt="Platform Support">
  <img src="https://img.shields.io/badge/Localizations-EN%20%7C%20AR%20%7C%20FR-blueviolet.svg" alt="Localizations">
</p>

**Mokrabela** is a state-of-the-art Flutter application designed to empower children with emotional self-regulation. By combining gamified breathing exercises with real-time biofeedback and structured therapeutic protocols, Mokrabela bridges the gap between clinical monitoring and child-friendly engagement.

---

- [Key Features](#key-features)
- [Technology Stack](#technology-stack)
- [Hardware Integration](#hardware-integration)
- [Getting Started](#getting-started)
- [Testing](#testing)
- [Project Architecture](#project-architecture)
- [Localization](#localization)

---

## Key Features

### For Children 🧸
- **Gamified Biofeedback**: Real-time heart rate and HRV visualization channeled through interactive exercises.
- **5-Week Protocol**: A clinically-structured path to building long-term emotional resilience.
- **Dynamic Reward System**: Achievement-based progression with points, badges, and milestones.
- **Seamless Connectivity**: Automatic BLE pairing with compatible biometric sensors.

### For Parents & Teachers 👨‍👩‍👧‍👦
- **Advanced Analytics**:
  - **Activity Trends**: Heatmaps and bar charts of session frequency.
  - **Stress Regulation**: Before/After stress reduction analysis using regression trends.
  - **Compliance Tracking**: Real-time monitoring of protocol adherence.
- **Professional Reporting**: One-tap generation of PDF and CSV reports optimized for therapy reviews.
- **Multi-Child Support**: Effortlessly manage profiles across different environments (Home/School).

---

## Technology Stack

| Category | Technology |
| :--- | :--- |
| **Framework** | ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=flat&logo=flutter&logoColor=white) |
| **Logic** | ![Dart](https://img.shields.io/badge/Dart-0175C2?style=flat&logo=dart&logoColor=white) |
| **Database** | ![Firestore](https://img.shields.io/badge/Cloud_Firestore-FFCA28?style=flat&logo=firebase&logoColor=black) ![RTDB](https://img.shields.io/badge/Realtime_Database-FFA000?style=flat&logo=firebase&logoColor=black) |
| **Auth** | ![Firebase Auth](https://img.shields.io/badge/Firebase_Auth-FF8F00?style=flat&logo=firebase&logoColor=black) |
| **Charts** | `fl_chart` (Custom Graphics) |
| **BLE** | `flutter_blue_plus` |

---

## Hardware Integration

Mokrabela is optimized for low-latency biofeedback via **Bluetooth Low Energy (BLE)**.
- **Supported Sensors**: Polar H10, Garmin HRM-Pro, and most standard BLE Heart Rate Monitors.
- **Metrics Tracked**: BPM, R-R Intervals (HRV), and signal stability.

---

## Getting Started

### Prerequisites
- [Flutter SDK v3.x](https://flutter.dev/docs/get-started/install)
- [Firebase project](https://console.firebase.google.com/) configuration.

### Installation
1. **Clone the Repo**
   ```bash
   git clone https://github.com/rahim2306/mokrabela.git
   ```
2. **Setup Dependencies**
   ```bash
   flutter pub get
   ```
3. **Configurations**
   Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective platform folders.

---

## Testing

Mokrabela maintains high stability through a suite of widget and unit tests.

```bash
# Run all tests
flutter test

# Run Parent Dashboard specific tests
flutter test test/parent_stats_tab_test.dart
flutter test test/parent_home_tab_test.dart
```

---

## Project Architecture

The project follows a modular architecture designed for scalability:
- **`lib/services/`**: Independent service layer for Firebase, BLE, and Stats aggregation.
- **`lib/models/`**: Strongly-typed data definitions ensuring type safety.
- **`lib/screens/`**: Clean UI separation for Parent, Child, and Teacher roles.
- **`lib/l10n/`**: Fully internationalized strings via ARB files.

---

## Localization

| Language | Support | Direction |
| :--- | :--- | :--- |
| **English** | Full | LTR |
| **Arabic** | Full | **RTL** |
| **French** | Full | LTR |

---

<p align="center">
  <b>built with tears by Abderrahim Hadj-Slimane.</b>
</p>
