import 'package:flutter/material.dart';
import 'package:flutter_mvvm_demo/services/home/home.dart';

import '../../models/home/home.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService homeService = HomeService();
  HourlyWeather hourlyWeather = HourlyWeather();
  Future<HourlyWeather?>? weatherFuture;

  Future<void> callGetWeather({
    required Map<String, String> queryParams,
    required Map<String, String> header,
  }) async {
    // 使用者輸入的廠別不在程式定義的class裡面
    weatherFuture = homeService
        .hourlyWeather(queryParams: queryParams, header: header)
        .then((data) {
      hourlyWeather = data;
      notifyListeners();
    }).catchError((e) => throw e);
  }
}
