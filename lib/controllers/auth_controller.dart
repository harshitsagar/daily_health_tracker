import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  RxBool isLoading = false.obs;
  Rx<User?> currentUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    // Listen to auth state changes
    ever(_authService.firebaseUser, (User? user) {
      currentUser.value = user;
      if (user != null) {
        // User is signed in
        print('AuthController: User signed in - ${user.displayName}');
      }
    });
  }

  Future<void> signInWithGoogle() async {
    isLoading.value = true;

    final user = await _authService.signInWithGoogle();

    if (user != null) {
      // Navigate to dashboard
      Get.offAllNamed(AppRoutes.DASHBOARD);
    }

    isLoading.value = false;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    Get.offAllNamed(AppRoutes.LOGIN);
  }

  bool get isLoggedIn => _authService.firebaseUser.value != null;
}