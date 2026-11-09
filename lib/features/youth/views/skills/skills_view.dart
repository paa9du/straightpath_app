import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import '../../../../shared/widgets/common/app_press_effect.dart';
import 'skills_controller.dart';
import 'skills_model.dart';

const _ink = Color(0xFF101720);

TextStyle _t(double size, FontWeight w, Color c) => TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: w,
      color: c,
    );

class SkillsView extends GetView<SkillsController> {
  const SkillsView({super.key});

  @override
  Widget build(BuildContext context) {
    const feelings = [
      ('assets/emojis/1F630.svg', 'Feeling Anxious'),
      ('assets/emojis/1F629.svg', 'Feeling Overwhelmed'),
      ('assets/emojis/1F620.svg', 'Feeling Angry'),
      ('assets/emojis/1F611.svg', 'Feeling Numb'),
    ];
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 2,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          children: [
            Center(
              child: Text('Skills', style: _t(24, FontWeight.w700, _ink)),
            ),
            const SizedBox(height: 24),
            Text(
              'Choose How You Feel Right Now',
              style: _t(18, FontWeight.w600, _ink.withValues(alpha: .8)),
            ),
            const SizedBox(height: 14),
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
                onTap: () => controller.openFeeling(index),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: _FeelingCard(
                emoji: 'assets/emojis/1F62E-200D-1F4A8.svg',
                label: 'Need To Calm Down',
                horizontal: true,
                onTap: () => controller.openFeeling(4),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Skill Categories',
              style: _t(18, FontWeight.w600, _ink.withValues(alpha: .8)),
            ),
            const SizedBox(height: 14),
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
      SvgPicture.asset(emoji, width: 60, height: 60),
      SizedBox(width: horizontal ? 10 : 0, height: horizontal ? 0 : 0),
      Flexible(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: _t(15, FontWeight.w500, _ink.withValues(alpha: .8)),
          ),
        ),
      ),
    ];
    return AppPressEffect(
      child: Material(
        elevation: 0,
        color: const Color(0xFFFFFDEE),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _ink.withValues(alpha: .2)),
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
                : Padding(
                    padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: children,
                    ),
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
        elevation: 0,
        color: const Color(0xFFFFFDEE),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: _ink.withValues(alpha: .2)),
        ),
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              const SizedBox(height: 5),
              _crop(category.cropIndex),
              const SizedBox(height: 5),
              Expanded(
                child: Center(
                  child: Text(
                    category.name,
                    maxLines: 1,
                    style: _t(15, FontWeight.w500, _ink.withValues(alpha: .8))
                        .copyWith(height: 1.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Figma crops of the shared illustration sheet (box width, then left/top/width
// /height as fractions of the box; box height is always 90).
const _crops = [
  (106.0, -0.3556, -1.513, 5.6889, 4.4522), // Calm
  (106.0, -1.6185, -1.5043, 5.6889, 4.4522), // Focus
  (96.0, -3.1256, -1.513, 6.2414, 4.4522), // Reset
  (119.0, -3.571, -1.5217, 5.0693, 4.4522), // Ground
];

Widget _crop(int index) {
  final c = _crops[index];
  const h = 90.0;
  final w = c.$1;
  return SizedBox(
    width: w,
    height: h,
    child: ClipRect(
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          Positioned(
            left: c.$2 * w,
            top: c.$3 * h,
            width: c.$4 * w,
            height: c.$5 * h,
            child: Image.asset(AppAssets.skillsIllustrations, fit: BoxFit.fill),
          ),
        ],
      ),
    ),
  );
}
