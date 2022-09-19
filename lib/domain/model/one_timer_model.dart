class OneTimerModel {
  final int videoId;
  final String yId;
  int? seconds;
  bool hasTimer;
  bool isPaused;
  OneTimerModel({
    required this.videoId,
    required this.yId,
    this.hasTimer = false,
    this.isPaused = false,
    this.seconds,
  });
}
