import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../shared/models/person_summary.dart';
import '../../../../shared/widgets/common/chat_content.dart';

class ChatController extends GetxController {
  late final PersonSummary person;
  final messageController = TextEditingController();

  final messages = <ChatMessage>[
    ChatMessage(text: 'Hey! How are you doing today?', mine: false, time: '9:00am'),
    ChatMessage(text: 'I saw you completed the emotional check-in. Great work!', mine: false, time: '9:01am'),
    ChatMessage(text: 'Thanks! Feeling much better now.', mine: true, time: '9:03am'),
    ChatMessage(text: 'The breathing exercise really helped me stay calm.', mine: true, time: '9:03am'),
    ChatMessage(text: 'That is wonderful to hear. Keep it up!', mine: false, time: '9:05am'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : const PersonSummary(
            name: 'Rick Martin',
            program: '',
            imagePath: AppAssets.rick,
            completedSteps: 0,
          );
  }

  void send() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    messages.insert(0, ChatMessage(text: text, mine: true, time: _now()));
    messageController.clear();
  }

  String _now() {
    final t = DateTime.now();
    final h = t.hour > 12
        ? t.hour - 12
        : (t.hour == 0 ? 12 : t.hour);
    final m = t.minute.toString().padLeft(2, '0');
    final ampm = t.hour >= 12 ? 'pm' : 'am';
    return '$h:$m$ampm';
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
