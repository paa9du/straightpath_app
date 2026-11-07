import 'package:get/get.dart';

import '../../features/coach/views/home/home_binding.dart' as coach;
import '../../features/coach/views/home/home_view.dart' as coach;
import '../../features/coach/views/chat/chat_binding.dart' as coach_chat;
import '../../features/coach/views/chat/chat_view.dart' as coach_chat;
import '../../features/coach/views/messages/messages_binding.dart'
    as coach_messages;
import '../../features/coach/views/messages/messages_view.dart'
    as coach_messages;
import '../../features/coach/views/notes/notes_binding.dart' as coach_notes;
import '../../features/coach/views/notes/notes_view.dart' as coach_notes;
import '../../features/coach/views/note_history/note_history_binding.dart'
    as coach_note_history;
import '../../features/coach/views/note_history/note_history_view.dart'
    as coach_note_history;
import '../../features/coach/views/profile/profile_binding.dart'
    as coach_profile;
import '../../features/coach/views/profile/profile_view.dart' as coach_profile;
import '../../features/coach/views/youths/youths_binding.dart' as coach_youths;
import '../../features/coach/views/youths/youths_view.dart' as coach_youths;
import '../../features/coach/views/youth_detail/youth_detail_binding.dart'
    as coach_youth_detail;
import '../../features/coach/views/youth_detail/youth_detail_view.dart'
    as coach_youth_detail;
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
import '../../features/parent/views/home/home_binding.dart' as parent;
import '../../features/parent/views/home/home_view.dart' as parent;
import '../../features/parent/views/chat/chat_binding.dart' as parent_chat;
import '../../features/parent/views/chat/chat_view.dart' as parent_chat;
import '../../features/parent/views/messages/messages_binding.dart'
    as parent_messages;
import '../../features/parent/views/messages/messages_view.dart'
    as parent_messages;
import '../../features/parent/views/notes/notes_binding.dart' as parent_notes;
import '../../features/parent/views/notes/notes_view.dart' as parent_notes;
import '../../features/parent/views/note_history/note_history_binding.dart'
    as parent_note_history;
import '../../features/parent/views/note_history/note_history_view.dart'
    as parent_note_history;
import '../../features/parent/views/profile/profile_binding.dart'
    as parent_profile;
import '../../features/parent/views/profile/profile_view.dart'
    as parent_profile;
import '../../features/parent/views/youths/youths_binding.dart'
    as parent_youths;
import '../../features/parent/views/youths/youths_view.dart' as parent_youths;
import '../../features/parent/views/youth_detail/youth_detail_binding.dart'
    as parent_youth_detail;
import '../../features/parent/views/youth_detail/youth_detail_view.dart'
    as parent_youth_detail;
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
import '../../features/youth/views/weekly/weekly_binding.dart';
import '../../features/youth/views/weekly/weekly_view.dart';
import '../../features/youth/views/weekly_detail/weekly_detail_binding.dart';
import '../../features/youth/views/weekly_detail/weekly_detail_view.dart';
import 'app_routes.dart';

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
      page: coach.HomeView.new,
      binding: coach.HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachYouths,
      page: coach_youths.YouthsView.new,
      binding: coach_youths.YouthsBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachYouthDetail,
      page: coach_youth_detail.YouthDetailView.new,
      binding: coach_youth_detail.YouthDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.coachNotes,
      page: coach_notes.NotesView.new,
      binding: coach_notes.NotesBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachNoteHistory,
      page: coach_note_history.NoteHistoryView.new,
      binding: coach_note_history.NoteHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.coachMessages,
      page: coach_messages.MessagesView.new,
      binding: coach_messages.MessagesBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.coachChat,
      page: coach_chat.ChatView.new,
      binding: coach_chat.ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.coachProfile,
      page: coach_profile.ProfileView.new,
      binding: coach_profile.ProfileBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentHome,
      page: parent.HomeView.new,
      binding: parent.HomeBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentYouths,
      page: parent_youths.YouthsView.new,
      binding: parent_youths.YouthsBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentYouthDetail,
      page: parent_youth_detail.YouthDetailView.new,
      binding: parent_youth_detail.YouthDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.parentNotes,
      page: parent_notes.NotesView.new,
      binding: parent_notes.NotesBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentNoteHistory,
      page: parent_note_history.NoteHistoryView.new,
      binding: parent_note_history.NoteHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.parentMessages,
      page: parent_messages.MessagesView.new,
      binding: parent_messages.MessagesBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.parentChat,
      page: parent_chat.ChatView.new,
      binding: parent_chat.ChatBinding(),
    ),
    GetPage(
      name: AppRoutes.parentProfile,
      page: parent_profile.ProfileView.new,
      binding: parent_profile.ProfileBinding(),
      transition: Transition.noTransition,
    ),
  ];
}
