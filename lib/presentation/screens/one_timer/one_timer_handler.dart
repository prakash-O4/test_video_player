import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_video/domain/repository/one_timer_repository.dart';
import 'package:test_video/presentation/bloc/one_timer/one_timer_cubit.dart';
import 'package:test_video/presentation/screens/one_timer/one_timer_screen.dart';

class OneTimerHandler extends StatefulWidget {
  const OneTimerHandler({Key? key}) : super(key: key);

  @override
  State<OneTimerHandler> createState() => _OneTimerHandlerState();
}

class _OneTimerHandlerState extends State<OneTimerHandler> {
  late OneTimerCubit _oneTimer;
  int selectedVideo = 1;
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _oneTimer = OneTimerCubit(oneTimer: OneTimerRepository())..fetchOneTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("One Timer Screen"),
      ),
      body: BlocBuilder<OneTimerCubit, OneTimerState>(
        bloc: _oneTimer,
        builder: (context, state) {
          if (state is OneTimerFetched) {
            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (BuildContext context, int index) {
                return OneTimerScreen(
                  oneTimer: state.videos[index],
                  oneTimerCubit: _oneTimer,
                );
              },
            );
          } else if (state is OneTimerAdded) {
            return ListView.builder(
              itemCount: state.videos.length,
              itemBuilder: (BuildContext context, int index) {
                return OneTimerScreen(
                  oneTimerCubit: _oneTimer,
                  oneTimer: state.videos[index],
                );
              },
            );
          } else if (state is OneTimerLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: StatefulBuilder(
                  builder: (BuildContext context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Select video id to be displayed after some seconds",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectedVideo,
                                onChanged: (vals) {
                                  setState(() {
                                    selectedVideo = vals as int;
                                  });
                                },
                              ),
                              Text("1")
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: selectedVideo,
                                onChanged: (vals) {
                                  setState(() {
                                    selectedVideo = vals as int;
                                  });
                                },
                              ),
                              Text("2")
                            ],
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: "Enter time to be delayed (in seconds)",
                            ),
                          ),
                          const SizedBox(),
                          ElevatedButton(
                            onPressed: () {
                              _oneTimer.addOneTimer(
                                selectedVideo,
                                int.tryParse(_controller.text.trim()) ?? 0,
                              );
                              Navigator.of(context).pop(true);
                            },
                            child: const Text("Submit"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
