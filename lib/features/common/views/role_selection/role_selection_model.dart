import '../../../../core/constants/app_assets.dart';

enum UserRole {
  youth(
    title: 'YOUTH',
    description: 'Your daily space to learn, reflect, and grow.',
    assetPath: AppAssets.youthRole,
  ),
  coach(
    title: 'COACH',
    description: 'Guide progress, track outcomes, and support growth.',
    assetPath: AppAssets.coachRole,
  ),
  parent(
    title: 'PARENT',
    description: 'Stay informed and support your child’s journey.',
    assetPath: AppAssets.parentRole,
  );

  const UserRole({
    required this.title,
    required this.description,
    required this.assetPath,
  });

  final String title;
  final String description;
  final String assetPath;
}
