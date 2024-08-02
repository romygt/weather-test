/*import 'package:flutter/material.dart';
import 'package:weather_app_tutorial/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app_tutorial/models/WeatherModel.dart';
import 'package:weather_app_tutorial/providers/WeatherProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}

class WeatherScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherProvider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Weather App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city name',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    weatherProvider.fetchWeather(_controller.text);
                  },
                ),
              ),
            ),
            if (weatherProvider.isLoading)
              CircularProgressIndicator()
            else if (weatherProvider.weather != null)
              WeatherDisplay(weather: weatherProvider.weather!)
            else if (weatherProvider.errorMessage != null)
                Text(
                  weatherProvider.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
          ],
        ),
      ),
    );
  }
}


class WeatherDisplay extends StatelessWidget {
  final WeatherModel weather;

  WeatherDisplay({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Current Weather in ${weather.cityName}',
          style: TextStyle(fontSize: 24),
        ),
        Text('Temperature: ${weather.currentTemp}°C'),
        Text('Humidity: ${weather.humidity}%'),
        Text('Condition: ${weather.description}'),
        SizedBox(height: 20),
        Text(
          '5-Day Forecast',
          style: TextStyle(fontSize: 24),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: weather.forecast.length,
            itemBuilder: (context, index) {
              final dayWeather = weather.forecast[index];
              return ListTile(
                title: Text(dayWeather.date),
                subtitle: Text('${dayWeather.minTemp}°C - ${dayWeather.maxTemp}°C, ${dayWeather.description}'),
              );
            },
          ),
        ),
      ],
    );
  }
}
 */


 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/WeatherProvider.dart';
import 'home_page.dart'; // Ensure you import your HomePage

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
