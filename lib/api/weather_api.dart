import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_mockon/constants/app_constants.dart';
import 'package:weather_mockon/pages/weather_model.dart';
import 'package:weather_mockon/services/weather_cache.dart';

class WeatherApi {
  final String baseUrl = "http://api.weatherapi.com/v1/forecast.json";

  Future<ApiResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";

    //? verifer le cache
    final cachedData = await WeatherCache.getWeatherData(location);

    if (cachedData != null) {
      return ApiResponse.fromJson(cachedData);
    }
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // sauvegarder dans le cahce
        await WeatherCache.saveWeatherData(location, jsonData);
        return ApiResponse.fromJson(jsonDecode(jsonData));
      } else if (cachedData != null) {
        return ApiResponse.fromJson(cachedData);
      } else {
        throw Exception("Échec du chargement de la météo");
      }
    } catch (e) {
      if (cachedData != null) {
        return ApiResponse.fromJson(cachedData);
      }
      throw Exception("Une erreur est survenue... $e");
    }
  }
}
