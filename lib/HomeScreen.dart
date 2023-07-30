import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class WeatherData {
  final double temperature;
  final String description;
  final double windSpeed;
  final int humidity;
  final int timezone;

  WeatherData({
    required this.temperature,
    required this.description,
    required this.windSpeed,
    required this.humidity,
    required this.timezone,
  });
}


class _HomeScreenState extends State<HomeScreen> {
  TextEditingController locationController = TextEditingController();
  String weatherData = '';

  void _showWeatherDetails(WeatherData weatherData, String locationName, int locationId,) {
    final String details = '''
    Location Name: $locationName
    Location ID: $locationId
    Timezone: ${weatherData.timezone}
    Temperature: ${weatherData.temperature}°C
    Description: ${weatherData.description}
    Wind Speed: ${weatherData.windSpeed} m/s
    Humidity: ${weatherData.humidity}%
  ''';

    setState(() {
      this.weatherData = details;

    });
  }

  void _fetchWeatherData() async {
    final apiKey = '8446e4f007bb32917a4ec1060b687b0b'; // Replace with your OpenWeatherMap API key
    final location = locationController.text;
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final weatherJson = json.decode(response.body);

        if (weatherJson != null) {
          final temperature = weatherJson['main']['temp'];
          final description = weatherJson['weather'][0]['description'];
          final windSpeed = weatherJson['wind']['speed'];
          final humidity = weatherJson['main']['humidity'];
          final timezone = weatherJson['timezone'];
          final locationName = weatherJson['name'];
          final locationId = weatherJson['id'];

          final weatherData = WeatherData(
            temperature: temperature,
            description: description,
            windSpeed: windSpeed,
            humidity: humidity,
            timezone: timezone,
          );

          _showWeatherDetails(weatherData, locationName, locationId);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(
                locationName: locationName,
                locationId: locationId,
                weatherData: weatherData,
              ),
            ),
          );
        } else {
          setState(() {
            weatherData = 'Weather data not available.';
          });
        }
      } else {
        setState(() {
          weatherData = 'Error fetching weather data.';
        });
      }
    } catch (e) {
      setState(() {
        weatherData = 'Error fetching weather data.';
      });
    }
  }

  // void _fetchWeatherData() async {
  //   const apiKey =
  //       '8446e4f007bb32917a4ec1060b687b0b'; // Replace with your OpenWeatherMap API key
  //   final location = locationController.text;
  //   final url =
  //       'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$apiKey&units=metric';
  //
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //
  //     print('Response Status Code: ${response.statusCode}');
  //     print('Response Body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final weatherJson = json.decode(response.body);
  //
  //       if (weatherJson != null &&
  //           weatherJson['main'] != null &&
  //           weatherJson['weather'] != null) {
  //         final temperature = weatherJson['main']['temp'];
  //         final description = weatherJson['weather'][0]['description'];
  //         final windSpeed = weatherJson['wind']['speed'];
  //         final humidity = weatherJson['main']['humidity'];
  //
  //         setState(() {
  //           weatherData =
  //               'Temperature: $temperature°C\nDescription: $description\nHumidity: $humidity\nWindSpeed: $windSpeed';
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => DetailsScreen(
  //                 weatherData: weatherData,
  //               ),
  //             ),
  //           );
  //         });
  //       } else {
  //         setState(() {
  //           weatherData = 'Weather data not available.';
  //         });
  //       }
  //     } else {
  //       setState(() {
  //         weatherData = 'Error fetching weather data.';
  //       });
  //     }
  //   } catch (e) {
  //     setState(() {
  //       weatherData = 'Error fetching weather data.';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Enter Location'),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _fetchWeatherData();
              },
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
