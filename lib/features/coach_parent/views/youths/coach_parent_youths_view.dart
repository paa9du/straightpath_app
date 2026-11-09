import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/common/people_list.dart';
import '../../../../shared/widgets/navigation/staff_page_scaffold.dart';
import 'coach_parent_youths_controller.dart';

class CoachParentYouthsView extends GetView<CoachParentYouthsController> {
  const CoachParentYouthsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: StaffPageScaffold(
        currentIndex: 1,
        onNavigationTap: controller.onNavigationTap,
        body: Stack(
          children: [
            PeopleList(
              people: controller.people,
              onPersonTap: controller.openPerson,
            ),
            if (controller.flow.canAddYouth)
              // Figma 511:968 – 64px gradient circle, 27px from right / nav bar.
              Positioned(
                right: 27,
                bottom: 27,
                child: _AddYouthButton(onTap: controller.openAddYouth),
              ),
          ],
        ),
      ),
    );
  }
}

class _AddYouthButton extends StatelessWidget {
  const _AddYouthButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: Ink(
        width: 64,
        height: 64,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [Color(0xFFFF6B6F), Color(0xFFFF9A5A)],
          ),
        ),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Center(
            child: SvgPicture.asset(AppAssets.userAdd, width: 24, height: 24),
          ),
        ),
      ),
    );
  }
}
