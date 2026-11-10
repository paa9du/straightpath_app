import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/app_press_effect.dart';

class AppNavItem {
  const AppNavItem({
    required this.label,
    required this.iconAsset,
    this.activeIconAsset,
  });

  final String label;
  final String iconAsset;
  final String? activeIconAsset;
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

  static const _ink = Color(0xFF101720);
  static const _iconIdle = Color(0xFF2D264B);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFF2F2F2),
      child: SafeArea(
        top: false,
        left: false,
        right: false,
        child: SizedBox(
          height: 82,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 5),
            child: Row(
              children: List.generate(items.length, (index) {
                final item = items[index];
                final isActive = index == currentIndex;

                Widget svg(String asset) => SvgPicture.asset(
                      asset,
                      width: 24,
                      height: 24,
                      colorFilter: isActive
                          ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                          : const ColorFilter.mode(_iconIdle, BlendMode.srcIn),
                    );

                Widget icon = isActive && item.activeIconAsset != null
                    ? SvgPicture.asset(
                        item.activeIconAsset!,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                            Colors.white, BlendMode.srcIn),
                        errorBuilder: (context, error, stack) =>
                            svg(item.iconAsset),
                      )
                    : svg(item.iconAsset);

                if (isActive) {
                  icon = ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (rect) => const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFF5B84A), Color(0xFFFF6464)],
                    ).createShader(rect),
                    child: icon,
                  );
                }

                return Expanded(
                  child: AppPressEffect(
                    child: InkWell(
                      onTap: () => onTap(index),
                      borderRadius: BorderRadius.circular(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2),
                          icon,
                          const SizedBox(height: 6),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: isActive
                                ? ShaderMask(
                                    blendMode: BlendMode.srcIn,
                                    shaderCallback: (rect) =>
                                        const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFFF5B84A),
                                        Color(0xFFFF6464),
                                      ],
                                    ).createShader(rect),
                                    child: Text(
                                      item.label,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 13,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    item.label,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: _ink.withValues(alpha: .8),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
