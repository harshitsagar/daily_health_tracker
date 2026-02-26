class StepData {
  final String day;
  final int steps;
  final double value;

  StepData({
    required this.day,
    required this.steps,
    required this.value,
  });

  static List<StepData> getMockData() {
    return [
      StepData(day: 'Mon', steps: 4500, value: 4500),
      StepData(day: 'Tue', steps: 7800, value: 7800),
      StepData(day: 'Wed', steps: 6200, value: 6200),
      StepData(day: 'Thu', steps: 9100, value: 9100),
      StepData(day: 'Fri', steps: 5400, value: 5400),
      StepData(day: 'Sat', steps: 8300, value: 8300),
      StepData(day: 'Sun', steps: 7200, value: 7200),
    ];
  }
}