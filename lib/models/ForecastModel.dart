import 'package:weather/weather.dart';

class ForecastModel {
  final DateTime date;
  late final double temperature;
  final String weatherDescription;
  final String weatherIcon;

  ForecastModel({
    required this.date,
    required this.temperature,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory ForecastModel.fromWeather(Weather weather) {
    return ForecastModel(
      date: weather.date!,
      temperature: weather.temperature!.celsius!,
      weatherDescription: weather.weatherDescription!,
      weatherIcon: weather.weatherIcon!,
    );
  }
}
