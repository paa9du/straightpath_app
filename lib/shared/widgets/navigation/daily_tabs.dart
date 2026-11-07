import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../common/app_press_effect.dart';

class DailyTabs extends StatefulWidget {
  const DailyTabs({required this.currentIndex, required this.onTap, super.key});

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const labels = [
    'Dashboard',
    'Emotional Check-In',
    'Focus',
    'Activity',
    'Reflection',
  ];

  @override
  State<DailyTabs> createState() => _DailyTabsState();
}

class _DailyTabsState extends State<DailyTabs> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _revealActiveTab();
  }

  @override
  void didUpdateWidget(covariant DailyTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _revealActiveTab();
    }
  }

  void _revealActiveTab() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;
      final position = _scrollController.position;
      final progress = widget.currentIndex / (DailyTabs.labels.length - 1);
      _scrollController.jumpTo(position.maxScrollExtent * progress);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(DailyTabs.labels.length, (index) {
            final active = index == widget.currentIndex;
            return Semantics(
              selected: active,
              button: true,
              child: AppPressEffect(
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () => widget.onTap(index),
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.fromLTRB(14, 9, 14, 7),
                      decoration: BoxDecoration(
                        color: active
                            ? AppColors.coral.withValues(alpha: .12)
                            : const Color(0xFFF7F7F7),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: active
                              ? AppColors.coral.withValues(alpha: .42)
                              : AppColors.divider,
                        ),
                      ),
                      child: Text(
                        DailyTabs.labels[index],
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          fontWeight: active
                              ? FontWeight.w800
                              : FontWeight.w500,
                          color: active ? AppColors.coral : AppColors.ink,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
