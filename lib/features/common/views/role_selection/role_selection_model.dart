import '../../../../core/constants/app_assets.dart';

enum UserRole {
  youth(
    title: 'YOUTH',
    description: 'Your daily space to learn, reflect, and grow.',
    assetPath: AppAssets.youthRole,
    imageTop: -14.84,
  ),
  coach(
    title: 'COACH',
    description: 'Guide progress, track outcomes, and support growth.',
    assetPath: AppAssets.coachRole,
    imageTop: -14.84,
  ),
  parent(
    title: 'PARENT',
    description: 'Stay informed and support your child’s journey.',
    assetPath: AppAssets.parentRole,
    imageTop: -12.84,
  );

  const UserRole({
    required this.title,
    required this.description,
    required this.assetPath,
    required this.imageTop,
  });

  final String title;
  final String description;
  final String assetPath;

  /// Figma crop: image is 200 x 300 inside a 200 x 200 window.
  final double imageTop;
}
