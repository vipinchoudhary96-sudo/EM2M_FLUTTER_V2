class ProtocolConstants {
  static const int requestTimeoutMs = 3000;
  static const int feedbackWaitMs = 5000;
  static const int maxReconnectAttempts = 5;

  // Freeze these UUIDs together with ESP32 firmware before production BLE use.
  static const serviceUuid = '0000EM20-0000-1000-8000-00805F9B34FB';
  static const commandUuid = '0000EM21-0000-1000-8000-00805F9B34FB';
  static const statusUuid = '0000EM22-0000-1000-8000-00805F9B34FB';
}
