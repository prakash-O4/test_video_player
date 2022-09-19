import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_video/domain/model/one_timer_model.dart';
import 'package:test_video/presentation/bloc/one_timer/one_timer_cubit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OneTimerScreen extends StatefulWidget {
  final OneTimerModel oneTimer;
  final OneTimerCubit oneTimerCubit;
  const OneTimerScreen(
      {Key? key, required this.oneTimer, required this.oneTimerCubit})
      : super(key: key);

  @override
  State<OneTimerScreen> createState() => _OneTimerScreenState();
}

class _OneTimerScreenState extends State<OneTimerScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.oneTimer.yId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        startAt: widget.oneTimer.seconds ?? 0,
      ),
    );
    _controller.addListener(() {
      if (_controller.value.isPlaying && widget.oneTimer.hasTimer) {
        if (_controller.value.position > const Duration(seconds: 0) &&
            _controller.value.position.inSeconds ==
                _controller.value.metaData.duration.inSeconds - 1) {
          widget.oneTimerCubit
              .pausePlayCurrentVideo(widget.oneTimer.videoId, false, true);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OneTimerCubit, OneTimerState>(
      bloc: widget.oneTimerCubit,
      listener: (context, state) {
        if (state is OneTimerAdded) {
          if (_controller.value.isPlaying &&
              widget.oneTimer.hasTimer == false) {
            _controller.pause();
            widget.oneTimerCubit
                .pausePlayCurrentVideo(widget.oneTimer.videoId, true, false);
          } else if (!_controller.value.isPlaying && widget.oneTimer.hasTimer) {
            _controller.play();
            // widget.oneTimerCubit
            //     .pausePlayCurrentVideo(widget.oneTimer.videoId, false);
          } else if (!_controller.value.isPlaying && widget.oneTimer.isPaused) {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: YoutubePlayer(
          controller: _controller,
        ),
      ),
    );
  }
}
