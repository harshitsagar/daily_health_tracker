import 'package:get/get.dart';

class TimerController extends GetxController {
  RxInt secondsRemaining = 600.obs; // 10 minutes = 600 seconds
  RxBool isRunning = false.obs;
  RxBool isPaused = false.obs;

  late Worker _timerWorker;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    isRunning.value = true;
    isPaused.value = false;

    _timerWorker = ever(secondsRemaining, (value) {
      if (value <= 0) {
        resetTimer();
      }
    });

    _startCountdown();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (isRunning.value && !isPaused.value && secondsRemaining.value > 0) {
        secondsRemaining.value--;
        _startCountdown();
      }
    });
  }

  void pauseTimer() {
    isPaused.value = true;
  }

  void resumeTimer() {
    isPaused.value = false;
    _startCountdown();
  }

  void resetTimer() {
    secondsRemaining.value = 600;
    if (!isRunning.value) {
      startTimer();
    }
  }

  String get formattedTime {
    final minutes = secondsRemaining.value ~/ 60;
    final seconds = secondsRemaining.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _timerWorker.dispose();
    super.onClose();
  }
}