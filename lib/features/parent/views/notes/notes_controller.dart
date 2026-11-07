import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';

class NotesController extends GetxController {
  final people = MockPeople.all.take(3).toList(growable: false);

  void onNavigationTap(int index) => FlowNavigation.parent(2, index);
  void openNotes(PersonSummary person) =>
      Get.toNamed(AppRoutes.parentNoteHistory, arguments: person);
}
