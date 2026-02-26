import 'package:get/get.dart';
import '../models/step_data_model.dart';

class GraphController extends GetxController {
  RxList<StepData> weeklySteps = <StepData>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadStepData();
  }

  Future<void> loadStepData() async {
    isLoading.value = true;

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    weeklySteps.value = StepData.getMockData();
    isLoading.value = false;
  }

  double get maxStep => weeklySteps.map((e) => e.steps.toDouble()).reduce((a, b) => a > b ? a : b);

  double get averageSteps {
    if (weeklySteps.isEmpty) return 0;
    final total = weeklySteps.fold(0, (sum, item) => sum + item.steps);
    return total / weeklySteps.length;
  }
}