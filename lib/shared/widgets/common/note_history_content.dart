import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/title_case.dart';
import '../../models/person_summary.dart';
import '../buttons/gradient_fab.dart';
import 'screen_header.dart';

const _plusSvg =
    '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 4V20M4 12H20" stroke="white" stroke-width="1.5" stroke-linecap="round"/></svg>';

const _editSvg =
    '<svg width="15" height="15" viewBox="0 0 15 15" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M1.3 10.3L9.4 2.2C9.8 1.8 10.4 1.8 10.8 2.2L12.1 3.5C12.5 3.9 12.5 4.5 12.1 4.9L4 13L1 13.4L1.3 10.3Z" stroke="#101720" stroke-width="1.2" stroke-linejoin="round"/><path d="M8.2 3.4L10.9 6.1" stroke="#101720" stroke-width="1.2" stroke-linecap="round"/><path d="M7.2 14.2H13.8" stroke="#101720" stroke-width="1.2" stroke-linecap="round"/></svg>';

/// Notes detail screen (Figma 375:1015).
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
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 110),
          children: [
            ScreenHeader(
              title: person.name,
              onBack: onBack,
              trailing: _ChatButton(onTap: onOpenChat),
            ),
            const SizedBox(height: 12),
            ...List.generate(4, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _NoteCard(
                  person: person,
                  date: '${5 - index} Feb, 2025',
                  onEdit: onEditNote,
                ),
              );
            }),
          ],
        ),
        Positioned(
          right: 25,
          bottom: 37,
          child: GradientFab(
            onTap: onAddNote,
            // Inline SVG: works with hot reload (no asset bundle needed).
            icon: SvgPicture.string(_plusSvg, width: 24, height: 24),
          ),
        ),
      ],
    );
  }
}

/// 42px grey circle with the 15.75px message glyph (Figma 470:755).
class _ChatButton extends StatelessWidget {
  const _ChatButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFF6F6F6),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(
          width: 42,
          height: 42,
          child: Center(
            child: SvgPicture.asset(
              AppAssets.sendMessage,
              width: 14.1,
              height: 14.1,
            ),
          ),
        ),
      ),
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({
    required this.person,
    required this.date,
    required this.onEdit,
  });

  final PersonSummary person;
  final String date;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 198),
      decoration: BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ink.withValues(alpha: .2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 101,
            child: Stack(
              children: [
                Positioned(
                  left: 24,
                  top: 14,
                  child: ClipOval(
                    child: Image.asset(
                      person.imagePath,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 82,
                  top: 14,
                  child: Text(
                    titleCase(person.name),
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink,
                    ),
                  ),
                ),
                Positioned(
                  left: 82,
                  right: 50,
                  top: 38,
                  child: Text(
                    titleCase(person.program),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      height: 24 / 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.ink.withValues(alpha: .5),
                    ),
                  ),
                ),
                Positioned(
                  right: 17,
                  top: 16,
                  child: InkWell(
                    onTap: onEdit,
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 2.56,
                            top: 2.83,
                            child: SvgPicture.string(
                              _editSvg,
                              width: 14.24,
                              height: 14.67,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 25,
                  top: 76,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Status:',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink.withValues(alpha: .8),
                          ),
                        ),
                        TextSpan(
                          text: ' $date',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.ink.withValues(alpha: .3),
                          ),
                        ),
                      ],
                    ),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 26, 22),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Note: ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink.withValues(alpha: .8),
                    ),
                  ),
                  TextSpan(
                    text: NoteHistoryContent.note,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.ink.withValues(alpha: .5),
                    ),
                  ),
                ],
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
