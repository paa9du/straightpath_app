import 'package:get/get.dart';

import 'weekly_day_completed_controller.dart';
import 'weekly_day_questions_controller.dart';

class WeeklyDayCompletedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeeklyDayCompletedController>(WeeklyDayCompletedController.new);
  }
}

class WeeklyDayQuestionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WeeklyDayQuestionsController>(WeeklyDayQuestionsController.new);
  }
}
