import 'package:test_video/core/mock_video_data.dart';
import 'package:test_video/domain/model/video_model.dart';

class VideoRepository {
  Future<List<VideoModel>> fetchVideoData() async {
    await Future.delayed(const Duration(seconds: 2));
    return MockVideoData.videoData;
  }
}
