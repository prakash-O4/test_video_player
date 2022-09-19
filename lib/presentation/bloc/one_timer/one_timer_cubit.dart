import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_video/domain/model/one_timer_model.dart';
import 'package:test_video/domain/repository/one_timer_repository.dart';

part 'one_timer_state.dart';

class OneTimerCubit extends Cubit<OneTimerState> {
  final OneTimerRepository oneTimer;
  OneTimerCubit({required this.oneTimer}) : super(OneTimerInitial());

  List<OneTimerModel> _oneTimerVideo = [];

  void fetchOneTimer() async {
    _oneTimerVideo = [];
    _oneTimerVideo = await oneTimer.fetchOneTimer();
    emit(OneTimerFetched(videos: _oneTimerVideo));
  }

  void pausePlayCurrentVideo(int videoId, bool status, bool emitState) {
    if (emitState) {
      emit(OneTimerLoading());
    }
    for (var i = 0; i < _oneTimerVideo.length; i++) {
      if (_oneTimerVideo[i].videoId == videoId) {
        _oneTimerVideo[i].isPaused = status;
      }
    }
    if (emitState) {
      emit(OneTimerAdded(videos: _oneTimerVideo));
    }
  }

  void addOneTimer(int videoId, int seconds) async {
    for (var i = 0; i < _oneTimerVideo.length; i++) {
      if (_oneTimerVideo[i].videoId == videoId) {
        _oneTimerVideo[i].hasTimer = true;
      }
    }
    Timer(
      Duration(seconds: seconds),
      () {
        emit(OneTimerAdded(videos: _oneTimerVideo));
      },
    );
  }
}
