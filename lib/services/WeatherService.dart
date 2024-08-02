import 'package:weather/weather.dart';
import '../consts.dart';
import '../models/WeatherModel.dart';
import '../models/ForecastModel.dart';


class WeatherService {
  final WeatherFactory _weatherFactory = WeatherFactory(OPENWEATHER_API_KEY);

  Future<WeatherModel> getWeatherByCity(String city) async {
    final weather = await _weatherFactory.currentWeatherByCityName(city);
    return WeatherModel.fromWeather(weather);
  }
  Future<List<ForecastModel>> get5DayForecastByCity(String city) async {
    final forecast = await _weatherFactory.fiveDayForecastByCityName(city);
    return forecast.map((weather) => ForecastModel.fromWeather(weather)).toList();
  }
}
