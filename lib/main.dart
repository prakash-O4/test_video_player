import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_video/domain/repository/one_timer_repository.dart';
import 'package:test_video/domain/repository/video_repository.dart';
import 'package:test_video/presentation/bloc/one_timer/one_timer_cubit.dart';
import 'package:test_video/presentation/screens/video_player_handler.dart';
import 'package:test_video/presentation/video_player/video_player_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => VideoPlayerCubit(
              videoRepository: VideoRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => OneTimerCubit(
              oneTimer: OneTimerRepository(),
            ),
          ),
        ],
        child: const VideoPlayerHandler(),
      ),
    );
  }
}
