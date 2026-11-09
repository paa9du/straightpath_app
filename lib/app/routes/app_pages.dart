import 'package:get/get.dart';

import '../../features/common/views/create_account/create_account_binding.dart';
import '../../features/common/views/create_account/create_account_view.dart';
import '../../features/common/views/forgot_password/forgot_password_binding.dart';
import '../../features/common/views/forgot_password/forgot_password_view.dart';
import '../../features/common/views/login/login_binding.dart';
import '../../features/common/views/login/login_view.dart';
import '../../features/common/views/otp_verification/otp_verification_binding.dart';
import '../../features/common/views/otp_verification/otp_verification_view.dart';
import '../../features/common/views/profile_details/profile_details_binding.dart';
import '../../features/common/views/profile_details/profile_details_view.dart';
import '../../features/common/views/program_overview/program_overview_binding.dart';
import '../../features/common/views/program_overview/program_overview_view.dart';
import '../../features/common/views/role_selection/role_selection_binding.dart';
import '../../features/common/views/role_selection/role_selection_view.dart';
import '../../features/common/views/splash/splash_binding.dart';
import '../../features/common/views/splash/splash_view.dart';
import '../../features/youth/views/chat/chat_binding.dart' as youth_chat;
import '../../features/youth/views/chat/chat_view.dart' as youth_chat;
import '../../features/youth/views/emotional_check_in/emotional_check_in_binding.dart';
import '../../features/youth/views/emotional_check_in/emotional_check_in_view.dart';
import '../../features/youth/views/focus/focus_binding.dart';
import '../../features/youth/views/focus/focus_view.dart';
import '../../features/youth/views/guided_activity/guided_activity_binding.dart';
import '../../features/youth/views/guided_activity/guided_activity_view.dart';
import '../../features/youth/views/home/home_binding.dart' as youth;
import '../../features/youth/views/home/home_view.dart' as youth;
import '../../features/youth/views/intake/intake_binding.dart';
import '../../features/youth/views/intake/intake_view.dart';
import '../../features/youth/views/messages/messages_binding.dart';
import '../../features/youth/views/messages/messages_view.dart';
import '../../features/youth/views/profile/profile_binding.dart';
import '../../features/youth/views/profile/profile_view.dart';
import '../../features/youth/views/mood_check_in/mood_check_in_binding.dart';
import '../../features/youth/views/mood_check_in/mood_check_in_view.dart';
import '../../features/youth/views/reflection/reflection_binding.dart';
import '../../features/youth/views/reflection/reflection_view.dart';
import '../../features/youth/views/skill_detail/skill_detail_binding.dart';
import '../../features/youth/views/skill_detail/skill_detail_view.dart';
import '../../features/youth/views/skills/skills_binding.dart';
import '../../features/youth/views/skills/skills_view.dart';
import '../../features/youth/views/emotional_regulation/emotional_regulation_binding.dart';
import '../../features/youth/views/emotional_regulation/emotional_regulation_view.dart';
import '../../features/youth/views/weekly/weekly_binding.dart';
import '../../features/youth/views/weekly/weekly_view.dart';
import '../../features/youth/views/weekly_detail/weekly_detail_binding.dart';
import '../../features/youth/views/weekly_detail/weekly_detail_view.dart';
import 'app_routes.dart';
import '../../features/coach_parent/views/home/coach_parent_home_binding.dart';
import '../../features/coach_parent/views/home/coach_parent_home_view.dart';
import '../../features/coach_parent/views/youths/coach_parent_youths_binding.dart';
import '../../features/coach_parent/views/youths/coach_parent_youths_view.dart';
import '../../features/coach_parent/views/youth_detail/coach_parent_youth_detail_binding.dart';
import '../../features/coach_parent/views/youth_detail/coach_parent_youth_detail_view.dart';
import '../../features/coach_parent/views/notes/coach_parent_notes_binding.dart';
import '../../features/coach_parent/views/notes/coach_parent_notes_view.dart';
import '../../features/coach_parent/views/note_history/coach_parent_note_history_binding.dart';
import '../../features/coach_parent/views/note_history/coach_parent_note_history_view.dart';
import '../../features/coach_parent/views/messages/coach_parent_messages_binding.dart';
import '../../features/coach_parent/views/messages/coach_parent_messages_view.dart';
import '../../features/coach_parent/views/chat/coach_parent_chat_binding.dart';
import '../../features/coach_parent/views/chat/coach_parent_chat_view.dart';
import '../../features/coach_parent/views/profile/coach_parent_profile_binding.dart';
import '../../features/coach_parent/views/profile/coach_parent_profile_view.dart';
import '../../features/coach_parent/coach_parent_flow.dart';

abstract final class AppPages {
  static final pages = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.splash,
      page: SplashView.new,
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.programOverview,
      page: ProgramOverviewView.new,
      binding: ProgramOverviewBinding(),
    ),
    GetPage(
      name: AppRoutes.roleSelection,
      page: RoleSelectionView.new,
      binding: RoleSelectionBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: LoginView.new,
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: ForgotPasswordView.new,
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.createAccount,
      page: CreateAccountView.new,
      binding: CreateAccountBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: OtpVerificationView.new,
      binding: OtpVerificationBinding(),
    ),
    GetPage(
      name: AppRoutes.profileDetails,
      page: ProfileDetailsView.new,
      binding: ProfileDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.youthIntake,
      page: IntakeView.new,
      binding: IntakeBinding(),
    ),
    GetPage(
      name: AppRoutes.youthHome,
      page: youth.HomeView.new,
      binding: youth.HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.youthWeekly,
      page: WeeklyView.new,
      binding: WeeklyBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.youthEmotionalRegulation,
      page: EmotionalRegulationView.new,
      binding: EmotionalRegulationBinding(),
    ),
    GetPage(
      name: AppRoutes.youthWeeklyDetail,
      page: WeeklyDetailView.new,
      binding: WeeklyDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.youthMoodCheckIn,
      page: MoodCheckInView.new,
      binding: MoodCheckInBinding(),
    ),
    GetPage(
      name: AppRoutes.youthEmotionalCheckIn,
      page: EmotionalCheckInView.new,
      binding: EmotionalCheckInBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.youthFocus,
      page: FocusView.new,
      binding: FocusBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.youthGuidedActivity,
      page: GuidedActivityView.new,
      binding: GuidedActivityBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.youthReflection,
      page: ReflectionView.new,
      binding: ReflectionBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.youthSkills,
      page: SkillsView.new,
      binding: SkillsBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.youthSkillDetail,
      page: SkillDetailView.new,
      binding: SkillDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.youthMessages,
      page: MessagesView.new,
      binding: MessagesBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.youthChat,
      page: youth_chat.ChatView.new,
      binding: youth_chat.ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.youthProfile,
      page: ProfileView.new,
      binding: ProfileBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachHome,
      page: CoachParentHomeView.new,
      binding: CoachParentHomeBinding(CoachParentFlow.coach),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachYouths,
      page: CoachParentYouthsView.new,
      binding: CoachParentYouthsBinding(CoachParentFlow.coach),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachYouthDetail,
      page: CoachParentYouthDetailView.new,
      binding: CoachParentYouthDetailBinding(CoachParentFlow.coach),
    ),
    GetPage(
      name: AppRoutes.coachNotes,
      page: CoachParentNotesView.new,
      binding: CoachParentNotesBinding(CoachParentFlow.coach),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachNoteHistory,
      page: CoachParentNoteHistoryView.new,
      binding: CoachParentNoteHistoryBinding(CoachParentFlow.coach),
    ),
    GetPage(
      name: AppRoutes.coachMessages,
      page: CoachParentMessagesView.new,
      binding: CoachParentMessagesBinding(CoachParentFlow.coach),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachChat,
      page: CoachParentChatView.new,
      binding: CoachParentChatBinding(CoachParentFlow.coach),
    ),
    GetPage(
      name: AppRoutes.coachProfile,
      page: CoachParentProfileView.new,
      binding: CoachParentProfileBinding(CoachParentFlow.coach),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentHome,
      page: CoachParentHomeView.new,
      binding: CoachParentHomeBinding(CoachParentFlow.parent),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentYouths,
      page: CoachParentYouthsView.new,
      binding: CoachParentYouthsBinding(CoachParentFlow.parent),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentYouthDetail,
      page: CoachParentYouthDetailView.new,
      binding: CoachParentYouthDetailBinding(CoachParentFlow.parent),
    ),
    GetPage(
      name: AppRoutes.parentNotes,
      page: CoachParentNotesView.new,
      binding: CoachParentNotesBinding(CoachParentFlow.parent),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentNoteHistory,
      page: CoachParentNoteHistoryView.new,
      binding: CoachParentNoteHistoryBinding(CoachParentFlow.parent),
    ),
    GetPage(
      name: AppRoutes.parentMessages,
      page: CoachParentMessagesView.new,
      binding: CoachParentMessagesBinding(CoachParentFlow.parent),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentChat,
      page: CoachParentChatView.new,
      binding: CoachParentChatBinding(CoachParentFlow.parent),
    ),
    GetPage(
      name: AppRoutes.parentProfile,
      page: CoachParentProfileView.new,
      binding: CoachParentProfileBinding(CoachParentFlow.parent),
      transition: Transition.noTransition,
    ),
  ];
}
