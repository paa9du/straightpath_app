import 'package:get/get.dart';

import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';
import '../../coach_parent_flow.dart';
import 'widgets/add_youth_dialog.dart';

class CoachParentYouthsController extends GetxController {
  CoachParentYouthsController(this.flow);

  final CoachParentFlow flow;
  final people = MockPeople.all;

  void onNavigationTap(int index) => flow.navigate(1, index);
  void openAddYouth() => AddYouthDialog.show();
  void openPerson(PersonSummary person) =>
      Get.toNamed(flow.youthDetailRoute, arguments: person);
}
