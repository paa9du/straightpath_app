/// Which step tracker a youth card shows.
enum TrackerKind {
  /// Check-In · Focus · Activity · Reflection.
  daily,

  /// Orientation & Trust Building · Group Agreements · Focus · My Goals ·
  /// Trust Meter.
  program,
}

class PersonSummary {
  const PersonSummary({
    required this.name,
    required this.program,
    required this.imagePath,
    required this.completedSteps,
    this.statusDate = '5 Feb, 2025',
    this.tracker = TrackerKind.daily,
    this.weeklyProgress,
  });

  final String name;
  final String program;
  final String imagePath;
  final int completedSteps;
  final String statusDate;
  final TrackerKind tracker;

  /// Weekly course progress in percent; null hides the line on the card.
  final int? weeklyProgress;
}
