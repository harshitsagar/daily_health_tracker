import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import '../controllers/auth_controller.dart';
import '../controllers/dashboard_controller.dart';
import '../controllers/activity_controller.dart';
import '../controllers/graph_controller.dart';
import '../controllers/timer_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Services
    Get.put(AuthService(), permanent: true);
    Get.put(ApiService(), permanent: true);
    Get.put(NotificationService(), permanent: true);

    // Controllers
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => ActivityController());
    Get.lazyPut(() => GraphController());
    Get.lazyPut(() => TimerController());
  }
}