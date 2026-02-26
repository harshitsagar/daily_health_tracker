// lib/views/profile_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../widgets/gradient_button.dart';

class ProfileView extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final DashboardController dashboardController = Get.find<DashboardController>();

  ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Obx(() => SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Profile Header
            Card(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: dashboardController.user.value.photoURL != null
                          ? NetworkImage(dashboardController.user.value.photoURL!)
                          : null,
                      child: dashboardController.user.value.photoURL == null
                          ? Text(
                        dashboardController.user.value.displayName?[0] ?? 'U',
                        style: TextStyle(fontSize: 32.sp),
                      )
                          : null,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      dashboardController.user.value.displayName ?? 'User',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      dashboardController.user.value.email ?? 'No email',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Stats Summary
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    _buildProfileStat(
                      'Total Steps',
                      '54,780',
                      Icons.directions_walk,
                      Colors.blue,
                    ),
                    Divider(height: 20.h),
                    _buildProfileStat(
                      'Total Calories',
                      '2,450',
                      Icons.local_fire_department,
                      Colors.orange,
                    ),
                    Divider(height: 20.h),
                    _buildProfileStat(
                      'Active Minutes',
                      '325',
                      Icons.timer,
                      Colors.green,
                    ),
                    Divider(height: 20.h),
                    _buildProfileStat(
                      'Workouts',
                      '28',
                      Icons.fitness_center,
                      Colors.purple,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // Settings Options
            Card(
              child: Column(
                children: [
                  _buildSettingTile(
                    'Dark Mode',
                    Icons.dark_mode,
                    Switch(
                      value: Get.isDarkMode,
                      onChanged: (value) {
                        Get.changeThemeMode(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ),
                  _buildSettingTile(
                    'Notifications',
                    Icons.notifications,
                    Switch(value: true, onChanged: (value) {}),
                  ),
                  _buildSettingTile(
                    'Language',
                    Icons.language,
                    Text('English'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // Logout Button
            GradientButton(
              text: 'Logout',
              onPressed: authController.signOut,
              icon: Icons.logout,
            ),
          ],
        ),
      )),
    );
  }

  Widget _buildProfileStat(String label, String value, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, color: color, size: 20.sp),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(String title, IconData icon, Widget trailing) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing,
    );
  }
}