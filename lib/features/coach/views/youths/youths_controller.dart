import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';

class YouthsController extends GetxController {
  final people = MockPeople.all;

  void onNavigationTap(int index) => FlowNavigation.coach(1, index);
  void openPerson(PersonSummary person) =>
      Get.toNamed(AppRoutes.coachYouthDetail, arguments: person);
}
