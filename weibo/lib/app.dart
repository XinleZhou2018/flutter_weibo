import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:weibo/routes/app_pages.dart';

Widget createApp() {
  return OKToast(
      dismissOtherOnShow: true, //全局设置隐藏之前的属性,这里设置后,每次当你显示新的 toast 时,旧的就会被关闭
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // enableLog: false,
        // translations: Language(),
        // locale: getCurrentLocale(),
        // fallbackLocale: Locale('en', 'US'),
        // builder: EasyLoading.init(),
        // theme: ThemeData(
        //     primaryColor: Colors.white,
        //     fontFamily: getFontFamilyByLanguage(),
        //     // textButtonTheme: TextButtonThemeData(
        //     //     style: ButtonStyle(textStyle: MaterialStateProperty.all(
        //     //         //定义文本的样式 这里设置的颜色是不起作用的
        //     //         TextStyle(fontFamily: _getFontFamilyByLanguage()))))
        //             ),
        initialRoute: Routes.HOME,
        getPages: AppPages.pages,
//     onGenerateRoute: (RouteSettings settings){
// return GetPageRoute(settings: settings);
//     },
      ));
}
