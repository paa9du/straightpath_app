import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/title_case.dart';
import '../../../../shared/widgets/buttons/app_primary_button.dart';
import '../../../../shared/widgets/common/app_background.dart';
import 'program_overview_controller.dart';

TextStyle _manrope(
  double size,
  FontWeight weight,
  Color color, {
  double? height,
}) =>
    TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );

final _body = _manrope(
  14,
  FontWeight.w400,
  AppColors.ink.withValues(alpha: .8),
  height: 20 / 14,
);

const _coral = Color(0xFFFF6464);

class ProgramOverviewView extends GetView<ProgramOverviewController> {
  const ProgramOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        child: AppBackground(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 14),
              child: Column(
                children: [
                  Text(
                    'Program Overview',
                    style: _manrope(24, FontWeight.w700, AppColors.ink),
                  ),
                  const SizedBox(height: 18),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: const [
                        _Card(
                          children: [
                            _CardTitle('Primary Goal'),
                            _Body(
                              'Help users understand what this program is, how it works, and what is expected, without overwhelming them or triggering resistance.',
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _Card(children: _welcomeChildren),
                        SizedBox(height: 10),
                        _Card(
                          children: [
                            _CardTitle('Youth Version'),
                            _Body(
                              'You are not expected to be perfect.\nYou are expected to participate and try.\nYour coach is here to support you.',
                            ),
                            _Divider(),
                            _CardTitle('Coach'),
                            _Body(
                              'This platform mirrors existing program workflows and documentation requirements.',
                            ),
                            _Divider(),
                            _CardTitle('Parent'),
                            _Body(
                              'This program provides structured visibility into participation and progress while respecting youth privacy.',
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        _Card(
                          children: [
                            _CardTitle('Safety & Oversight Notice', coral: false),
                            _Body(
                              'All activity and communication within this app is monitored by program staff to ensure safety, accountability, and appropriate support.',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: AppPrimaryButton(
                      label: 'Get Started',
                      onPressed: controller.getStarted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const _programText =
    'Straight Path is a guided program that works alongside your in-person coaching.\nEach day and week is structured to help you build skills, reflect on your actions, and stay on track.\nThis app is not social media.\nIt is a focused space for learning, growth, and progress.';

const _welcomeChildren = <Widget>[
  _CardTitle('Welcome to Straight Path'),
  _Body('A structured path for growth, accountability, and support'),
  _Divider(),
  _SectionTitle('Section 1 — What This Is'),
  _Body(_programText),
  _Divider(),
  _SectionTitle('Section 2 — How the Program Works'),
  _Body(_programText),
  SizedBox(height: 16),
  _NumberedItem(
    number: '1',
    title: 'Weekly Focus',
    subtitle: 'Each week has a clear topic and goal.',
  ),
  SizedBox(height: 16),
  _NumberedItem(
    number: '2',
    title: 'Daily Activities',
    subtitle: 'Short, guided steps you complete each day.',
  ),
  SizedBox(height: 16),
  _NumberedItem(
    number: '3',
    title: 'Reflection & Skills',
    subtitle: 'Tools to help manage emotions and make better decisions.',
  ),
  SizedBox(height: 16),
  _NumberedItem(
    number: '4',
    title: 'Progress Tracking',
    subtitle: 'Your effort and growth are recorded and reviewed by your coach.',
  ),
  _Divider(),
  _SectionTitle('Section 3 — What to Expect'),
  _Bullets(),
  _Divider(),
  _SectionTitle('Section 3 — What to Expect'),
  _Bullets(),
];

/// White card: 20px side padding, 16px top/bottom, radius 16.
class _Card extends StatelessWidget {
  const _Card({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

/// 20 extra-bold heading; 6px below it the body starts (Figma 49 - 43).
class _CardTitle extends StatelessWidget {
  const _CardTitle(this.text, {this.coral = true});

  final String text;
  final bool coral;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        titleCase(text),
        style: _manrope(
          20,
          FontWeight.w800,
          coral ? _coral : AppColors.ink.withValues(alpha: .8),
        ),
      ),
    );
  }
}

/// 16 extra-bold section heading; 10px below it the body starts.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        titleCase(text),
        style: _manrope(16, FontWeight.w800, AppColors.ink.withValues(alpha: .8)),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Text(titleCase(text), style: _body);
}

/// Dashed separator, 16px above and 16px below.
class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 1,
        width: double.infinity,
        child: CustomPaint(painter: _DashPainter()),
      ),
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.ink.withValues(alpha: .15)
      ..strokeWidth = 1;
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, 0), Offset((x + 4).clamp(0, size.width), 0), paint);
      x += 7;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _NumberedItem extends StatelessWidget {
  const _NumberedItem({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  final String number;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final ink = AppColors.ink.withValues(alpha: .8);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.yellow,
            shape: BoxShape.circle,
          ),
          child: Text(number, style: _manrope(16, FontWeight.w800, ink)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: titleCase(title),
                  style: _manrope(14, FontWeight.w600, ink, height: 20 / 14),
                ),
                TextSpan(
                  text: '\n${titleCase(subtitle)}',
                  style: _manrope(13, FontWeight.w400, ink, height: 20 / 13),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Bullets extends StatelessWidget {
  const _Bullets();

  static const _items = [
    'Clear daily routines',
    'Supportive, not judgmental guidance',
    'Private and secure participation',
    'Coach oversight and accountability',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in _items)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 21, child: Text('•', style: _body)),
              Expanded(child: Text(titleCase(item), style: _body)),
            ],
          ),
      ],
    );
  }
}
