import '../buttons/app_back_arrow.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_interaction_feedback.dart';

final _fieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.75),
  borderSide: BorderSide(color: AppColors.ink.withValues(alpha: .1)),
);

class ChatContent extends StatelessWidget {
  const ChatContent({
    required this.name,
    required this.imagePath,
    required this.messageController,
    required this.onBack,
    required this.onSend,
    super.key,
  });

  final String name;
  final String imagePath;
  final TextEditingController messageController;
  final VoidCallback onBack;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60,
          child: Row(
            children: [
              IconButton(
                onPressed: onBack,
                tooltip: 'Back',
                icon: const AppBackArrow(),
              ),
              ClipOval(
                child: Image.asset(
                  imagePath,
                  width: 42,
                  height: 42,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Text(name, style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconButton(
                  onPressed: () => AppInteractionFeedback.showOptions(
                    context,
                    title: 'Conversation Options',
                    options: const ['View Profile', 'Mute Notifications'],
                  ),
                  tooltip: 'Conversation options',
                  icon: const Icon(Icons.more_vert),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.fromLTRB(24, 14, 24, 16),
            itemCount: 6,
            itemBuilder: (context, index) {
              final mine = index.isEven;
              return Align(
                alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * .74,
                  constraints: const BoxConstraints(maxWidth: 313),
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  decoration: BoxDecoration(
                    color: mine ? AppColors.cream : const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Diam convallis non morbi feugiat. Eu fermentum massa fames platea tortor egestas dictum vestibulum.',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          height: 22 / 14,
                          color: AppColors.ink.withValues(alpha: .7),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '7:15pm',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.ink.withValues(alpha: .5),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => AppInteractionFeedback.showOptions(
                  context,
                  title: 'Add Attachment',
                  options: const ['Photo', 'Document', 'Camera'],
                ),
                tooltip: 'Add attachment',
                icon: const Icon(Icons.add, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: TextField(
                    controller: messageController,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15,
                      color: AppColors.ink.withValues(alpha: .8),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type something',
                      hintStyle: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15,
                        color: AppColors.ink.withValues(alpha: .5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                      border: _fieldBorder,
                      enabledBorder: _fieldBorder,
                      focusedBorder: _fieldBorder,
                    ),
                    onSubmitted: (_) => onSend(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => AppInteractionFeedback.showOptions(
                  context,
                  title: 'Camera',
                  options: const ['Take Photo', 'Choose From Gallery'],
                ),
                tooltip: 'Camera',
                icon: const Icon(Icons.camera_alt_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
