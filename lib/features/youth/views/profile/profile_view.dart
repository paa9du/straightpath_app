import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/utils/app_interaction_feedback.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'profile_controller.dart';

const _ink = Color(0xFF101720);
const _tileColor = Color(0xFFEAB078);
const _danger = Color(0xFFC72121);

TextStyle _t(double size, FontWeight w, Color c) => TextStyle(
      fontFamily: 'Manrope',
      fontSize: size,
      fontWeight: w,
      color: c,
    );

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    void info(String label) => AppInteractionFeedback.showInfo(context, label);
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 4,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            _Header(),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _MenuCard(
                    rows: [
                      _MenuRow(
                        icon: AppAssets.editProfile,
                        label: 'Edit Profile',
                        onTap: () => info('Edit Profile'),
                      ),
                      _MenuRow(
                        icon: AppAssets.notifications,
                        label: 'Notifications',
                        trailing: Obx(
                          () => _Toggle(on: controller.notificationsOn.value),
                        ),
                        onTap: () => controller.notificationsOn.toggle(),
                      ),
                      _MenuRow(
                        icon: AppAssets.support,
                        label: 'Help & Support',
                        onTap: () => info('Help & Support'),
                      ),
                      _MenuRow(
                        icon: AppAssets.privacy,
                        label: 'Privacy Policy',
                        onTap: () => info('Privacy Policy'),
                      ),
                      _MenuRow(
                        icon: AppAssets.terms,
                        label: 'Terms & Condition',
                        onTap: () => info('Terms & Condition'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _MenuCard(
                    rows: [
                      _MenuRow(
                        icon: AppAssets.logout,
                        label: 'Logout',
                        onTap: controller.showLogoutDialog,
                      ),
                      _MenuRow(
                        icon: AppAssets.delete,
                        label: 'Delete Account',
                        color: _danger,
                        onTap: controller.showDeleteDialog,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _CurveClipper(),
      child: Container(
        color: const Color(0xFFFFFDEE),
        padding: const EdgeInsets.fromLTRB(20, 13, 20, 44),
        child: Column(
          children: [
            Text('Profile', style: _t(24, FontWeight.w700, _ink)),
            const SizedBox(height: 18),
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFF6464), width: 2),
              ),
              child: ClipOval(
                child: Image.asset(AppAssets.profileAvatar, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 10),
            Text('Angelica Jackson', style: _t(18.35, FontWeight.w700, _ink)),
            const SizedBox(height: 3),
            Text(
              '@angle_jack20',
              style: _t(14, FontWeight.w700, const Color(0xFFFF6464)),
            ),
            const SizedBox(height: 15),
            const _TagPill(),
          ],
        ),
      ),
    );
  }
}

class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const edge = 32.0;
    return Path()
      ..lineTo(0, size.height - edge)
      ..quadraticBezierTo(
        size.width / 2,
        size.height + edge,
        size.width,
        size.height - edge,
      )
      ..lineTo(size.width, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _TagPill extends StatelessWidget {
  const _TagPill();

  @override
  Widget build(BuildContext context) {
    Widget pill(String text, Color color, double size, double width) =>
        Container(
          width: width,
          height: 24,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(40),
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(text, style: _t(size, FontWeight.w700, Colors.white)),
          ),
        );
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: const Color(0xFFE2E2E2)),
        boxShadow: const [
          BoxShadow(color: Color(0x08161616), blurRadius: 8, spreadRadius: 2),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          pill('22 - 25', const Color(0xFFE8777E), 16, 87),
          const SizedBox(width: 6),
          pill('Wellness Program', const Color(0xFFEAB078), 13, 153),
        ],
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  const _MenuCard({required this.rows});

  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: _ink.withValues(alpha: .06)),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 4, spreadRadius: 1),
        ],
      ),
      child: Column(children: rows),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
    this.color = _tileColor,
  });

  final String icon;
  final String label;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 64,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  icon,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  label,
                  style: _t(16, FontWeight.w600, _ink.withValues(alpha: .9))
                      .copyWith(height: 1.5),
                ),
              ),
              trailing ??
                  const Icon(Icons.chevron_right_rounded,
                      size: 24, color: _ink),
            ],
          ),
        ),
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  const _Toggle({required this.on});

  final bool on;

  @override
  Widget build(BuildContext context) {
    final c = const Color(0xFF111C25).withValues(alpha: .3);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: 40,
      height: 19,
      padding: const EdgeInsets.all(2),
      alignment: on ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.4),
        border: Border.all(color: on ? const Color(0xFFFF6464) : c),
      ),
      child: Container(
        width: 13,
        height: 13,
        decoration: BoxDecoration(
          color: on ? const Color(0xFFFF6464) : c,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
