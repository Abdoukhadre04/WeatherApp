import 'package:flutter/material.dart';
import 'package:weather_mockon/pages/weather_page.dart';
import 'package:weather_mockon/services/weather_cache.dart';

void main() async {
  //? initialiser le weather cach | offline

  WidgetsFlutterBinding.ensureInitialized();
  await WeatherCache.init();
  runApp(const MyWeatherApp());
}

class MyWeatherApp extends StatelessWidget {
  const MyWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: WeatherPage(),
    );
  }
}
