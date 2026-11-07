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
    AppNavItem(label: 'Message', iconAsset: AppAssets.message),
    AppNavItem(label: 'Profile', iconAsset: AppAssets.profile),
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
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                children: [
                  Center(
                    child: Text(
                      'Overview',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Program Filter',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(height: 44, child: const _ProgramFilterBar()),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Text(
                        'Youth',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => onNavigationTap(1),
                        child: const Text('See More  ›'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
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

class _ProgramFilterBar extends StatefulWidget {
  const _ProgramFilterBar();

  @override
  State<_ProgramFilterBar> createState() => _ProgramFilterBarState();
}

class _ProgramFilterBarState extends State<_ProgramFilterBar> {
  static const labels = [
    'Court-Involved Juvenile',
    'Transitional Housing',
    'After-School',
  ];
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: labels.length,
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
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: active ? null : const Color(0xFFF7F7F7),
              gradient: active ? AppColors.primaryGradient : null,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: active
                      ? Colors.white
                      : AppColors.ink.withValues(alpha: .7),
                  fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
