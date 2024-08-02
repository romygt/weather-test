/*class WeatherModel {
  final String cityName;
  final double currentTemp;
  final int humidity;
  final String description;
  final List<DayWeather> forecast;

  WeatherModel({
    required this.cityName,
    required this.currentTemp,
    required this.humidity,
    required this.description,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      currentTemp: json['main']['temp'],
      humidity: json['main']['humidity'],
      description: json['weather'][0]['description'],
      forecast: (json['forecast']['list'] as List)
          .map((day) => DayWeather.fromJson(day))
          .toList(),
    );
  }
}


class DayWeather {
  final String date;
  final double minTemp;
  final double maxTemp;
  final String description;

  DayWeather({
    required this.date,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
  });

  factory DayWeather.fromJson(Map<String, dynamic> json) {
    return DayWeather(
      date: json['dt_txt'],
      minTemp: json['main']['temp_min'],
      maxTemp: json['main']['temp_max'],
      description: json['weather'][0]['description'],
    );
  }
}
*/

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
