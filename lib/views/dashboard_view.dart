import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/timer_controller.dart';
import '../services/notification_service.dart';
import '../widgets/countdown_timer.dart';
import '../widgets/gradient_button.dart';
import '../routes/app_routes.dart';

class DashboardView extends StatelessWidget {
  // Get controllers
  final DashboardController controller = Get.find<DashboardController>();
  final AuthController authController = Get.find<AuthController>(); // Add this line
  final NotificationService _notificationService = Get.find<NotificationService>();

  DashboardView({super.key}) {
    _notificationService.scheduleHealthReminder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.signOut(), // Use authController here
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card with Fade Animation
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeOut,
              builder: (context, double value, child) {
                return Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - value.clamp(0.0, 1.0))),
                    child: child,
                  ),
                );
              },
              child: Obx(() => Card(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: controller.user.value.photoURL != null
                            ? NetworkImage(controller.user.value.photoURL!)
                            : null,
                        child: controller.user.value.photoURL == null
                            ? Text(controller.user.value.displayName?[0] ?? 'U')
                            : null,
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.user.value.displayName ?? 'User',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              controller.user.value.email ?? 'No email',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
            SizedBox(height: 20.h),

            // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Steps',
                    controller.dailySteps.value.toString(),
                    Icons.directions_walk,
                    Colors.blue,
                    controller.stepProgress,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildStatCard(
                    'Calories',
                    controller.dailyCalories.value.toString(),
                    Icons.local_fire_department,
                    Colors.orange,
                    controller.dailyCalories.value / 500,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildStatCard(
                    'Active Min',
                    controller.activeMinutes.value.toString(),
                    Icons.timer,
                    Colors.green,
                    controller.activeMinutes.value / 60,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Countdown Timer
            CountdownTimerWidget(),
            SizedBox(height: 20.h),

            // Quick Actions
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    'Activity Logs',
                    Icons.list,
                        () => Get.toNamed(AppRoutes.ACTIVITY_LOGS),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildActionButton(
                    'Statistics',
                    Icons.bar_chart,
                        () => Get.toNamed(AppRoutes.GRAPH),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            // Test Notification Button (Bonus)
            GradientButton(
              text: 'Send Test Notification',
              onPressed: () => _notificationService.showImmediateNotification(
                'Health Reminder',
                'Time to take a walk! 🚶',
              ),
              icon: Icons.notifications,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, double progress) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeOutCubic,
      builder: (context, double animationValue, child) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              children: [
                Icon(icon, color: color, size: 24.sp),
                SizedBox(height: 8.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: animationValue.clamp(0.0, 1.0),
                  backgroundColor: color.withOpacity(0.1),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Icon(icon, size: 28.sp),
                SizedBox(height: 8.h),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}