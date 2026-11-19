import 'package:get/get.dart';

/// Static content for one program week (Figma 147).
class WeekContent {
  const WeekContent({
    required this.number,
    required this.title,
    required this.description,
    required this.startDate,
    required this.overviewTitle,
    required this.overviewDescription,
    required this.goals,
    required this.initialCompletedDays,
    required this.initialProgress,
  });

  /// Percentage shown on Figma 151 (e.g. Week 2 = 75%) until the user
  /// completes another day; after that it is completed / [programDays].
  final double initialProgress;

  final int number;
  final String title;
  final String description;
  final DateTime startDate;
  final String overviewTitle;
  final String overviewDescription;
  final List<String> goals;
  final int initialCompletedDays;

  DateTime dateOf(int dayIndex) => startDate.add(Duration(days: dayIndex));

  String get dateRange {
    final end = dateOf(6);
    return '${_short(startDate)} - ${_short(end)} ${end.year}';
  }

  /// Figma 147 uses an en dash: "23 Jan – 29 Jan 2026".
  String get overviewDateRange {
    final end = dateOf(6);
    return '${_short(startDate)} – ${_short(end)} ${end.year}';
  }
}

/// One question inside a part (Figma 149).
class DayQuestion {
  const DayQuestion(this.title, this.prompt, {this.answerCount = 1});

  final String title;
  final String prompt;

  /// Number of one-line answer boxes (Figma 849:1242 shows 5 for "Who Am I?").
  /// 1 shows a single large answer box (Figma 878:3610).
  final int answerCount;
}

/// A part of a day's activity, e.g. "Part A - Self-Discovery".
class DayPart {
  const DayPart({
    required this.letter,
    required this.name,
    required this.questions,
    required this.answers,
    required this.minutes,
  });

  final String letter;
  final String name;
  final List<DayQuestion> questions;
  final int answers;
  final int minutes;

  /// Figma 148 / 149 copy: Parts A and B use an en dash, C and D an em dash.
  String get title =>
      'Part $letter ${letter == 'A' || letter == 'B' ? '–' : '—'} $name';

  /// Worksheet screens (Figma 760:2093, 878:3423/3508/3580): only Part A
  /// uses an en dash.
  String get worksheetTitle =>
      'Part $letter ${letter == 'A' ? '–' : '—'} $name';
}

/// Static content for a day's activity (Figma 148 / 149).
class DayContent {
  const DayContent({
    required this.title,
    required this.description,
    required this.parts,
    required this.insight,
  });

  final String title;
  final String description;
  final List<DayPart> parts;
  final String insight;
}

/// Route arguments for the day screens.
class WeeklyDayArgs {
  const WeeklyDayArgs({required this.week, required this.dayIndex});

  final int week;
  final int dayIndex;
}

const weekDayNames = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

const weekDayShortNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

/// Activities run Monday-Friday; Saturday and Sunday are rest days
/// (grey in Figma 147).
const programDays = 5;

bool isWeekendDay(int dayIndex) => dayIndex >= programDays;

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _short(DateTime d) => '${d.day} ${_months[d.month - 1]}';

/// "Monday, 23 Jan"
String dayLabel(WeekContent week, int dayIndex) =>
    '${weekDayNames[dayIndex]}, ${_short(week.dateOf(dayIndex))}';

abstract final class MockWeeks {
  static const _goals = [
    'Recognize your emotions in different situations',
    'Understand what triggers your emotional responses',
    'Practice mindful and balanced reactions',
  ];

  static const _overview =
      'This week helps you notice your emotions, understand their triggers, '
      'and respond with calm and clarity.';

  static final all = <WeekContent>[
    WeekContent(
      number: 1,
      title: 'Emotional Regulation',
      description:
          'Develop awareness of emotions as they arise, without judgment.',
      startDate: DateTime(2026, 1, 23),
      overviewTitle: 'Orientation & Trust Building',
      overviewDescription: _overview,
      goals: _goals,
      initialCompletedDays: 5,
      initialProgress: 1,
    ),
    WeekContent(
      number: 2,
      title: 'Communication & Conflict Resolution',
      description:
          'Develop awareness of emotions as they arise, without judgment.',
      startDate: DateTime(2026, 1, 30),
      overviewTitle: 'Listening & Expressing Clearly',
      overviewDescription: _overview,
      goals: _goals,
      initialCompletedDays: 4,
      initialProgress: .75,
    ),
    WeekContent(
      number: 3,
      title: 'Accountability & Decision-Making',
      description:
          'Develop awareness of emotions as they arise, without judgment.',
      startDate: DateTime(2026, 2, 6),
      overviewTitle: 'Owning Your Choices',
      overviewDescription: _overview,
      goals: _goals,
      initialCompletedDays: 0,
      initialProgress: 0,
    ),
    WeekContent(
      number: 4,
      title: 'Leadership & Self-Identity',
      description:
          'Develop awareness of emotions as they arise, without judgment.',
      startDate: DateTime(2026, 2, 13),
      overviewTitle: 'Small Steps, Big Change',
      overviewDescription: _overview,
      goals: _goals,
      initialCompletedDays: 0,
      initialProgress: 0,
    ),
  ];

  static WeekContent byNumber(int number) =>
      all.firstWhere((w) => w.number == number, orElse: () => all.first);

  /// Every day uses the same activity layout for now (Figma 148 / 149).
  static const day = DayContent(
    title: 'Orientation & Trust Building',
    description:
        'Develop awareness of emotions as they arise, without judgment.',
    insight: 'You showed great self-awareness this {day}. Keep it up!',
    parts: [
      DayPart(
        letter: 'A',
        name: 'Self-Discovery',
        answers: 5,
        minutes: 1,
        // Figma 760:2093
        questions: [
          DayQuestion(
            'Who Am I?',
            'List 5 things about yourself',
            answerCount: 5,
          ),
        ],
      ),
      DayPart(
        letter: 'B',
        name: 'Strength Assessment',
        answers: 3,
        minutes: 1,
        // Figma 878:3423
        questions: [
          DayQuestion('3 strengths I have', 'List 3 things', answerCount: 3),
        ],
      ),
      DayPart(
        letter: 'C',
        name: 'Growth Areas',
        answers: 2,
        minutes: 1,
        // Figma 878:3508
        questions: [
          DayQuestion(
            '2 things I want to improve',
            'List 2 things',
            answerCount: 2,
          ),
        ],
      ),
      DayPart(
        letter: 'D',
        name: 'Identity Reflection',
        answers: 3,
        minutes: 1,
        // Figma 878:3580: three open questions on one screen.
        questions: [
          DayQuestion('What makes you different from others?', ''),
          DayQuestion('What are you proud of about yourself?', ''),
          DayQuestion('What do people misunderstand about you?', ''),
        ],
      ),
    ],
  );
}

/// In-memory progress shared by the weekly screens, so a finished day shows
/// as completed when the user goes back.
class WeeklyProgressStore extends GetxService {
  static WeeklyProgressStore get to => Get.isRegistered<WeeklyProgressStore>()
      ? Get.find<WeeklyProgressStore>()
      : Get.put(WeeklyProgressStore(), permanent: true);

  late final RxMap<int, int> _completed = {
    for (final w in MockWeeks.all) w.number: w.initialCompletedDays,
  }.obs;

  /// Weeks whose percentage still comes from Figma's mock value.
  final RxSet<int> _changed = <int>{}.obs;

  int completedDays(int week) => _completed[week] ?? 0;

  bool isDayCompleted(int week, int dayIndex) => dayIndex < completedDays(week);

  bool isWeekDone(int week) => completedDays(week) >= programDays;

  /// 0..1 for the progress ring.
  double progress(int week) => _changed.contains(week)
      ? completedDays(week) / programDays
      : MockWeeks.byNumber(week).initialProgress;

  /// Marks [dayIndex] done. Days are completed in order.
  void completeDay(int week, int dayIndex) {
    if (dayIndex >= completedDays(week)) {
      _completed[week] = (dayIndex + 1).clamp(0, programDays);
      _changed.add(week);
    }
  }
}
