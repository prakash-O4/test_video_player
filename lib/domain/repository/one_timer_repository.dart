import 'package:test_video/core/mock_one_timer_data.dart';
import 'package:test_video/domain/model/one_timer_model.dart';

class OneTimerRepository {
  Future<List<OneTimerModel>> fetchOneTimer() async {
    await Future.delayed(const Duration(seconds: 1));
    return MockOneTimerData.oneTimerData;
  }
}