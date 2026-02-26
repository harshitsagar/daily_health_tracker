// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../models/activity_model.dart';
import '../utils/constants.dart';

class ApiService extends GetxService {
  final _client = http.Client();

  Future<List<ActivityModel>> fetchActivities({int page = 1, int limit = 10}) async {
    try {
      print('Fetching activities: page $page, limit $limit');

      final response = await _client.get(
        Uri.parse('${AppConstants.baseUrl}${AppConstants.postsEndpoint}?_page=$page&_limit=$limit'),
      ).timeout(const Duration(seconds: 10));

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print('Received ${jsonData.length} activities');
        return ActivityModel.fromJsonList(jsonData);
      } else {
        throw Exception('Failed to load activities: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchActivities: $e');
      throw Exception('Network error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserSteps(int userId) async {
    // Mock implementation - in real app, this would call your backend
    await Future.delayed(const Duration(seconds: 1));
    return {
      'steps': [4500, 7800, 6200, 9100, 5400, 8300, 7200],
      'dates': ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    };
  }

  @override
  void onClose() {
    _client.close();
    super.onClose();
  }
}