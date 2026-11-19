import '../../core/constants/app_assets.dart';
import '../../shared/models/person_summary.dart';

abstract final class MockPeople {
  static const all = <PersonSummary>[
    PersonSummary(
      name: 'Rick Martin',
      program: 'Court-Involved Juvenile',
      imagePath: AppAssets.rick,
      completedSteps: 2,
      tracker: TrackerKind.program,
      weeklyProgress: 40,
    ),
    PersonSummary(
      name: 'Lisa Harmon',
      program: 'Court-Involved Juvenile',
      imagePath: AppAssets.lisa,
      completedSteps: 4,
      weeklyProgress: 60,
    ),
    PersonSummary(
      name: 'Ethan Hunt',
      program: 'Court-Involved Juvenile',
      imagePath: AppAssets.ethan,
      completedSteps: 2,
    ),
    PersonSummary(
      name: 'Peter Dinkelman',
      program: 'Court-Involved Juvenile',
      imagePath: AppAssets.peter,
      completedSteps: 2,
    ),
  ];

  static const parent = <PersonSummary>[
    PersonSummary(
      name: 'Rick Martin',
      program: 'Court-Involved Juvenile',
      imagePath: AppAssets.rick,
      completedSteps: 2,
      tracker: TrackerKind.program,
      weeklyProgress: 40,
    ),
  ];
}
