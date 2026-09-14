class MeterData {
  final List<double?> values;
  final double batteryVoltage;
  final bool batteryValid;
  final String inverterActual;
  final String inverterRequested;
  final bool feedbackConfirmed;
  final bool sdAvailable;
  final bool espHealthy;
  final int sequence;
  final DateTime timestamp;

  const MeterData({
    required this.values,
    required this.batteryVoltage,
    required this.batteryValid,
    required this.inverterActual,
    required this.inverterRequested,
    required this.feedbackConfirmed,
    required this.sdAvailable,
    required this.espHealthy,
    required this.sequence,
    required this.timestamp,
  });

  factory MeterData.fromJson(Map<String, dynamic> j) {
    final raw = (j['meter'] as List?) ?? const [];
    return MeterData(
      values: raw.map<double?>((e) => e == null ? null : (e as num).toDouble()).toList(),
      batteryVoltage: (j['battery_voltage'] as num?)?.toDouble() ?? 0,
      batteryValid: j['battery_valid'] == true,
      inverterActual: '${j['inverter_actual'] ?? '--'}',
      inverterRequested: '${j['inverter_requested'] ?? '--'}',
      feedbackConfirmed: j['feedback_confirmed'] == true,
      sdAvailable: j['sd_available'] == true,
      espHealthy: j['esp_healthy'] != false,
      sequence: (j['sequence'] as num?)?.toInt() ?? 0,
      timestamp: DateTime.tryParse('${j['timestamp']}') ?? DateTime.now(),
    );
  }
}
