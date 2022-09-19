import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_video/presentation/screens/one_timer/one_timer_handler.dart';
import 'package:test_video/presentation/screens/video_player_screens.dart';
import 'package:test_video/presentation/video_player/video_player_cubit.dart';

class VideoPlayerHandler extends StatefulWidget {
  const VideoPlayerHandler({Key? key}) : super(key: key);

  @override
  State<VideoPlayerHandler> createState() => _VideoPlayerHandlerState();
}

class _VideoPlayerHandlerState extends State<VideoPlayerHandler> {
  late VideoPlayerCubit _videoPlayer;
  @override
  void initState() {
    _videoPlayer = BlocProvider.of<VideoPlayerCubit>(context)..fetchVideo();
    super.initState();
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
      body: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
        builder: (context, state) {
          if (state is VideoPlayerLoaded) {
            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (context, index) {
                return VideoPlayerScreen(
                  video: state.videos[index],
                );
              },
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
    );
  }
}
