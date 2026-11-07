import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProgressTracker extends StatelessWidget {
  const ProgressTracker({
    required this.labels,
    required this.completedSteps,
    this.compact = false,
    super.key,
  });

  final List<String> labels;
  final int completedSteps;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final activeCount = completedSteps.clamp(0, labels.length);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: labels
              .map(
                (label) => Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: compact ? 11 : 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final gap = constraints.maxWidth / (labels.length - 1);
            return SizedBox(
              height: 22,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Positioned(
                    left: 8,
                    right: 8,
                    child: Container(height: 4, color: const Color(0xFFF0F0F0)),
                  ),
                  if (activeCount > 1)
                    Positioned(
                      left: 8,
                      width: gap * (activeCount - 1),
                      child: Container(
                        height: 4,
                        decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient,
                        ),
                      ),
                    ),
                  ...List.generate(labels.length, (index) {
                    final done = index < activeCount;
                    return Positioned(
                      left: (gap * index).clamp(0, constraints.maxWidth - 20),
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: done ? AppColors.success : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: done ? AppColors.success : AppColors.divider,
                          ),
                        ),
                        child: done
                            ? const Icon(
                                Icons.check,
                                size: 13,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
