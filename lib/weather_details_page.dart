import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/WeatherModel.dart';
import '../models/ForecastModel.dart';
import '../services/WeatherService.dart';

class WeatherDetailsPage extends StatefulWidget {
  final WeatherModel weather;

  const WeatherDetailsPage({super.key, required this.weather});

  @override
  _WeatherDetailsPageState createState() => _WeatherDetailsPageState();
}

class _WeatherDetailsPageState extends State<WeatherDetailsPage> {
  final WeatherService _weatherService = WeatherService();
  List<ForecastModel> _forecast = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchForecast();
  }

  void _fetchForecast() async {
    try {
      final forecast = await _weatherService.get5DayForecastByCity(widget.weather.city);
      final uniqueDaysForecast = _getUniqueDaysForecast(forecast);
      setState(() {
        _forecast = uniqueDaysForecast;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching forecast: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<ForecastModel> _getUniqueDaysForecast(List<ForecastModel> forecast) {
    String todayDateKey = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Map<String, ForecastModel> uniqueDays = {};
    for (var item in forecast) {
      String dateKey = DateFormat('yyyy-MM-dd').format(item.date);
      if (dateKey != todayDateKey && !uniqueDays.containsKey(dateKey)) {
        uniqueDays[dateKey] = item;
      }
    }
    return uniqueDays.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.weather.city} Weather'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _weatherIcon(),
            const SizedBox(height: 20),
            _currentTemp(),
            const SizedBox(height: 20),
            _extraInfo(),
            const SizedBox(height: 20),
            _forecastInfo(),
          ],
        ),
      ),
    );
  }

  Widget _weatherIcon() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "http://openweathermap.org/img/wn/${widget.weather.weatherIcon}@4x.png"),
            ),
          ),
        ),
        Text(
          widget.weather.weatherDescription,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp() {
    return Text(
      "${widget.weather.temperature.toStringAsFixed(0)}° C",
      style: const TextStyle(
        color: Colors.black,
        fontSize: 60,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _extraInfo() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Max: ${widget.weather.tempMax.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Min: ${widget.weather.tempMin.toStringAsFixed(0)}° C",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Wind: ${widget.weather.windSpeed.toStringAsFixed(0)} m/s",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                "Humidity: ${widget.weather.humidity.toStringAsFixed(0)}%",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _forecastInfo() {
    return Column(
      children: [
        const Text(
          '5-Day Forecast',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _forecast.length,
          itemBuilder: (context, index) {
            final dayForecast = _forecast[index];
            return Card(
              child: ListTile(
                title: Text(DateFormat('EEE, MMM d').format(dayForecast.date)),
                subtitle: Text(dayForecast.weatherDescription),
                trailing: Text(
                  "${dayForecast.temperature.toStringAsFixed(0)}° C",
                ),
                leading: Image.network(
                  "http://openweathermap.org/img/wn/${dayForecast.weatherIcon}.png",
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
