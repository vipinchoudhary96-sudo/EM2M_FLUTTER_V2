class EventRecord {
  final DateTime time;
  final String type;
  final String message;
  final String severity;

  const EventRecord({
    required this.time,
    required this.type,
    required this.message,
    required this.severity,
  });

  factory EventRecord.fromJson(Map<String, dynamic> j) => EventRecord(
    time: DateTime.tryParse('${j['time']}') ?? DateTime.now(),
    type: '${j['type'] ?? ''}',
    message: '${j['message'] ?? ''}',
    severity: '${j['severity'] ?? 'info'}',
  );
}
