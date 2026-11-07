import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../models/person_summary.dart';

class NotesList extends StatelessWidget {
  const NotesList({required this.people, required this.onPersonTap, super.key});

  final List<PersonSummary> people;
  final ValueChanged<PersonSummary> onPersonTap;

  static const note =
      'Rick participated consistently throughout today’s session and remained engaged during guided activities. he required one verbal reminder during the transition between tasks but responded calmly and re-focused within a short time.';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
      children: [
        Center(
          child: Text(
            'Notes',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 20),
        ...people.map(
          (person) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Material(
              elevation: 1,
              shadowColor: AppColors.ink.withValues(alpha: .16),
              color: AppColors.cream,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: AppColors.ink.withValues(alpha: .16)),
              ),
              child: InkWell(
                onTap: () => onPersonTap(person),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(26, 16, 26, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                                Text(
                                  person.program,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        color: AppColors.ink.withValues(
                                          alpha: .48,
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
                                  color: AppColors.ink.withValues(alpha: .28),
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
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
                          color: AppColors.ink.withValues(alpha: .5),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text.rich(
                        TextSpan(
                          children: const [
                            TextSpan(
                              text: 'Note: ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: note),
                          ],
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.ink.withValues(alpha: .55),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
