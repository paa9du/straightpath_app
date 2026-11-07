import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../models/person_summary.dart';
import 'screen_header.dart';

class NoteHistoryContent extends StatelessWidget {
  const NoteHistoryContent({
    required this.person,
    required this.onBack,
    required this.onAddNote,
    required this.onEditNote,
    required this.onOpenChat,
    super.key,
  });

  final PersonSummary person;
  final VoidCallback onBack;
  final VoidCallback onAddNote;
  final VoidCallback onEditNote;
  final VoidCallback onOpenChat;

  static const note =
      'Rick participated consistently throughout today’s session and remained engaged during guided activities. He required one verbal reminder during the transition between tasks but responded calmly and re-focused within a short time.';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 96),
          children: [
            ScreenHeader(
              title: person.name,
              onBack: onBack,
              trailing: IconButton(
                onPressed: onOpenChat,
                icon: const Icon(Icons.chat_bubble_outline),
              ),
            ),
            ...List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(26, 16, 20, 16),
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.ink.withValues(alpha: .18),
                    ),
                  ),
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
                          IconButton(
                            onPressed: onEditNote,
                            tooltip: 'Edit note',
                            icon: const Icon(Icons.edit_outlined, size: 20),
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
                            TextSpan(text: '${5 - index} Feb, 2025'),
                          ],
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.ink.withValues(alpha: .5),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text.rich(
                        const TextSpan(
                          children: [
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
              );
            }),
          ],
        ),
        Positioned(
          right: 28,
          bottom: 28,
          child: FloatingActionButton(
            onPressed: onAddNote,
            backgroundColor: AppColors.coral,
            foregroundColor: Colors.white,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
