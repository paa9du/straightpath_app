import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_interaction_feedback.dart';
import '../../../../shared/models/person_summary.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'messages_controller.dart';

class MessagesView extends GetView<MessagesController> {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 3,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          children: [
            Center(
              child: Text(
                'Message',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 20),
            Material(
              elevation: 1,
              shadowColor: AppColors.ink.withValues(alpha: .16),
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                onTap: () => AppInteractionFeedback.showSearch(context),
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppAssets.search,
                          width: 24,
                          height: 24,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Search Here',
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: AppColors.ink.withValues(alpha: .45),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...controller.people.map(
              (person) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _MessageTile(
                  person: person,
                  onTap: () => controller.openChat(person),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({required this.person, required this.onTap});

  final PersonSummary person;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      shadowColor: AppColors.ink.withValues(alpha: .16),
      color: AppColors.cream,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.ink.withValues(alpha: .18)),
      ),
      child: InkWell(
        onTap: onTap,
        // Figma 475:1338 (390 x 80): avatar 48 at (25, 15), name 17 medium at
        // top 15, subtitle 15 medium at top 39, "5 min ago" 12 regular
        // top-aligned beside the name, 19px from the right edge.
        child: MediaQuery.withNoTextScaling(
          child: SizedBox(
            height: 80,
            child: Stack(
              children: [
                Positioned(
                  left: 26,
                  top: 16,
                  child: ClipOval(
                    child: Image.asset(
                      person.imagePath,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 84,
                  right: 96,
                  top: 16,
                  child: Text(
                    person.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                Positioned(
                  left: 84,
                  right: 16,
                  top: 40,
                  child: Text(
                    'Hey, Checking In For Today...',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink.withValues(alpha: .5),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 18,
                  child: Text(
                    '5 Min Ago',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      height: 16 / 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.ink.withValues(alpha: .3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
