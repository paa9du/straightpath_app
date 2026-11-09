import '../../app/routes/app_routes.dart';
import '../../core/constants/app_assets.dart';
import '../../core/utils/flow_navigation.dart';
import '../../data/mock/mock_people.dart';
import '../../shared/models/person_summary.dart';

/// Describes everything that differs between the coach and parent flows.
/// All screens under `features/coach_parent` are shared and read this config.
class CoachParentFlow {
  const CoachParentFlow._({
    required this.navigate,
    required this.youthDetailRoute,
    required this.noteHistoryRoute,
    required this.chatRoute,
    required this.homePeople,
    required this.fallbackPerson,
    required this.profileName,
    required this.profileImage,
    required this.profileProgram,
    required this.canAddYouth,
  });

  /// Switches bottom-navigation tab: `(currentIndex, targetIndex)`.
  final void Function(int currentIndex, int targetIndex) navigate;
  final String youthDetailRoute;
  final String noteHistoryRoute;
  final String chatRoute;
  final List<PersonSummary> homePeople;
  final PersonSummary fallbackPerson;
  final String profileName;
  final String profileImage;
  final String profileProgram;
  final bool canAddYouth;

  static final coach = CoachParentFlow._(
    navigate: FlowNavigation.coach,
    youthDetailRoute: AppRoutes.coachYouthDetail,
    noteHistoryRoute: AppRoutes.coachNoteHistory,
    chatRoute: AppRoutes.coachChat,
    homePeople: MockPeople.all,
    fallbackPerson: MockPeople.all.first,
    profileName: 'Rick Martin',
    profileImage: AppAssets.rick,
    profileProgram: 'Wellness Program',
    canAddYouth: true,
  );

  static final parent = CoachParentFlow._(
    navigate: FlowNavigation.parent,
    youthDetailRoute: AppRoutes.parentYouthDetail,
    noteHistoryRoute: AppRoutes.parentNoteHistory,
    chatRoute: AppRoutes.parentChat,
    homePeople: MockPeople.all,
    fallbackPerson: MockPeople.parent.first,
    profileName: 'Robert Miles',
    profileImage: AppAssets.profileAvatar,
    profileProgram: 'Parent',
    canAddYouth: true,
  );
}
