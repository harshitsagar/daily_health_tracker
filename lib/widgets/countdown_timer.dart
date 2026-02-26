import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/timer_controller.dart';

class CountdownTimerWidget extends StatelessWidget {
  final TimerController controller = Get.find<TimerController>();

  CountdownTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Next Activity Reminder',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Obx(() => Text(
                    controller.isRunning.value
                        ? (controller.isPaused.value ? 'Paused' : 'Active')
                        : 'Stopped',
                    style: TextStyle(
                      color: controller.isRunning.value
                          ? (controller.isPaused.value ? Colors.orange : Colors.green)
                          : Colors.red,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Obx(() => Text(
              controller.formattedTime,
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
              ),
            )),
            SizedBox(height: 10.h),
            Text(
              'Time until your next scheduled activity',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(() => _buildControlButton(
                  icon: controller.isPaused.value ? Icons.play_arrow : Icons.pause,
                  onPressed: controller.isPaused.value
                      ? controller.resumeTimer
                      : controller.pauseTimer,
                  color: controller.isPaused.value ? Colors.green : Colors.orange,
                )),
                SizedBox(width: 16.w),
                _buildControlButton(
                  icon: Icons.refresh,
                  onPressed: controller.resetTimer,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(12.w),
        child: Icon(
          icon,
          color: color,
          size: 24.sp,
        ),
      ),
    );
  }
}