EM2M FLUTTER V2
================

This is the expanded, maintainable V2 package.

Folder structure:
lib/
  models/       data models
  protocol/     API paths and protocol constants
  services/     Wi-Fi, Web, BLE, storage, API, connection and command logic
  providers/    application state
  screens/      complete app pages
  widgets/      reusable UI
  export/       CSV/report support
  theme/        theme
  utils/        constants/validation
assets/         startup logo

V2 features:
- Dashboard/live meter values
- Manual and automatic inverter operation
- Battery threshold 10.000–60.000 V
- Hysteresis 0.0–3.0 V
- Digit/cursor numeric editing
- Save + ESP32 read-back verification
- Mandatory feedback-confirmation workflow
- Wi-Fi
- Web server
- BLE transport abstraction
- Connection watchdog/reconnect architecture
- SD-card status
- Historical report API
- Date selection
- CSV generation
- Event/fault history
- Password storage
- Device/protocol separation
- ESP32 remains the authority

IMPORTANT HARDWARE/FIRMWARE CONTRACT:
Flutter cannot make unsupported ESP32 features magically work. The ESP32 V2
firmware must implement the API endpoints listed in lib/protocol/api_paths.dart.

Required endpoints:
GET  /api/status
GET  /api/settings
POST /api/settings
POST /api/inverter
GET  /api/history
GET  /api/events

The inverter command is NOT considered successful merely because POST succeeds.
Flutter polls actual feedback and only reports CONFIRMED when the ESP32 reports
the requested state and feedback_confirmed=true.

The ESP32 must continue automatically when the app is disconnected.

BLE:
The transport abstraction is present. Final ESP32-S3 GATT UUIDs and packet
format must be frozen jointly with firmware before enabling a real BLE package.
This prevents having to rewrite the UI later.

Reports:
Historical data is read from the ESP32 SD/history API. The app does not invent
records.

Run:
flutter pub get
flutter run
