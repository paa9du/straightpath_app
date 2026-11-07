class PersonSummary {
  const PersonSummary({
    required this.name,
    required this.program,
    required this.imagePath,
    required this.completedSteps,
    this.statusDate = '5 Feb, 2025',
  });

  final String name;
  final String program;
  final String imagePath;
  final int completedSteps;
  final String statusDate;
}
