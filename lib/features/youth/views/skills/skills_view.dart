import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import '../../../../shared/widgets/common/app_press_effect.dart';
import 'skills_controller.dart';
import 'skills_model.dart';

class SkillsView extends GetView<SkillsController> {
  const SkillsView({super.key});

  @override
  Widget build(BuildContext context) {
    const feelings = [
      ('😟', 'Feeling Anxious'),
      ('😩', 'Feeling Overwhelmed'),
      ('😠', 'Feeling Angry'),
      ('😐', 'Feeling Numb'),
    ];
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 2,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          children: [
            Center(
              child: Text(
                'Skills',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Choose How You Feel Right Now',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 100,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: feelings.length,
              itemBuilder: (context, index) => _FeelingCard(
                emoji: feelings[index].$1,
                label: feelings[index].$2,
                onTap: () => controller.openSkill('Calm'),
              ),
            ),
            const SizedBox(height: 10),
            _FeelingCard(
              emoji: '😮‍💨',
              label: 'Need To Calm Down',
              horizontal: true,
              onTap: () => controller.openSkill('Calm'),
            ),
            const SizedBox(height: 22),
            Text(
              'Skill Categories',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 130,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: controller.categories.length,
              itemBuilder: (context, index) => _SkillCategoryCard(
                category: controller.categories[index],
                onTap: () =>
                    controller.openSkill(controller.categories[index].name),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeelingCard extends StatelessWidget {
  const _FeelingCard({
    required this.emoji,
    required this.label,
    this.horizontal = false,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final bool horizontal;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final children = [
      Text(emoji, style: const TextStyle(fontSize: 36, height: 1)),
      SizedBox(width: horizontal ? 18 : 0, height: horizontal ? 0 : 5),
      Flexible(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    ];
    return AppPressEffect(
      child: Material(
        elevation: 1,
        color: AppColors.cream,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.ink.withValues(alpha: .18)),
        ),
        child: InkWell(
          onTap: onTap,
          child: Align(
            alignment: Alignment.center,
            child: horizontal
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
          ),
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  const _SkillCategoryCard({required this.category, required this.onTap});

  final SkillCategory category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressEffect(
      child: Material(
        elevation: 1,
        color: AppColors.cream,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: AppColors.ink.withValues(alpha: .18)),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Expanded(
                child: ClipRect(
                  child: LayoutBuilder(
                    builder: (context, constraints) => OverflowBox(
                      minWidth: constraints.maxWidth * 4,
                      maxWidth: constraints.maxWidth * 4,
                      alignment: Alignment(
                        -1 + (category.cropIndex * (2 / 3)),
                        -.42,
                      ),
                      child: Image.asset(
                        AppAssets.skillsIllustrations,
                        width: constraints.maxWidth * 4,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  category.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
