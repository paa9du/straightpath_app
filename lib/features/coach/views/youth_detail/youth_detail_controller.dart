import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';

class YouthDetailController extends GetxController {
  late final PersonSummary person;

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : MockPeople.all.first;
  }

  void openNotes() =>
      Get.toNamed(AppRoutes.coachNoteHistory, arguments: person);
  void openChat() => Get.toNamed(AppRoutes.coachChat, arguments: person);
}
