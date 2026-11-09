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
      height: 30,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: List.generate(DailyTabs.labels.length, (index) {
            final active = index == widget.currentIndex;
            final isLast = index == DailyTabs.labels.length - 1;
            return Semantics(
              selected: active,
              button: true,
              child: AppPressEffect(
                child: InkWell(
                  onTap: () => widget.onTap(index),
                  child: Container(
                    margin: EdgeInsets.only(right: isLast ? 0 : 16),
                    padding: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2,
                          color: active ? AppColors.coral : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      DailyTabs.labels[index],
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: active ? 14 : 12,
                        fontWeight: active ? FontWeight.w800 : FontWeight.w400,
                        color: active
                            ? AppColors.coral
                            : AppColors.ink.withValues(alpha: .8),
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
