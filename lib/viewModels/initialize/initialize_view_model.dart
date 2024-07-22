import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InitializeViewModel extends ChangeNotifier {
  String? version = "loading";
  final storage = const FlutterSecureStorage();

  init() async {
    version = await initPackageInfo();

    notifyListeners();
  }

  /// 讀取版本號
  Future<String> initPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// 取得key的值
  Future<String?> getStorageValue(String key) async {
    return await storage.read(key: key);
  }

  /// 設置給定 [key] 的存儲值為指定的 [value]。
  ///
  /// 該方法使用 [storage] 對象將 [value] 寫入存儲。
  /// 它返回一個 [Future]，在值成功寫入後完成。
  Future<void> setStorageValue(
      {required String key, required String value}) async {
    await storage.write(key: key, value: value);
    return;
  }

  /// --------------------讀取目前語系--------------------
  Locale getLocale() {
    switch (PlatformDispatcher.instance.locale.countryCode.toString()) {
      case "CN":
        return const Locale('zh', 'CN');
      case "US":
        return const Locale('en', 'US');

      case "ID":
        return const Locale('id');

      default:
        return const Locale('zh', 'TW');
    }
  }

  // 在應用程式的入口處或合適的地方檢查並要求通知權限
}
