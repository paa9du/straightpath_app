import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';

class HomeController extends GetxController {
  final currentNavigationIndex = 0.obs;

  final people = MockPeople.all;

  void selectNavigationItem(int index) {
    FlowNavigation.coach(currentNavigationIndex.value, index);
  }

  void openPerson(PersonSummary person) =>
      Get.toNamed(AppRoutes.coachYouthDetail, arguments: person);
  void openNotes(PersonSummary person) =>
      Get.toNamed(AppRoutes.coachNoteHistory, arguments: person);
  void openChat(PersonSummary person) =>
      Get.toNamed(AppRoutes.coachChat, arguments: person);
}
