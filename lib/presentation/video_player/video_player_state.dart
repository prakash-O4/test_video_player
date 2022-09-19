part of 'video_player_cubit.dart';

@immutable
abstract class VideoPlayerState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VideoPlayerInitial extends VideoPlayerState {}

class VideoPlayerLoading extends VideoPlayerState {}

class VideoPlayerLoaded extends VideoPlayerState {
  final List<VideoModel> videos;
  VideoPlayerLoaded({required this.videos});
  @override
  List<Object?> get props => [videos];
}

class VideoPlayerFailed extends VideoPlayerState {
  final String message;
  VideoPlayerFailed({required this.message});
  @override
  List<Object?> get props => [message];
}
