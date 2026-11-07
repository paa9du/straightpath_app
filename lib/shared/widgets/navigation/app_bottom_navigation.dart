import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../common/app_press_effect.dart';

class AppNavItem {
  const AppNavItem({required this.label, required this.iconAsset});

  final String label;
  final String iconAsset;
}

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final List<AppNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 82,
      decoration: const BoxDecoration(color: AppColors.navSurface),
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 8),
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isActive = index == currentIndex;
          final color = isActive ? AppColors.coral : AppColors.ink;
          return Expanded(
            child: AppPressEffect(
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  onTap: () => onTap(index),
                  borderRadius: BorderRadius.circular(14),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.coral.withValues(alpha: .11)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          item.iconAsset,
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isActive
                                    ? AppColors.coral
                                    : AppColors.ink.withValues(alpha: .72),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
