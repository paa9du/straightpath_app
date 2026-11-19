import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_interaction_feedback.dart';

final _fieldBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.75),
  borderSide: BorderSide(
    color: AppColors.ink.withValues(alpha: .1),
    width: 1.09,
  ),
);

/// Inline strip shown under the input bar when + is tapped (Figma 890:3887).
class _AttachmentStrip extends StatelessWidget {
  const _AttachmentStrip({required this.onSelect});

  final ValueChanged<String> onSelect;

  static const _options = [
    (AppAssets.chatAttachCamera, 'Camera'),
    (AppAssets.chatAttachGallery, 'Gallery'),
    (AppAssets.chatAttachDocument, 'Document'),
    (AppAssets.chatAttachVideo, 'Video'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(26.26, 4, 26.26, 24),
          child: Row(
            children: [
              for (final (asset, label) in _options)
                Expanded(
                  child: _AttachmentOption(
                    asset: asset,
                    label: label,
                    onTap: () => onSelect(label),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 38px tinted circle + 20px icon (one SVG), Manrope Medium 14 #757575 label.
class _AttachmentOption extends StatelessWidget {
  const _AttachmentOption({
    required this.asset,
    required this.label,
    required this.onTap,
  });

  final String asset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(asset, width: 38, height: 38),
            const SizedBox(height: 5),
            Text(
              label,
              maxLines: 1,
              style: const TextStyle(
                fontFamily: 'Manrope',
                fontSize: 14,
                height: 22 / 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF757575),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 26.26px Figma icon, vertically centred on the 43.77px input box.
class _InputIcon extends StatelessWidget {
  const _InputIcon({
    required this.asset,
    required this.label,
    required this.onTap,
  });

  final String asset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          height: 43.77,
          child: Center(
            child: SvgPicture.asset(asset, width: 26.26, height: 26.26),
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.mine,
    required this.time,
  });
  final String text;
  final bool mine;
  final String time;
}

class ChatContent extends StatefulWidget {
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
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  final _inputFocus = FocusNode();
  bool _showAttachments = false;

  @override
  void initState() {
    super.initState();
    _inputFocus.addListener(() {
      if (_inputFocus.hasFocus && _showAttachments) {
        setState(() => _showAttachments = false);
      }
    });
  }

  @override
  void dispose() {
    _inputFocus.dispose();
    super.dispose();
  }

  void _toggleAttachments() {
    if (!_showAttachments) _inputFocus.unfocus();
    setState(() => _showAttachments = !_showAttachments);
  }

  void _send() {
    widget.onSend();
    if (_showAttachments) setState(() => _showAttachments = false);
  }

  void _selectAttachment(String label) {
    setState(() => _showAttachments = false);
    AppInteractionFeedback.showInfo(context, label);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_showAttachments,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) setState(() => _showAttachments = false);
      },
      child: Column(
        children: [
          // ── Header (Figma 475:1398) ───────────────────────────────────────────
          // Chevron 26.26, avatar 43.77, name Bold 17.5, dots 17.5,
          // 26.26 side padding, #EAEAEA bottom line.
          Container(
            // Right is 4 less so the dots (with their 4px tap padding) sit
            // on the Figma edge.
            padding: const EdgeInsets.fromLTRB(26.26, 8, 22.26, 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFEAEAEA), width: 1.09),
              ),
            ),
            child: SizedBox(
              height: 45.95,
              child: Row(
                children: [
                  Semantics(
                    button: true,
                    label: 'Back',
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: widget.onBack,
                      child: SvgPicture.asset(
                        AppAssets.chatBack,
                        width: 26.26,
                        height: 26.26,
                      ),
                    ),
                  ),
                  const SizedBox(width: 17.51),
                  ClipOval(
                    child: Image.asset(
                      widget.imagePath,
                      width: 43.77,
                      height: 43.77,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8.75),
                  Expanded(
                    child: Text(
                      widget.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 17.51,
                        height: 26.26 / 17.51,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF101720),
                      ),
                    ),
                  ),
                  Builder(
                    builder: (btnCtx) => Semantics(
                      button: true,
                      label: 'Conversation options',
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => _showChatMenu(btnCtx),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            AppAssets.chatDots,
                            width: 17.51,
                            height: 17.51,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Messages list ─────────────────────────────────────────────────────
          Expanded(
            child: Obx(
              () => widget.messages.isEmpty
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
                      itemCount: widget.messages.length,
                      itemBuilder: (context, index) {
                        final msg = widget.messages[index];
                        return _ChatBubble(msg: msg);
                      },
                    ),
            ),
          ),

          // ── Input bar (Figma 475:1417) ────────────────────────────────────────
          // Plus 26.26 · 17.5 gap · white box (43.77 tall, 8.75 radius,
          // 10% ink border, "Type something") · 17.5 gap · send 43.77 (Figma 890:3882).
          Container(
            padding: const EdgeInsets.fromLTRB(27, 17.51, 25.5, 17.51),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Color(0xFFEAEAEA), width: 1.09),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // + attachment button (Figma 475:1419)
                _InputIcon(
                  asset: AppAssets.chatPlus,
                  label: 'Add attachment',
                  onTap: _toggleAttachments,
                ),
                const SizedBox(width: 17.51),
                // Text field (Figma 475:1422)
                Expanded(
                  child: TextField(
                    controller: widget.messageController,
                    focusNode: _inputFocus,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 15.32,
                      color: AppColors.ink.withValues(alpha: .85),
                    ),
                    decoration: InputDecoration(
                      hintText: 'Type something',
                      hintStyle: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 15.32,
                        color: AppColors.ink.withValues(alpha: .5),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      constraints: const BoxConstraints(minHeight: 43.77),
                      contentPadding: const EdgeInsets.fromLTRB(
                        25.17,
                        11.5,
                        16,
                        11.5,
                      ),
                      border: _fieldBorder,
                      enabledBorder: _fieldBorder,
                      focusedBorder: _fieldBorder.copyWith(
                        borderSide: BorderSide(
                          color: AppColors.ink.withValues(alpha: .25),
                          width: 1.09,
                        ),
                      ),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _send(),
                    textInputAction: TextInputAction.send,
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
                const SizedBox(width: 17.51),
                Semantics(
                  button: true,
                  label: 'Send message',
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: _send,
                    child: SvgPicture.asset(
                      AppAssets.chatSend,
                      width: 43.77,
                      height: 43.77,
                    ),
                  ),
                ),
              ],
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: _showAttachments
                ? _AttachmentStrip(onSelect: _selectAttachment)
                : const SizedBox(width: double.infinity),
          ),
        ],
      ),
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
