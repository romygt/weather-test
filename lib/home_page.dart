import 'package:flutter/material.dart';
import '../models/WeatherModel.dart';
import '../services/WeatherService.dart';
import 'weather_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  final TextEditingController _cityController = TextEditingController();
  bool _isLoading = false;

  void _searchWeather() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final city = _cityController.text.trim();
      if (city.isNotEmpty) {
        final weather = await _weatherService.getWeatherByCity(city);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherDetailsPage(weather: weather),
          ),
        );
      } else {
        _showErrorSnackbar("Please enter a city name.");
      }
    } catch (e) {
      _showErrorSnackbar('City not found');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'Enter city',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _searchWeather(),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: _searchWeather,
                  child: const Text('Search'),
                ),
              ],
            ),
            if (_isLoading) ...[
              const SizedBox(height: 20),
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
