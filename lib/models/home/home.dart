import 'package:json_annotation/json_annotation.dart';
part 'home.g.dart'; // 自动生成的文件名，根据你的类名而定

@JsonSerializable()
class HourlyWeather {
  final List<String>? time;
  final List<double>? temperature_2m;

  HourlyWeather({this.time, this.temperature_2m});

  factory HourlyWeather.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherToJson(this);
}
