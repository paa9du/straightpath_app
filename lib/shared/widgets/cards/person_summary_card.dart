import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_radii.dart';
import '../../models/person_summary.dart';
import '../common/app_press_effect.dart';
import 'progress_tracker.dart';

class PersonSummaryCard extends StatelessWidget {
  const PersonSummaryCard({
    required this.person,
    this.showActions = true,
    this.onTap,
    this.onAddNote,
    this.onSendMessage,
    super.key,
  });

  final PersonSummary person;
  final bool showActions;
  final VoidCallback? onTap;
  final VoidCallback? onAddNote;
  final VoidCallback? onSendMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppPressEffect(
          child: Material(
            elevation: 1,
            shadowColor: AppColors.ink.withValues(alpha: .18),
            color: AppColors.cream,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadii.card),
              side: BorderSide(color: AppColors.ink.withValues(alpha: .16)),
            ),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppRadii.card),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(26, 16, 26, 18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipOval(
                          child: Image.asset(
                            person.imagePath,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                person.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                person.program,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      color: AppColors.ink.withValues(
                                        alpha: .5,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'Explore  ›',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.ink.withValues(alpha: .3),
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Status: ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: person.statusDate),
                          ],
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.ink.withValues(alpha: .65),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ProgressTracker(
                      labels: const [
                        'Check-In',
                        'Focus',
                        'Activity',
                        'Reflection',
                      ],
                      completedSteps: person.completedSteps,
                      compact: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (showActions) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.note_alt_outlined,
                  label: 'Add Note',
                  onTap: onAddNote,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  label: 'Send Message',
                  onTap: onSendMessage,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppPressEffect(
      child: Material(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 21),
                const SizedBox(width: 8),
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      label,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
