import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/navigation/daily_tabs.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'emotional_check_in_controller.dart';

class EmotionalCheckInView extends GetView<EmotionalCheckInController> {
  const EmotionalCheckInView({super.key});

  static final _noteBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(16),
    borderSide: BorderSide(color: AppColors.ink.withValues(alpha: .1)),
  );

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 0,
        onNavigationTap: controller.onNavigationTap,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      'Emotional Check-In',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 16),
                  DailyTabs(currentIndex: 1, onTap: controller.onDailyTab),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'How Are You Feeling Right Now?',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 14),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisExtent: 99,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 14,
                      ),
                      itemCount: controller.feelings.length,
                      itemBuilder: (context, index) {
                        return Obx(() {
                          final feeling = controller.feelings[index];
                          final active =
                              controller.selectedFeeling.value == feeling.label;
                          return InkWell(
                            onTap: () => controller.selectFeeling(feeling.label),
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: active
                                    ? AppColors.yellow.withValues(alpha: .38)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: active
                                      ? AppColors.coral
                                      : AppColors.ink.withValues(alpha: .1),
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: -1,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        feeling.assetPath,
                                        width: 72,
                                        height: 72,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 71,
                                    left: 4,
                                    right: 4,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        feeling.label,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.ink.withValues(alpha: .8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                      },
                    ),
                    const SizedBox(height: 22),
                    Text.rich(
                      TextSpan(
                        children: [
                          const TextSpan(text: "What's Influencing This Feeling? "),
                          TextSpan(
                            text: '(Optional)',
                            style: TextStyle(
                              color: AppColors.ink.withValues(alpha: .35),
                            ),
                          ),
                        ],
                      ),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 125,
                      child: TextField(
                        controller: controller.noteController,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.ink.withValues(alpha: .8),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Add A Note Here...',
                          hintStyle: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.ink.withValues(alpha: .4),
                          ),
                          fillColor: AppColors.cream,
                          contentPadding: const EdgeInsets.all(14),
                          border: _noteBorder,
                          enabledBorder: _noteBorder,
                          focusedBorder: _noteBorder,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: AppPrimaryButton(
                label: 'Continue',
                onPressed: controller.continueFlow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
