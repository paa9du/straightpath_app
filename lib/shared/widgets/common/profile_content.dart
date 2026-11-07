import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_interaction_feedback.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    required this.name,
    required this.imagePath,
    required this.program,
    required this.onLogout,
    required this.onDelete,
    super.key,
  });

  final String name;
  final String imagePath;
  final String program;
  final VoidCallback onLogout;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final settings = <(String, String, VoidCallback?)>[
      (
        AppAssets.editProfile,
        'Edit Profile',
        () => AppInteractionFeedback.showInfo(context, 'Edit Profile'),
      ),
      (
        AppAssets.notifications,
        'Notifications',
        () => AppInteractionFeedback.showInfo(context, 'Notifications'),
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
      (AppAssets.logout, 'Logout', onLogout),
      (AppAssets.delete, 'Delete Account', onDelete),
    ];
    return ListView(
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
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(
              color: AppColors.coral,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                width: 112,
                height: 112,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(name, style: Theme.of(context).textTheme.titleMedium),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: _Tag(label: '22 - 25', color: AppColors.coral),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: _Tag(label: program, color: AppColors.peach),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          elevation: 2,
          shadowColor: const Color(0x22000000),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Column(
              children: settings
                  .map(
                    (setting) => ListTile(
                      onTap: setting.$3,
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 44,
                        height: 44,
                        padding: const EdgeInsets.all(11),
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
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        color: color,
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
