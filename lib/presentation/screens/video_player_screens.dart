import 'package:flutter/material.dart';
import 'package:test_video/domain/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel video;
  const VideoPlayerScreen({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ValueNotifier<bool> showPlay = ValueNotifier(true);
  late String url;
  int? repeatNumber = 1;
  @override
  void initState() {
    super.initState();
    url = widget.video.url;
    _controller = VideoPlayerController.network(url)
      ..initialize().then((value) {
        setState(() {});
      });
    if (widget.video.numOfRepeatition != null) {
      _controller.addListener(() {
        if (_controller.value.position == _controller.value.duration &&
            repeatNumber != widget.video.numOfRepeatition) {
          if (repeatNumber == null) {
            repeatNumber = 1;
          } else {
            repeatNumber = repeatNumber! + 1;
          }
          if (!_controller.value.isPlaying) {
            _controller.play();
          }
        } else {
          _controller.removeListener(() {});
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: _controller.value.isInitialized
            ? Stack(
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(
                      _controller,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          shape: BoxShape.circle),
                      child: Text(
                        widget.video.numOfRepeatition?.toString() ?? "1",
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ValueListenableBuilder(
                      valueListenable: showPlay,
                      builder: (context, value, child) {
                        return Visibility(
                          visible: value as bool,
                          child: IconButton(
                            onPressed: () {
                              showPlay.value = !showPlay.value;
                              setState(() {
                                if (_controller.value.isPlaying) {
                                  _controller.pause();
                                } else {
                                  _controller.play();
                                }
                              });
                            },
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 50,
                              color: Colors.yellow,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
