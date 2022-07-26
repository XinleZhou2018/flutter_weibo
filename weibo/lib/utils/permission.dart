import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  static Future<bool?> requestPhotosPermission() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();

      return (statuses[Permission.storage] == PermissionStatus.granted);
    } else if (Platform.isIOS) {
      //查看README podfile里有一些特殊的设置
      PermissionStatus status= await Permission.photos.request();

      return status == PermissionStatus.granted;
    }
  }
}
