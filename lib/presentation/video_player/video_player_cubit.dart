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
    emit(VideoPlayerLoaded(videos: _getVideoFromLocal(videos)));
  }

  List<VideoModel> _getVideoFromLocal(List<VideoModel> videos) {
    List<Map<String, dynamic>> sortedVideos = _sortVideosByRepeat(videos);
    List<VideoModel> finalVideos = [];
    for (var i = 0; i < sortedVideos.length; i++) {
      finalVideos = finalVideos + _convertMapToList(sortedVideos[i]);
    }
    return finalVideos;
  }

  List<Map<String, dynamic>> _sortVideosByRepeat(List<VideoModel> videos) {
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
    return _checkVideoRatio(videos);
  }

  List<Map<String, dynamic>> _checkVideoRatio(List<VideoModel> number) {
    if (number.isNotEmpty) {
      Map<String, dynamic> repeatValue = {};
      int firstNumber = number.first.repeat;
      List<VideoModel> total = [];
      List<VideoModel> reminder = [];
      List<Map<String, dynamic>> finalSum = [];
      List<VideoModel> calcVideo = [];
      for (int i = 0; i < number.length; i++) {
        double div = number[i].repeat / firstNumber;
        int rem = number[i].repeat % firstNumber;
        if (rem != 0) {
          number[i].reminder = rem;
          reminder.add(number[i]);
        }
        number[i].repeat = div.floor();
        total.add(number[i]);
        //print("Repeat Number is ${total[i].repeat}");
      }
      for (int i = 0; i < total.length; i++) {
//       print("Repeat Number is ${total[i].repeat}");
        calcVideo =
            calcVideo + List<VideoModel>.filled(total[i].repeat, total[i]);
      }
      if (reminder.isNotEmpty) {
        finalSum = _checkVideoRatio(reminder);
      }

      repeatValue["repeat"] = firstNumber;
      repeatValue["videos"] = calcVideo;
//     print(repeatValue);
      return ([repeatValue] + finalSum);
    }
    return [];
  }

  List<VideoModel> _convertMapToList(Map<String, dynamic> videos) {
    int repeatNumber = 0;
    List<VideoModel> finalVideos = [];
    videos.forEach((key, value) {
      if (key == "repeat") {
        repeatNumber = value;
      }
      if (key == "videos") {
        for (int i = 0; i < repeatNumber; i++) {
          (value as List<VideoModel>).shuffle();
          finalVideos = finalVideos + value;
        }
      }
    });
    return finalVideos;
  }
}
