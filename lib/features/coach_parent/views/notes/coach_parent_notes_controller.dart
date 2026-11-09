import 'package:get/get.dart';

import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';
import '../../coach_parent_flow.dart';

class CoachParentNotesController extends GetxController {
  CoachParentNotesController(this.flow);

  final CoachParentFlow flow;
  final people = MockPeople.all.take(3).toList(growable: false);

  void onNavigationTap(int index) => flow.navigate(2, index);
  void openNotes(PersonSummary person) =>
      Get.toNamed(flow.noteHistoryRoute, arguments: person);
}
