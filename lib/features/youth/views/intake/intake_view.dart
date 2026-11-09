import '../../../../shared/widgets/buttons/app_back_arrow.dart';
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
                          icon: const AppBackArrow(),
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
                            style: const TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
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
        const _SectionTitle(
          'STEP 1: Participant Identification ',
          suffix: '(Required)',
        ),
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
        const _SectionTitle('STEP 2: Why Are You Here?', gapAfter: 16),
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
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.ink.withValues(alpha: .8),
          ),
        ),
        const SizedBox(height: 24),
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
        const SizedBox(height: 24),
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
          style: _questionStyle(weight: FontWeight.w400),
        ),
        const SizedBox(height: 16),
        ...[
          'With a parent or guardian',
          'In transitional or supported housing',
          'Staying with friends/family temporarily',
          'I don’t have a stable place right now',
        ].map(
          (value) =>
              _LargeChoice(value: value, controller: controller, filled: true),
        ),
        const SizedBox(height: 6),
        _Question(
          text: 'Is there an adult who helps take care of you or supports you?',
          controller: controller,
          values: const ['Yes', 'No'],
        ),
        const SizedBox(height: 8),
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
          style: _questionStyle(),
        ),
        const SizedBox(height: 16),
        _WrapChoices(
          controller: controller,
          values: const [
            'Progress Updates Only',
            'Messages With Your Coach',
            'Both',
          ],
        ),
        const SizedBox(height: 21),
        const _SectionTitle('Enter Parent/Guardian Details:'),
        _Field(
          controller: controller.guardianNameController,
          hint: 'Full Name',
        ),
        _Field(
          controller: controller.guardianEmailController,
          hint: 'Email Address',
        ),
        const SizedBox(height: 11),
        const _SectionTitle('Permissions'),
        _Question(
          text: 'Do you agree to participate in this program using this app?',
          controller: controller,
          values: const ['Yes', 'No'],
          gap: 21,
        ),
        _Question(
          text: 'Do you agree that your coach can use this app to support you and track progress?',
          controller: controller,
          values: const ['Yes', 'No'],
          gap: 21,
        ),
        _Question(
          text:
              'If required, do you agree to share progress with the court or referring agency?',
          controller: controller,
          values: const ['Yes', 'No'],
          gap: 21,
        ),
      ],
    );
  }
}

TextStyle _questionStyle({FontWeight weight = FontWeight.w600}) => TextStyle(
      fontFamily: 'Manrope',
      fontSize: 17,
      fontWeight: weight,
      color: AppColors.ink.withValues(alpha: .8),
    );

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(
    this.text, {
    this.suffix,
    this.bottomPad = 25,
    this.gapAfter = 24,
  });

  final String text;
  final String? suffix;
  final double bottomPad;
  final double gapAfter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: gapAfter),
      padding: EdgeInsets.only(bottom: bottomPad),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Text.rich(
        TextSpan(
          text: text,
          style: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: AppColors.ink.withValues(alpha: .8),
          ),
          children: [
            if (suffix != null)
              TextSpan(
                text: suffix,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.ink.withValues(alpha: .2),
                ),
              ),
          ],
        ),
      ),
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
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 17,
          color: AppColors.ink,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Manrope',
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: AppColors.ink.withValues(alpha: .5),
          ),
          fillColor: const Color(0xFFF6F6F6),
          constraints: const BoxConstraints(minHeight: 60),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 17,
          ),
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
            constraints: const BoxConstraints(minHeight: 60),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(
              horizontal: filled ? 28 : 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: active
                  ? AppColors.coral.withValues(alpha: .12)
                  : filled
                  ? const Color(0xFFF6F6F6)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: filled
                  ? null
                  : Border.all(color: AppColors.ink.withValues(alpha: .2)),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: filled ? 17 : 15,
                height: filled ? null : 20 / 15,
                fontWeight: FontWeight.w400,
                color: AppColors.ink.withValues(
                  alpha: filled && !active ? .5 : .8,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _WrapChoices extends StatelessWidget {
  const _WrapChoices({
    required this.controller,
    required this.values,
    this.runSpacing = 10,
  });

  final IntakeController controller;
  final List<String> values;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 10,
        runSpacing: runSpacing,
        children: values.map((value) {
          final active = controller.selected.contains(value);
          // Short answers (Yes / No / I’m Not Sure) use wider side padding.
          final horizontalPadding =
              value == 'Both' ? 20.0 : (value.length <= 12 ? 24.0 : 10.0);
          return InkWell(
            onTap: () => controller.toggle(value),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: active
                    ? AppColors.coral.withValues(alpha: .18)
                    : const Color(0xFFF6F6F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 13,
                  height: 24 / 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.ink.withValues(alpha: .8),
                ),
              ),
            ),
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
    this.gap = 16,
  });

  final String text;
  final IntakeController controller;
  final List<String> values;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: gap),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Figma: 16px under a one-line question, 10px under a wrapped one.
          final painter = TextPainter(
            text: TextSpan(text: text, style: _questionStyle()),
            textDirection: TextDirection.ltr,
          )..layout(maxWidth: constraints.maxWidth);
          final wrapped = painter.computeLineMetrics().length > 1;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text, style: _questionStyle()),
              SizedBox(height: wrapped ? 10 : 16),
              _WrapChoices(
                controller: controller,
                values: values,
                runSpacing: 16,
              ),
            ],
          );
        },
      ),
    );
  }
}
