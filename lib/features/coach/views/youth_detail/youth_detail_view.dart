import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/youth_detail_content.dart';
import 'youth_detail_controller.dart';

class YouthDetailView extends GetView<YouthDetailController> {
  const YouthDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: Scaffold(
        body: SafeArea(
          child: YouthDetailContent(
            person: controller.person,
            onBack: Get.back,
            onOpenNotes: controller.openNotes,
            onOpenChat: controller.openChat,
          ),
        ),
      ),
    );
  }
}
