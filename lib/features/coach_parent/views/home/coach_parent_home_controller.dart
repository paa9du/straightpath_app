import 'package:get/get.dart';

import '../../../../shared/models/person_summary.dart';
import '../../coach_parent_flow.dart';

class CoachParentHomeController extends GetxController {
  CoachParentHomeController(this.flow);

  final CoachParentFlow flow;
  final currentNavigationIndex = 0.obs;

  List<PersonSummary> get people => flow.homePeople;

  void selectNavigationItem(int index) =>
      flow.navigate(currentNavigationIndex.value, index);

  void openPerson(PersonSummary person) =>
      Get.toNamed(flow.youthDetailRoute, arguments: person);
  void openNotes(PersonSummary person) =>
      Get.toNamed(flow.noteHistoryRoute, arguments: person);
  void openChat(PersonSummary person) =>
      Get.toNamed(flow.chatRoute, arguments: person);
}
