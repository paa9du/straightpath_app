import 'package:get/get.dart';

import '../../../../app/routes/app_routes.dart';

class ProgramOverviewController extends GetxController {
  void getStarted() => Get.offNamed(AppRoutes.roleSelection);
}
