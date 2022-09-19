import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_video/domain/model/video_model.dart';
import 'package:test_video/domain/repository/video_repository.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  final VideoRepository videoRepository;
  VideoPlayerCubit({required this.videoRepository})
      : super(VideoPlayerInitial());

  void fetchVideo() async {
    emit(VideoPlayerLoading());
    List<VideoModel> videos = await videoRepository.fetchVideoData();
    emit(VideoPlayerLoaded(videos: _sortVideosByRepeat(videos)));
  }

  List<VideoModel> _sortVideosByRepeat(List<VideoModel> videos) {
    int length = videos.length;
    for (int i = 0; i < length - 1; i++) {
      for (int j = 0; j < length - i - 1; j++) {
        if (videos[j].repeat > videos[j + 1].repeat) {
          VideoModel temp = videos[j];
          videos[j] = videos[j + 1];
          videos[j + 1] = temp;
        }
      }
    }
    return _calculateNumOfRepition(videos);
  }

  List<VideoModel> _calculateNumOfRepition(List<VideoModel> videos) {
    for (var i = 1; i < videos.length; i++) {
      double repeatValue = videos[i].repeat / videos[0].repeat;
      videos[i].numOfRepeatition = repeatValue.round();
    }
    return videos;
  }
}
