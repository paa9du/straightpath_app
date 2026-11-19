import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../models/person_summary.dart';
import '../cards/person_summary_card.dart';
import '../navigation/app_bottom_navigation.dart';

class PeopleOverview extends StatelessWidget {
  const PeopleOverview({
    required this.people,
    required this.currentIndex,
    required this.onNavigationTap,
    required this.onPersonTap,
    required this.onAddNote,
    required this.onSendMessage,
    super.key,
  });

  final List<PersonSummary> people;
  final int currentIndex;
  final ValueChanged<int> onNavigationTap;
  final ValueChanged<PersonSummary> onPersonTap;
  final ValueChanged<PersonSummary> onAddNote;
  final ValueChanged<PersonSummary> onSendMessage;

  static const _navItems = [
    AppNavItem(label: 'Overview', iconAsset: AppAssets.overview),
    AppNavItem(label: 'Youths', iconAsset: AppAssets.youths),
    AppNavItem(label: 'Notes', iconAsset: AppAssets.notes),
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 13, 20, 24),
                children: [
                  Center(
                    child: Text(
                      'Overview',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineSmall?.copyWith(height: 33 / 24),
                    ),
                  ),
                  const SizedBox(height: 19),
                  const Text('Program Filter', style: _sectionTitle),
                  const SizedBox(height: 9),
                  const SizedBox(height: 44, child: _ProgramFilterBar()),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const Text('Youth', style: _sectionTitle),
                      const Spacer(),
                      InkWell(
                        onTap: () => onNavigationTap(1),
                        child: Row(
                          children: [
                            Text(
                              'See More',
                              style: TextStyle(
                                fontSize: 12,
                                height: 16 / 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.ink.withValues(alpha: .3),
                              ),
                            ),
                            const SizedBox(width: 2),
                            const OverviewChevron(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 9),
                  ...people.map(
                    (person) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PersonSummaryCard(
                        person: person,
                        onTap: () => onPersonTap(person),
                        onAddNote: () => onAddNote(person),
                        onSendMessage: () => onSendMessage(person),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppBottomNavigation(
              items: _navItems,
              currentIndex: currentIndex,
              onTap: onNavigationTap,
            ),
          ],
        ),
      ),
    );
  }
}

const _sectionTitle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Color(0xCC101720),
);

class _ProgramFilterBar extends StatefulWidget {
  const _ProgramFilterBar();

  @override
  State<_ProgramFilterBar> createState() => _ProgramFilterBarState();
}

class _ProgramFilterBarState extends State<_ProgramFilterBar> {
  static const labels = [
    'Orientation & Trust Building',
    'Group Agreements',
    'My Goals',
    'Court-Involved Juvenile',
  ];
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      primary: false,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: labels.length,
      separatorBuilder: (context, index) => const SizedBox(width: 10),
      itemBuilder: (context, index) => _FilterChip(
        label: labels[index],
        active: selectedIndex == index,
        onTap: () => setState(() => selectedIndex = index),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.onTap,
    this.active = false,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: active ? null : const Color(0xFFF6F6F6),
            gradient: active ? overviewGradient : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                height: 24 / 13,
                color: active
                    ? Colors.white
                    : AppColors.ink.withValues(alpha: .8),
                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
