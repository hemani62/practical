import 'package:flutter/material.dart';
import 'HomeScreen.dart';

class DetailsScreen extends StatelessWidget {
  final String locationName;
  final int locationId;
  final WeatherData weatherData;

  DetailsScreen({
    required this.locationName,
    required this.locationId,
    required this.weatherData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Weather Information:',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            Text('Location Name: $locationName',
                style: const TextStyle(fontSize: 20)),
            Text('Location ID: $locationId',
                style: const TextStyle(fontSize: 20)),
            Text('Timezone: ${weatherData.timezone}',
                style: const TextStyle(fontSize: 20)),
            Text('Temperature: ${weatherData.temperature}°C',
                style: const TextStyle(fontSize: 20)),
            Text('Description: ${weatherData.description}',
                style: const TextStyle(fontSize: 20)),
            Text('Wind Speed: ${weatherData.windSpeed} m/s',
                style: const TextStyle(fontSize: 20)),
            Text('Humidity: ${weatherData.humidity}%',
                style: const TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
