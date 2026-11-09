import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_interaction_feedback.dart';
import '../../models/person_summary.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({
    required this.people,
    required this.onPersonTap,
    this.title = 'Messages',
    super.key,
  });

  final List<PersonSummary> people;
  final ValueChanged<PersonSummary> onPersonTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        Center(
          child: Text(title, style: Theme.of(context).textTheme.headlineSmall),
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
                    SvgPicture.asset(AppAssets.search, width: 24, height: 24),
                    const SizedBox(width: 12),
                    Text(
                      'Search Here',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
        ...people.map(
          (person) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Material(
              elevation: 1,
              shadowColor: AppColors.ink.withValues(alpha: .16),
              color: AppColors.cream,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: AppColors.ink.withValues(alpha: .18)),
              ),
              child: InkWell(
                onTap: () => onPersonTap(person),
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      person.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(fontSize: 16, height: 1.1),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // Figma 375:951 – 12 regular, ink @ 30 %,
                                  // right-aligned on the name row.
                                  Text(
                                    '5 Min Ago',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 16 / 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.ink.withValues(
                                        alpha: .3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Hey, Checking In For Today...',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.ink.withValues(
                                        alpha: .48,
                                      ),
                                      fontSize: 12,
                                      height: 1.1,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
