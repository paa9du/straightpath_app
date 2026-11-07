import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/flow_navigation.dart';
import '../../../../shared/models/person_summary.dart';

class MessagesController extends GetxController {
  final people = const <PersonSummary>[
    PersonSummary(
      name: 'Rick Martin',
      program: 'Hey, Checking In For Today...',
      imagePath: AppAssets.rick,
      completedSteps: 0,
    ),
    PersonSummary(
      name: 'Lisa Harmon',
      program: 'Hey, Checking In For Today...',
      imagePath: AppAssets.lisa,
      completedSteps: 0,
    ),
    PersonSummary(
      name: 'Ethan Hunt',
      program: 'Hey, Checking In For Today...',
      imagePath: AppAssets.ethan,
      completedSteps: 0,
    ),
    PersonSummary(
      name: 'Peter Dinkelman',
      program: 'Hey, Checking In For Today...',
      imagePath: AppAssets.peter,
      completedSteps: 0,
    ),
    PersonSummary(
      name: 'Rick Martin',
      program: 'Hey, Checking In For Today...',
      imagePath: AppAssets.rick,
      completedSteps: 0,
    ),
    PersonSummary(
      name: 'Lisa Harmon',
      program: 'Hey, Checking In For Today...',
      imagePath: AppAssets.lisa,
      completedSteps: 0,
    ),
  ];

  void onNavigationTap(int index) => FlowNavigation.youth(3, index);

  void openChat(PersonSummary person) {
    Get.toNamed(AppRoutes.youthChat, arguments: person);
  }
}
