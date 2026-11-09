import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import 'app_bottom_navigation.dart';

class YouthPageScaffold extends StatelessWidget {
  const YouthPageScaffold({
    required this.currentIndex,
    required this.onNavigationTap,
    required this.body,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onNavigationTap;
  final Widget body;

  static const _items = [
    AppNavItem(
      label: 'Today',
      iconAsset: AppAssets.homeOutline,
      activeIconAsset: AppAssets.home,
    ),
    AppNavItem(
      label: 'Weekly',
      iconAsset: AppAssets.calendar,
      activeIconAsset: AppAssets.calendarFilled,
    ),
    AppNavItem(label: 'Skills', iconAsset: AppAssets.skills),
    AppNavItem(
      label: 'Message',
      iconAsset: AppAssets.message,
      activeIconAsset: AppAssets.messageFilled,
    ),
    AppNavItem(
      label: 'Profile',
      iconAsset: AppAssets.profile,
      activeIconAsset: AppAssets.profileFilled,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: body),
            AppBottomNavigation(
              items: _items,
              currentIndex: currentIndex,
              onTap: onNavigationTap,
            ),
          ],
        ),
      ),
    );
  }
}
