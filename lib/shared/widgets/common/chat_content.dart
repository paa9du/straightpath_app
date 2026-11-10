import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_interaction_feedback.dart';
import '../buttons/app_back_arrow.dart';

final _fieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(22),
  borderSide: BorderSide(color: AppColors.ink.withValues(alpha: .1)),
);

class ChatMessage {
  const ChatMessage({required this.text, required this.mine, required this.time});
  final String text;
  final bool mine;
  final String time;
}

class ChatContent extends StatelessWidget {
  const ChatContent({
    required this.name,
    required this.imagePath,
    required this.messages,
    required this.messageController,
    required this.onBack,
    required this.onSend,
    super.key,
  });

  final String name;
  final String imagePath;
  final RxList<ChatMessage> messages;
  final TextEditingController messageController;
  final VoidCallback onBack;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Header ────────────────────────────────────────────────────────────
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF101720),
                    )),
                    Text('Online', style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF101720).withValues(alpha: .4),
                    )),
                  ],
                ),
              ),
              Builder(
                builder: (btnCtx) => IconButton(
                  onPressed: () => _showChatMenu(btnCtx),
                  tooltip: 'Conversation options',
                  icon: const Icon(Icons.more_vert),
                ),
              ),
              const SizedBox(width: 4),
            ],
          ),
        ),
        const Divider(height: 1),

        // ── Messages list ─────────────────────────────────────────────────────
        Expanded(
          child: Obx(() => messages.isEmpty
              ? const Center(
                  child: Text(
                    'No messages yet.\nSay hello!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      color: Color(0x60101720),
                    ),
                  ),
                )
              : ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.fromLTRB(20, 14, 20, 16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return _ChatBubble(msg: msg);
                  },
                )),
        ),

        // ── Input bar ─────────────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            children: [
              // + attachment button
              InkWell(
                onTap: () => AppInteractionFeedback.showOptions(
                  context,
                  title: 'Add Attachment',
                  options: const ['Photo', 'Document', 'Camera'],
                ),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.ink.withValues(alpha: .07),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 20,
                    color: AppColors.ink.withValues(alpha: .7),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Text field
              Expanded(
                child: TextField(
                  controller: messageController,
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 14,
                    color: AppColors.ink.withValues(alpha: .85),
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 14,
                      color: AppColors.ink.withValues(alpha: .4),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    border: _fieldBorder,
                    enabledBorder: _fieldBorder,
                    focusedBorder: _fieldBorder.copyWith(
                      borderSide: BorderSide(
                          color: AppColors.ink.withValues(alpha: .25)),
                    ),
                    isDense: true,
                  ),
                  onSubmitted: (_) => onSend(),
                  textInputAction: TextInputAction.send,
                  maxLines: 3,
                  minLines: 1,
                ),
              ),
              const SizedBox(width: 10),
              // Send button
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: messageController,
                builder: (context, value, child) {
                  final hasText = value.text.trim().isNotEmpty;
                  return GestureDetector(
                    onTap: hasText ? onSend : null,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: hasText
                            ? AppColors.ink
                            : AppColors.ink.withValues(alpha: .12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.send_rounded,
                        size: 18,
                        color: hasText
                            ? Colors.white
                            : AppColors.ink.withValues(alpha: .3),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.msg});
  final ChatMessage msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: msg.mine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * .72,
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 7),
        decoration: BoxDecoration(
          color: msg.mine ? AppColors.ink : const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(msg.mine ? 16 : 4),
            bottomRight: Radius.circular(msg.mine ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              msg.text,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: msg.mine
                    ? Colors.white
                    : AppColors.ink.withValues(alpha: .85),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              msg.time,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 10,
                color: msg.mine
                    ? Colors.white.withValues(alpha: .55)
                    : AppColors.ink.withValues(alpha: .4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact dropdown anchored directly below the ••• button.
void _showChatMenu(BuildContext context) {
  final RenderBox button = context.findRenderObject()! as RenderBox;
  final RenderBox overlay =
      Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
  final buttonOffset = button.localToGlobal(Offset.zero, ancestor: overlay);
  final buttonSize = button.size;
  final position = RelativeRect.fromLTRB(
    buttonOffset.dx,
    buttonOffset.dy + buttonSize.height,
    overlay.size.width - buttonOffset.dx - buttonSize.width,
    0,
  );
  showMenu<String>(
    context: context,
    position: position,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    items: [
      _menuItem(Icons.person_outline_rounded, 'View Profile'),
      _menuItem(Icons.notifications_off_outlined, 'Mute Notifications'),
    ],
  );
}

PopupMenuItem<String> _menuItem(IconData icon, String label) =>
    PopupMenuItem<String>(
      value: label,
      height: 46,
      child: Row(
        children: [
          Icon(icon, size: 20, color: const Color(0xFF101720)),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Manrope',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF101720),
            ),
          ),
        ],
      ),
    );
