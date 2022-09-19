import 'package:test_video/domain/model/video_model.dart';

class MockVideoData {
  static List<VideoModel> videoData = [
    VideoModel(
      title: "Sample Data",
      url:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      repeat: 5,
    ),
    VideoModel(
      title: "Sample Data",
      url:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      repeat: 15,
    ),
    VideoModel(
      title: "Sample Data",
      url:
          "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
      repeat: 10,
    ),
  ];
}
