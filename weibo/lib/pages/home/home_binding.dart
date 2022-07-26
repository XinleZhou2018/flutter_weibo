import 'package:get/get.dart';
import 'package:weibo/pages/home/home_controller.dart';
import 'package:weibo/utils/log_util.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    LogUtil.v("HomeBinding");

    Get.put<HomeController>(HomeController());
  }
}
