class ActivityModel {
  final int id;
  final String title;
  final String body;
  final DateTime date;
  final String type;
  final int duration; // in minutes
  final int calories;

  ActivityModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
    required this.type,
    required this.duration,
    required this.calories,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] as int,
      title: json['title'] ?? 'Activity',
      body: json['body'] ?? '',
      date: DateTime.now().subtract(Duration(days: (json['id'] as int) % 7)),
      type: ['Walking', 'Running', 'Cycling', 'Yoga'][(json['id'] as int) % 4],
      duration: 30 + ((json['id'] as int) % 30),
      calories: 100 + ((json['id'] as int) % 200),
    );
  }

  static List<ActivityModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ActivityModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}