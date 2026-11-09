import 'package:get/get.dart';

import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';
import '../../coach_parent_flow.dart';

class CoachParentMessagesController extends GetxController {
  CoachParentMessagesController(this.flow);

  final CoachParentFlow flow;
  final people = [...MockPeople.all, ...MockPeople.all.take(2)];

  void onNavigationTap(int index) => flow.navigate(3, index);
  void openChat(PersonSummary person) =>
      Get.toNamed(flow.chatRoute, arguments: person);
}
