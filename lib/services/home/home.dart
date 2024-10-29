import '../../models/home/home.dart';

import '../../api/api.dart';

class HomeService {
  final CallApi api;

  HomeService() : api = CallApi(); // 直接初始化

  Future<HourlyWeather> hourlyWeather(
      {required Map<String, dynamic> queryParams,
      required Map<String, String> header}) async {
    final res = await api.handleApiCall(
      () => api.get("/v1/forecast", queryParams, header),
      onError: () => print("取得失敗"),
    );

    // 假設 res.hourly 是一個 Map<String, dynamic>
    final hourlyWeather =
        HourlyWeather.fromJson(res.hourly as Map<String, dynamic>);

    return hourlyWeather;
  }
}
