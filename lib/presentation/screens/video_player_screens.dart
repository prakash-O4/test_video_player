import 'package:flutter/material.dart';
import 'package:test_video/domain/model/video_model.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final VideoModel video;
  final PageController controller;
  final int? nextPage;
  const VideoPlayerScreen({
    Key? key,
    required this.video,
    required this.controller,
    this.nextPage,
  }) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ValueNotifier<bool> showPlay = ValueNotifier(true);
  late String url;
  int? repeatNumber = 1;
  bool hasPlayed = false;
  late bool? start;
  @override
  void initState() {
    super.initState();
    start = false;
    url = widget.video.url;
    _controller = VideoPlayerController.network(url)
      ..initialize().then((value) {
        setState(() {});
      });
    _controller.addListener(
      () {
        if (_controller.value.position == _controller.value.duration) {
          if (start != null && start == false) {
            if (widget.nextPage != null) {
              widget.controller.animateToPage(
                widget.nextPage!,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              );
            }
            setState(() {
              start = true;
            });
          }
          _controller.removeListener(() {});
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_controller.value.isInitialized && !hasPlayed) {
      _controller.play();
      setState(() {
        hasPlayed = true;
      });
    }
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8),
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
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: ValueListenableBuilder(
                      valueListenable: showPlay,
                      builder: (context, value, child) {
                        return Visibility(
                          visible: true,
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
