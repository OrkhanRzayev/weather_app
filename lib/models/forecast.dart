import 'package:weather_app/models/daily.dart';
import 'package:weather_app/models/hourly.dart';

class Forecast {
  final List<Daily> daily;
  final List<Hourly> hourly;

  Forecast({required this.daily, required this.hourly});

  factory Forecast.fromJson(Map<String, dynamic> json) {
    List<dynamic> dailyData = json['daily'];
    List<dynamic> hourlyData = json['hourly'];

    List<Daily> daily = <Daily>[];
    List<Hourly> hourly = <Hourly>[];

    for (var item in dailyData) {
      var day = Daily.fromJson(item);
      daily.add(day);
    }

    for (var item in hourlyData) {
      var hour = Hourly.fromJson(item);
      hourly.add(hour);
    }

    return Forecast(daily: daily, hourly: hourly);
  }
}
