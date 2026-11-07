import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import 'intake_controller.dart';

class IntakeView extends GetView<IntakeController> {
  const IntakeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: SafeArea(
          child: Obx(() {
            final step = controller.step.value;
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 14),
              child: Column(
                children: [
                  SizedBox(
                    height: 52,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: controller.back,
                          tooltip: 'Back',
                          icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        Expanded(
                          child: Text(
                            'Youth Intake Form',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        SizedBox(
                          width: 48,
                          child: Text(
                            '${step + 1}/4',
                            textAlign: TextAlign.right,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 220),
                      child: SingleChildScrollView(
                        key: ValueKey(step),
                        child: switch (step) {
                          0 => _StepOne(controller: controller),
                          1 => _StepTwo(controller: controller),
                          2 => _StepThree(controller: controller),
                          _ => _StepFour(controller: controller),
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  AppPrimaryButton(
                    label: 'Continue (${step + 1}/4)',
                    onPressed: controller.next,
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _StepOne extends StatelessWidget {
  const _StepOne({required this.controller});

  final IntakeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('STEP 1: Participant Identification (Required)'),
        _Field(
          controller: controller.fullNameController,
          hint: 'Full Legal Name',
        ),
        _Field(
          controller: controller.dateOfBirthController,
          hint: 'Date of Birth',
        ),
        _Field(controller: controller.ageController, hint: 'Age'),
        _Field(
          controller: controller.languageController,
          hint: 'Preferred Language',
        ),
        const SizedBox(height: 14),
        const _SectionTitle('STEP 2: Why Are You Here?'),
        ...[
          'I’m here because of a court or probation requirement',
          'I’m here for support with my behavior, emotions, or mental health',
          'I’m here for housing or life transition support',
          'I’m here for after-school or youth development activities',
        ].map((value) => _LargeChoice(value: value, controller: controller)),
      ],
    );
  }
}

class _StepTwo extends StatelessWidget {
  const _StepTwo({required this.controller});

  final IntakeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Were You Referred By Someone?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 14),
        _WrapChoices(
          controller: controller,
          values: const [
            'Court Or Probation Officer',
            'School Or Teacher',
            'Parent Or Guardian',
            'Case Worker Or Coach',
            'Community Organization',
            'I Signed Up Myself',
          ],
        ),
        const SizedBox(height: 20),
        const _SectionTitle('STEP 3: Court Or Legal Involvement'),
        _Question(
          text: 'Are you currently involved with the court system?',
          controller: controller,
          values: const ['Yes', 'No'],
        ),
        _Question(
          text: 'Which best describes your situation?',
          controller: controller,
          values: const [
            'Probation',
            'Court-Ordered Program',
            'Diversion Program',
          ],
        ),
        _Question(
          text: 'Does the court require progress or attendance reports?',
          controller: controller,
          values: const ['Yes', 'No', 'I’m Not Sure'],
        ),
      ],
    );
  }
}

class _StepThree extends StatelessWidget {
  const _StepThree({required this.controller});

  final IntakeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionTitle('STEP 4: Current Living Situation'),
        Text(
          'Where are you living right now?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        ...[
          'With a parent or guardian',
          'In transitional or supported housing',
          'Staying with friends/family temporarily',
          'I don’t have a stable place right now',
        ].map(
          (value) =>
              _LargeChoice(value: value, controller: controller, filled: true),
        ),
        _Question(
          text: 'Is there an adult who helps take care of you or supports you?',
          controller: controller,
          values: const ['Yes', 'No'],
        ),
        const _SectionTitle('STEP 5: Parent / Guardian Involvement'),
        _Question(
          text: 'Is it okay for a parent or guardian to see your progress?',
          controller: controller,
          values: const ['Yes', 'No'],
        ),
      ],
    );
  }
}

class _StepFour extends StatelessWidget {
  const _StepFour({required this.controller});

  final IntakeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'If yes, what should they be able to see?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 10),
        _WrapChoices(
          controller: controller,
          values: const [
            'Progress Updates Only',
            'Messages With Your Coach',
            'Both',
          ],
        ),
        const SizedBox(height: 20),
        const _SectionTitle('Enter Parent/Guardian Details:'),
        _Field(
          controller: controller.guardianNameController,
          hint: 'Full Name',
        ),
        _Field(
          controller: controller.guardianEmailController,
          hint: 'Email Address',
        ),
        const _SectionTitle('Permissions'),
        _Question(
          text: 'Do you agree to participate in this program using this app?',
          controller: controller,
          values: const ['Yes', 'No'],
        ),
        _Question(
          text: 'Do you agree that your coach can use this app to support you and track progress?',
          controller: controller,
          values: const ['Yes', 'No'],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(bottom: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.controller, required this.hint});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: const Color(0xFFF7F7F7),
        ),
      ),
    );
  }
}

class _LargeChoice extends StatelessWidget {
  const _LargeChoice({
    required this.value,
    required this.controller,
    this.filled = false,
  });

  final String value;
  final IntakeController controller;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final active = controller.selected.contains(value);
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () => controller.toggle(value),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
            decoration: BoxDecoration(
              color: active
                  ? AppColors.coral.withValues(alpha: .12)
                  : filled
                  ? const Color(0xFFF7F7F7)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: filled
                  ? null
                  : Border.all(color: AppColors.ink.withValues(alpha: .2)),
            ),
            child: Text(value, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      );
    });
  }
}

class _WrapChoices extends StatelessWidget {
  const _WrapChoices({required this.controller, required this.values});

  final IntakeController controller;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: values.map((value) {
          final active = controller.selected.contains(value);
          return ChoiceChip(
            label: Text(value),
            selected: active,
            onSelected: (_) => controller.toggle(value),
            selectedColor: AppColors.coral.withValues(alpha: .18),
            side: BorderSide.none,
          );
        }).toList(),
      ),
    );
  }
}

class _Question extends StatelessWidget {
  const _Question({
    required this.text,
    required this.controller,
    required this.values,
  });

  final String text;
  final IntakeController controller;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 10),
          _WrapChoices(controller: controller, values: values),
        ],
      ),
    );
  }
}
