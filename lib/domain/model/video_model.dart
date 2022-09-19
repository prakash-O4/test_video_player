class VideoModel {
  final String title;
  final String url;
  final int repeat;
  int? numOfRepeatition;
  bool hasTimer;
  int? minute;
  int? seconds;
  VideoModel({
    required this.title,
    required this.url,
    required this.repeat,
    this.numOfRepeatition,
    this.minute,
    this.seconds,
    this.hasTimer = false,
  });
}
