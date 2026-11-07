import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/responsive/responsive_layout.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_interaction_feedback.dart';
import '../../../../shared/widgets/navigation/youth_page_scaffold.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = <(String, String, VoidCallback?)>[
      (
        AppAssets.notifications,
        'Notifications',
        () => AppInteractionFeedback.showInfo(context, 'Notifications'),
      ),
      (
        AppAssets.editProfile,
        'Edit Profile',
        () => AppInteractionFeedback.showInfo(context, 'Edit Profile'),
      ),
      (
        AppAssets.support,
        'Help & Support',
        () => AppInteractionFeedback.showInfo(context, 'Help & Support'),
      ),
      (
        AppAssets.privacy,
        'Privacy Policy',
        () => AppInteractionFeedback.showInfo(context, 'Privacy Policy'),
      ),
      (
        AppAssets.terms,
        'Terms & Condition',
        () => AppInteractionFeedback.showInfo(context, 'Terms & Condition'),
      ),
      (AppAssets.logout, 'Logout', controller.showLogoutDialog),
      (AppAssets.delete, 'Delete Account', controller.showDeleteDialog),
    ];
    return ResponsiveLayout(
      child: YouthPageScaffold(
        currentIndex: 4,
        onNavigationTap: controller.onNavigationTap,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
          children: [
            Center(
              child: Text(
                'Profile',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 18),
            Center(
              child: ClipOval(
                child: Image.asset(
                  AppAssets.profileAvatar,
                  width: 116,
                  height: 116,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Text(
                'Angelica Jackson',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: _ProfileTag(label: '22 - 25', color: AppColors.coral),
                ),
                const SizedBox(width: 8),
                const Flexible(
                  child: _ProfileTag(
                    label: 'Behavioral Health',
                    color: AppColors.peach,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            ...settings.map(
              (setting) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  elevation: 1,
                  shadowColor: AppColors.ink.withValues(alpha: .14),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    onTap: setting.$3,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    leading: Container(
                      width: 48,
                      height: 48,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.peach.withValues(alpha: .18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SvgPicture.asset(setting.$1),
                    ),
                    title: Text(
                      setting.$2,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    trailing: const Icon(Icons.chevron_right, size: 22),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTag extends StatelessWidget {
  const _ProfileTag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodySmall
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
      ),
    );
  }
}
