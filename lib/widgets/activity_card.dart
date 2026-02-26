// lib/widgets/activity_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/activity_model.dart';

class ActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final int index;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 500 + (index * 100)),
      curve: Curves.easeOut,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 12.h),
        child: InkWell(
          onTap: () {
            // Scale animation on tap
            Get.dialog(
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: context.theme.cardColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          activity.title,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(activity.body),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: _getActivityColor(activity.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    _getActivityIcon(activity.type),
                    color: _getActivityColor(activity.type),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        DateFormat('MMM dd, yyyy • hh:mm a').format(activity.date),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${activity.duration} min',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: _getActivityColor(activity.type),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${activity.calories} cal',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getActivityIcon(String type) {
    switch (type) {
      case 'Walking':
        return Icons.directions_walk;
      case 'Running':
        return Icons.directions_run;
      case 'Cycling':
        return Icons.directions_bike;
      case 'Yoga':
        return Icons.self_improvement;
      default:
        return Icons.fitness_center;
    }
  }

  Color _getActivityColor(String type) {
    switch (type) {
      case 'Walking':
        return Colors.blue;
      case 'Running':
        return Colors.green;
      case 'Cycling':
        return Colors.orange;
      case 'Yoga':
        return Colors.purple;
      default:
        return Colors.red;
    }
  }
}