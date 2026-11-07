import '../../core/constants/app_assets.dart';
import '../../shared/models/person_summary.dart';

abstract final class MockPeople {
  static const all = <PersonSummary>[
    PersonSummary(
      name: 'Rick Martin',
      program: 'Court-Involved Juvenile',
      imagePath: AppAssets.rick,
      completedSteps: 2,
    ),
    PersonSummary(
      name: 'Lisa Harmon',
      program: 'Transitional Housing',
      imagePath: AppAssets.lisa,
      completedSteps: 4,
    ),
    PersonSummary(
      name: 'Ethan Hunt',
      program: 'After-School Initiatives',
      imagePath: AppAssets.ethan,
      completedSteps: 2,
    ),
    PersonSummary(
      name: 'Peter Dinkelman',
      program: 'Court-Involved Juvenile',
      imagePath: AppAssets.peter,
      completedSteps: 3,
    ),
  ];

  static const parent = <PersonSummary>[
    PersonSummary(
      name: 'Rick Martin',
      program: 'Court-Involved Juvenile',
      imagePath: AppAssets.rick,
      completedSteps: 2,
    ),
  ];
}
