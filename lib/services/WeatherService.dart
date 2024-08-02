/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app_tutorial/models/WeatherModel.dart';

class WeatherService {
  static const _apiKey = '90d66c835b65d23903506ad58d02b30f';
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5';

  static Future<WeatherModel> getWeather(String cityName) async {
    final currentWeatherResponse = await http.get(Uri.parse('$_baseUrl/weather?q=$cityName&appid=$_apiKey&units=metric'));
    final forecastResponse = await http.get(Uri.parse('$_baseUrl/forecast?q=$cityName&appid=$_apiKey&units=metric'));

    if (currentWeatherResponse.statusCode == 200 && forecastResponse.statusCode == 200) {
      final currentWeatherJson = json.decode(currentWeatherResponse.body);
      final forecastJson = json.decode(forecastResponse.body);
      final weather = WeatherModel.fromJson({
        ...currentWeatherJson,
        'forecast': forecastJson,
      });
      return weather;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
*/



import 'package:weather/weather.dart';
import '../consts.dart';
import '../models/WeatherModel.dart';

class WeatherService {
  final WeatherFactory _weatherFactory = WeatherFactory('90d66c835b65d23903506ad58d02b30f');

  Future<WeatherModel> getWeatherByCity(String city) async {
    final weather = await _weatherFactory.currentWeatherByCityName(city);
    return WeatherModel.fromWeather(weather);
  }
}

