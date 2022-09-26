import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_video/presentation/screens/one_timer/one_timer_handler.dart';
import 'package:test_video/presentation/screens/video_player_screens.dart';
import 'package:test_video/presentation/screens/widgets/date_time.dart';
import 'package:test_video/presentation/video_player/video_player_cubit.dart';
import 'package:text_scroll/text_scroll.dart';

class VideoPlayerHandler extends StatefulWidget {
  const VideoPlayerHandler({Key? key}) : super(key: key);

  @override
  State<VideoPlayerHandler> createState() => _VideoPlayerHandlerState();
}

class _VideoPlayerHandlerState extends State<VideoPlayerHandler> {
  late PageController _controller;
  late VideoPlayerCubit _videoPlayer;
  @override
  void initState() {
    _videoPlayer = BlocProvider.of<VideoPlayerCubit>(context)..fetchVideo();
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Video Player",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OneTimerHandler(),
                ),
              );
            },
            icon: const Icon(
              Icons.next_plan,
            ),
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            if (state is VideoPlayerLoaded) {
              log(state.videos.toString());
              return Column(
                children: [
                  const DateTimeHeading(),
                  Container(
                    color: Colors.grey,
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: PageView.builder(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.videos.length,
                        itemBuilder: (context, index) {
                          int nextPage = index + 1;
                          return VideoPlayerScreen(
                            video: state.videos[index],
                            controller: _controller,
                            nextPage:
                                index == state.videos.length ? null : nextPage,
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: const [
                        Text("Breaking News: "),
                        Flexible(
                          child: TextScroll(
                            "Some random person killed some random person due to some random reason. Thank you.",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is VideoPlayerLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: Text(
                "Something went wrong we will fix it",
              ),
            );
          },
        ),
      ),
    );
  }
}
