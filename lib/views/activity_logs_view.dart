// lib/views/activity_logs_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/activity_controller.dart';
import '../widgets/activity_card.dart';

class ActivityLogsView extends StatelessWidget {
  final ActivityController controller = Get.find<ActivityController>();

  ActivityLogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity Logs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshActivities,
          ),
        ],
      ),
      body: Obx(() {
        // Show error if any
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64.sp,
                  color: Colors.red,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Failed to load activities',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Please check your internet connection',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 24.h),
                ElevatedButton(
                  onPressed: controller.refreshActivities,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        // Show loading indicator while initial load
        if (controller.isLoading.value && controller.activities.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Show empty state if no activities
        if (controller.activities.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.list_alt,
                  size: 64.sp,
                  color: Colors.grey[400],
                ),
                SizedBox(height: 16.h),
                Text(
                  'No activities found',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Pull down to refresh',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          );
        }

        // Show activity list with pull to refresh
        return RefreshIndicator(
          onRefresh: controller.refreshActivities,
          child: ListView.builder(
            padding: EdgeInsets.all(16.w),
            itemCount: controller.activities.length + (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              // Show loading indicator at the bottom
              if (index == controller.activities.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Center(
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : Text(
                      controller.hasMore.value
                          ? 'Loading more...'
                          : 'No more activities',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                );
              }

              return ActivityCard(
                activity: controller.activities[index],
                index: index,
              );
            },
          ),
        );
      }),
    );
  }
}