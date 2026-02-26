// lib/utils/constants.dart
class AppConstants {
  // Use JSONPlaceholder API - it's reliable and free
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // API Endpoints
  static const String postsEndpoint = '/posts';
  static const String usersEndpoint = '/users';

  // Mock data for steps
  static const List<int> mockSteps = [4500, 7800, 6200, 9100, 5400, 8300, 7200];

  // Notification channels
  static const String healthChannelId = 'health_reminders';
  static const String healthChannelName = 'Health Reminders';
  static const String healthChannelDescription = 'Notifications for health activities';
}