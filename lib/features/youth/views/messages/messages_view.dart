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
        child: SizedBox(
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    person.imagePath,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontSize: 16, height: 1.1),
                      ),
                      Text(
                        person.program,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.ink.withValues(alpha: .48),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '5 Min Ago',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: AppColors.ink.withValues(alpha: .28)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
