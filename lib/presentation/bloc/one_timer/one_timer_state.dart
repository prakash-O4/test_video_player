part of 'one_timer_cubit.dart';

abstract class OneTimerState extends Equatable {
  const OneTimerState();

  @override
  List<Object> get props => [];
}

class OneTimerInitial extends OneTimerState {}

class OneTimerLoading extends OneTimerState {}

class OneTimerFetched extends OneTimerState {
  final List<OneTimerModel> videos;
  const OneTimerFetched({required this.videos});
  @override
  List<Object> get props => [videos];
}

class OneTimerAdded extends OneTimerState {
  final List<OneTimerModel> videos;
  const OneTimerAdded({required this.videos});
  @override
  List<Object> get props => [videos];
}

class OneTimerFailed extends OneTimerState {
  final String message;
  const OneTimerFailed({required this.message});
  @override
  List<Object> get props => [message];
}
