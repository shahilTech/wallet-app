import 'package:get/get.dart';
import 'package:wallet_app/modules/01_Home/controllers/state_controllers.dart';
import 'package:wallet_app/modules/02_Reports/controllers/state_controllers.dart';
import 'package:wallet_app/modules/03_Settings/controllers/state_controllers.dart';

class HomeBinging extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}

class ReportsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ReportsController());
  }
}

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
