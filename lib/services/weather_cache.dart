import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class WeatherCache {
  static const String _boxName = 'weatherCache';
  static const int _cacheDurationHours = 4;

  static Future<void> init() async {
    final appDir = await getApplicationDocumentsDirectory();
    Hive.init(appDir.path);
    await Hive.openBox(_boxName);
  }

  //? enregistrer les donnees weather
  static Future<void> saveWeatherData(String location, dynamic data) async {
    final box = Hive.box(_boxName);
    await box.put(location, {
      'data': data,
      'timestamp': DateTime.now().toString(),
    });
  }

  static Future<dynamic> getWeatherData(String location) async {
    final box = Hive.box(_boxName);
    final cached = box.get(location);
    
    if (cached != null) {
      final cachedTime = DateTime.parse(cached['timestamp']);
      if (DateTime.now().difference(cachedTime).inHours < _cacheDurationHours) {
        return cached['data'];
      }
    }
    return null;
  }
}