import 'package:weather/weather.dart';

class WeatherModel {
  final String city;
  final double temperature;
  final double tempMax;
  final double tempMin;
  final double windSpeed;
  final double humidity; // Changed to double
  final String weatherDescription;
  final String weatherIcon;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.tempMax,
    required this.tempMin,
    required this.windSpeed,
    required this.humidity,
    required this.weatherDescription,
    required this.weatherIcon,
  });

  factory WeatherModel.fromWeather(Weather weather) {
    return WeatherModel(
      city: weather.areaName ?? 'Unknown',
      temperature: weather.temperature?.celsius ?? 0.0,
      tempMax: weather.tempMax?.celsius ?? 0.0,
      tempMin: weather.tempMin?.celsius ?? 0.0,
      windSpeed: weather.windSpeed ?? 0.0,
      humidity: weather.humidity?.toDouble() ?? 0.0, // Convert to double
      weatherDescription: weather.weatherDescription ?? 'No description',
      weatherIcon: weather.weatherIcon ?? '01d', // Default icon if not available
    );
  }
}
