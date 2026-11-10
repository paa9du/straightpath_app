import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/models/person_summary.dart';
import '../../../../shared/widgets/common/chat_content.dart';
import '../../coach_parent_flow.dart';

class CoachParentChatController extends GetxController {
  CoachParentChatController(this.flow);

  final CoachParentFlow flow;
  late final PersonSummary person;
  final messageController = TextEditingController();

  final messages = <ChatMessage>[
    ChatMessage(text: 'Hi! How is Michael doing this week?', mine: false, time: '10:00am'),
    ChatMessage(text: 'He completed his emotional check-in today.', mine: true, time: '10:02am'),
    ChatMessage(text: 'That is great progress. Any concerns?', mine: false, time: '10:03am'),
    ChatMessage(text: 'He seemed a little anxious but overall positive.', mine: true, time: '10:05am'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    person = Get.arguments is PersonSummary
        ? Get.arguments as PersonSummary
        : flow.fallbackPerson;
  }

  void send() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    messages.insert(0, ChatMessage(text: text, mine: true, time: _now()));
    messageController.clear();
  }

  String _now() {
    final t = DateTime.now();
    final h = t.hour > 12 ? t.hour - 12 : (t.hour == 0 ? 12 : t.hour);
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
