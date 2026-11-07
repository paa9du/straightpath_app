class WeekProgress {
  const WeekProgress({
    required this.week,
    required this.title,
    required this.description,
    required this.dateRange,
    required this.progress,
    required this.completedDays,
  });

  final int week;
  final String title;
  final String description;
  final String dateRange;
  final double progress;
  final int completedDays;
}
