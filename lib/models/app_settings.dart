class AppSettings {
  double onVoltage;
  double hysteresis;
  int onDelayMs;
  int offDelayMs;
  bool autoMode;
  int feedbackTimeoutMs;
  bool requireFeedback;
  bool allowRemoteControl;

  AppSettings({
    this.onVoltage = 48.000,
    this.hysteresis = 1.5,
    this.onDelayMs = 5000,
    this.offDelayMs = 5000,
    this.autoMode = true,
    this.feedbackTimeoutMs = 5000,
    this.requireFeedback = true,
    this.allowRemoteControl = true,
  });

  factory AppSettings.fromJson(Map<String, dynamic> j) => AppSettings(
    onVoltage: (j['on_voltage'] as num?)?.toDouble() ?? 48,
    hysteresis: (j['hysteresis'] as num?)?.toDouble() ?? 1.5,
    onDelayMs: (j['on_delay_ms'] as num?)?.toInt() ?? 5000,
    offDelayMs: (j['off_delay_ms'] as num?)?.toInt() ?? 5000,
    autoMode: j['auto_mode'] == true,
    feedbackTimeoutMs: (j['feedback_timeout_ms'] as num?)?.toInt() ?? 5000,
    requireFeedback: j['require_feedback'] != false,
    allowRemoteControl: j['allow_remote_control'] != false,
  );
}
