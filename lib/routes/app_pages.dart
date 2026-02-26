import 'package:get/get.dart';
import '../views/login_view.dart';
import '../views/dashboard_view.dart';
import '../views/graph_view.dart';
import '../views/activity_logs_view.dart';
import '../views/profile_view.dart';
import '../controllers/graph_controller.dart';
import '../controllers/activity_controller.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.DASHBOARD,
      page: () => DashboardView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.GRAPH,
      page: () => GraphView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<GraphController>(() => GraphController());
      }),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.ACTIVITY_LOGS,
      page: () => ActivityLogsView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<ActivityController>(() => ActivityController());
      }),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.PROFILE,
      page: () => ProfileView(),
      transition: Transition.fadeIn,
    ),
  ];
}