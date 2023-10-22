import 'dart:math';

import 'package:crypto/crypto.dart';
import 'dart:convert';

class Utilities {
  static String url = 'https://URL_API/api/';

  static String convertSHA256(String value) {
    return sha256.convert(utf8.encode(value)).toString();
  }

  // static Future<String> deviceInfo() async {
  //   if (Platform.isAndroid) {
  //     var androidInfo = await DeviceInfoPlugin().androidInfo;
  //     var release = androidInfo.version.release;
  //     var sdkInt = androidInfo.version.sdkInt;
  //     var manufacturer = androidInfo.manufacturer;
  //     var model = androidInfo.model;
  //
  //     return 'Android $release (SDK $sdkInt), $manufacturer $model';
  //   }
  //
  //   if (Platform.isIOS) {
  //     var iosInfo = await DeviceInfoPlugin().iosInfo;
  //     var systemName = iosInfo.systemName;
  //     var version = iosInfo.systemVersion;
  //     var name = iosInfo.name;
  //     var model = iosInfo.model;
  //
  //     return '$systemName $version, $name $model';
  //   }
  //
  //   return Platform().toString();
  // }

  static String appName = 'DETRAN DESPACHANTE';

  // static Future<void> getAppName() async {
  //   PackageInfo info = await PackageInfo.fromPlatform();
  //
  //   if (info.appName.isNotEmpty)
  //     appName = info.appName;
  // }

  static String generateRandomString(int len) {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }
}