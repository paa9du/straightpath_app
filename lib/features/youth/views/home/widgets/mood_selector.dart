import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../shared/widgets/common/app_press_effect.dart';
import '../home_model.dart';

class MoodSelector extends StatelessWidget {
  const MoodSelector({
    required this.moods,
    required this.selectedIndex,
    required this.onSelected,
    super.key,
  });

  final List<MoodOption> moods;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD799), Color(0xFFFFA4AA)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: List.generate(moods.length, (index) {
              final mood = moods[index];
              final selected = index == selectedIndex;
              return Expanded(
                child: AppPressEffect(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () => onSelected(index),
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedScale(
                      duration: const Duration(milliseconds: 160),
                      scale: selected ? 1.08 : 1,
                      child: Column(
                        children: [
                          Image.asset(mood.assetPath, width: 52, height: 52),
                          const SizedBox(height: 5),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              mood.label,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    fontSize: 11,
                                    fontWeight: selected
                                        ? FontWeight.w800
                                        : FontWeight.w400,
                                  ),
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
          const SizedBox(height: 10),
          Container(
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .82),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: 'Last Check-In: ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: moods[selectedIndex].label,
                    style: const TextStyle(
                      color: AppColors.success,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const TextSpan(text: ' '),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Image.asset(
                      moods[selectedIndex].assetPath,
                      width: 22,
                      height: 22,
                    ),
                  ),
                ],
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
