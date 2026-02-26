import 'package:get/get.dart';
import '../models/activity_model.dart';
import '../services/api_service.dart';

class ActivityController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();

  RxList<ActivityModel> activities = <ActivityModel>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;
  RxString errorMessage = ''.obs;
  int currentPage = 1;
  final int limit = 10;

  @override
  void onInit() {
    super.onInit();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final newActivities = await _apiService.fetchActivities(
        page: currentPage,
        limit: limit,
      );

      if (newActivities.isNotEmpty) {
        activities.addAll(newActivities);
        currentPage++;
        if (newActivities.length < limit) {
          hasMore.value = false;
        }
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      errorMessage.value = 'Failed to load activities: ${e.toString()}';
      print('Error fetching activities: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshActivities() async {
    activities.clear();
    currentPage = 1;
    hasMore.value = true;
    errorMessage.value = '';
    await fetchActivities();
  }
}