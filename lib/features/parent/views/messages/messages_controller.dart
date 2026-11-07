import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/utils/flow_navigation.dart';
import '../../../../data/mock/mock_people.dart';
import '../../../../shared/models/person_summary.dart';

class MessagesController extends GetxController {
  final people = [...MockPeople.all, ...MockPeople.all.take(2)];

  void onNavigationTap(int index) => FlowNavigation.parent(3, index);
  void openChat(PersonSummary person) =>
      Get.toNamed(AppRoutes.parentChat, arguments: person);
}
