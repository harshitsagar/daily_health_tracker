import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

class DashboardController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  Rx<UserModel> user = Rx<UserModel>(UserModel(
      uid: '',
      lastSignIn: DateTime.now()
  ));
  RxInt dailySteps = 0.obs;
  RxInt dailyCalories = 0.obs;
  RxInt activeMinutes = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (_authService.firebaseUser.value != null) {
      user.value = UserModel.fromFirebase(_authService.firebaseUser.value!);
    }
    fetchDailyStats();
  }

  void fetchDailyStats() {
    // Mock data - replace with actual API calls
    dailySteps.value = 7842;
    dailyCalories.value = 320;
    activeMinutes.value = 45;
  }

  double get stepProgress => dailySteps.value / 10000; // Goal: 10000 steps
}