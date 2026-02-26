import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../widgets/gradient_button.dart';

class LoginView extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Fix: Use Tween<double>(begin: 0, end: 1) and clamp opacity
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutBack,
                builder: (context, double value, child) {
                  return Opacity(
                    // Fix: Clamp opacity value between 0 and 1
                    opacity: value.clamp(0.0, 1.0),
                    child: Transform.scale(
                      scale: value.clamp(0.0, 1.0),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      width: 120.w,
                      height: 120.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor.withOpacity(0.7),
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.health_and_safety,
                        size: 60.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Daily Health Tracker',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Track your activities and stay healthy',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 60.h),
              // Fix: Wrap button in Expanded to prevent overflow
              Expanded(
                child: Container(), // Spacer
              ),
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOut,
                builder: (context, double value, child) {
                  return Opacity(
                    // Fix: Clamp opacity value
                    opacity: value.clamp(0.0, 1.0),
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - value.clamp(0.0, 1.0))),
                      child: child,
                    ),
                  );
                },
                child: Obx(() => GradientButton(
                  text: 'Sign in with Google',
                  onPressed: controller.signInWithGoogle,
                  isLoading: controller.isLoading.value,
                  icon: Icons.login,
                )),
              ),
              SizedBox(height: 20.h),
              Text(
                'By continuing, you agree to our Terms and Privacy Policy',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}