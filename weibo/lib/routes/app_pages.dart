import 'package:get/route_manager.dart';
import 'package:weibo/pages/home/home_binding.dart';
import 'package:weibo/pages/home/home_page.dart';

abstract class AppPages {
  static final pages = [
    //主页
    GetPage(name: Routes.HOME, page: () => HomePage(), binding: HomeBinding()),
  ];
}

abstract class Routes {
  static const INITIAL = '/';

  static const HOME = '/home';
}
