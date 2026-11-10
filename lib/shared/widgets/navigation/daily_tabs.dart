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
      height: 38,
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(DailyTabs.labels.length, (index) {
            final active = index == widget.currentIndex;
            final isLast = index == DailyTabs.labels.length - 1;
            return Semantics(
              selected: active,
              button: true,
              child: AppPressEffect(
                child: GestureDetector(
                  onTap: () => widget.onTap(index),
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: isLast ? 0 : 24),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 2.5,
                          color: active
                              ? AppColors.coral
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    child: Text(
                      DailyTabs.labels[index],
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14,
                        fontWeight:
                            active ? FontWeight.w700 : FontWeight.w500,
                        color: active
                            ? AppColors.coral
                            : AppColors.ink.withValues(alpha: .45),
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
