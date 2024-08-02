/* import 'package:flutter/material.dart';
import 'package:weather_app_tutorial/models/WeatherModel.dart';
import 'package:weather_app_tutorial/services/WeatherService.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;
  bool _isLoading = false;
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String cityName) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final weather = await WeatherService.getWeather(cityName);
      _weather = weather;
    } catch (error) {
      _errorMessage = 'Could not fetch weather data';
    }

    _isLoading = false;
    notifyListeners();
  }
}
*/

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
