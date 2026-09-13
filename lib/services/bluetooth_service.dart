class BluetoothService {
  bool connected = false;

  // Transport abstraction is ready. The ESP32-S3 GATT UUIDs must be frozen
  // in firmware before a platform BLE package is enabled.
  Future<void> connect() async {
    throw UnimplementedError('Bind final ESP32-S3 BLE GATT implementation here');
  }

  Future<void> disconnect() async => connected = false;
}
