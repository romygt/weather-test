import 'package:flutter/material.dart';
import '../models/WeatherModel.dart';
import '../services/WeatherService.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    try {
      _weather = await _weatherService.getWeatherByCity(city);
      _errorMessage = null;
    } catch (e) {
      _weather = null;
      _errorMessage = 'Could not fetch weather data';
    }
    notifyListeners();
  }
}
