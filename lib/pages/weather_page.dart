// import 'package:flutter/material.dart';
// import 'package:weather_mockon/api/weather_api.dart';
// import 'package:weather_mockon/pages/weather_model.dart';


// class WeatherPage extends StatefulWidget {
//   const WeatherPage({super.key});

//   @override
//   State<WeatherPage> createState() => _WeatherPageState();
// }

// class _WeatherPageState extends State<WeatherPage> {
//   ApiResponse? response;
//   bool inProgress = false;
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Weather App', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       extendBodyBehindAppBar: true,
//       body: WeatherBackground(
//         child: Padding(
//           padding: const EdgeInsets.all(18),
//           child: Column(
//             children: [
//               const SizedBox(height: 80),
//               _buildSearchWidget(),
//               const SizedBox(height: 20),
//               if (inProgress)
//                 const CircularProgressIndicator(color: Colors.white)
//               else
//                 _buildWeatherWidget(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchWidget() {
//     return TextField(
//       controller: _searchController,
//       decoration: InputDecoration(
//         hintText: "Chercher un emplacement...",
//         hintStyle: const TextStyle(color: Colors.white70),
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.2),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//           borderSide: BorderSide.none,
//         ),
//         prefixIcon: const Icon(Icons.search, color: Colors.white),
//         suffixIcon: _searchController.text.isNotEmpty
//             ? IconButton(
//                 icon: const Icon(Icons.clear, color: Colors.white),
//                 onPressed: () {
//                   _searchController.clear();
//                   setState(() {});
//                 },
//               )
//             : null,
//         contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
//       ),
//       style: const TextStyle(color: Colors.white),
//       onSubmitted: (value) {
//         _getWeatherData(value);
//       },
//       onChanged: (value) {
//         setState(() {});
//       },
//     );
//   }

//   Future<void> _getWeatherData(String location) async {
//     setState(() {
//       inProgress = true;
//     });

//     try {
//       response = await WeatherApi().getCurrentWeather(location);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Erreur: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         inProgress = false;
//       });
//     }
//   }

//   Widget _buildWeatherWidget() {
//     if (response == null) {
//       return const Text(
//         "Recherchez un lieu pour obtenir les données météo",
//         style: TextStyle(color: Colors.white, fontSize: 18),
//       );
//     } else {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Ma Position',
//               style: TextStyle(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 shadows: [
//                   Shadow(
//                     blurRadius: 10,
//                     color: Colors.black.withOpacity(0.3),
//                     offset: const Offset(2, 2),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               response?.location?.name ?? "",
//               style: const TextStyle(
//                 fontSize: 24,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "${response?.current?.tempC?.toStringAsFixed(1) ?? ""}°C",
//               style: TextStyle(
//                 fontSize: 72,
//                 fontWeight: FontWeight.w700,
//                 color: Colors.white,
//                 shadows: [
//                   Shadow(
//                     blurRadius: 10,
//                     color: Colors.black.withOpacity(0.3),
//                     offset: Offset(2, 2),
//                   )
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               response?.current?.condition?.text ?? "",
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//               ),
//             ),
//             if (response?.current?.windKph != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildWeatherInfo(
//                       icon: Icons.air,
//                       value: "${response?.current?.windKph} km/h",
//                       label: "Vent",
//                     ),
//                     const SizedBox(width: 20),
//                     _buildWeatherInfo(
//                       icon: Icons.water_drop,
//                       value: "${response?.current?.humidity}%",
//                       label: "Humidité",
//                     ),
//                   ],
//                 ),
//               ),
//           ],
//         ),
//       );
//     }
//   }

//   Widget _buildWeatherInfo({
//     required IconData icon,
//     required String value,
//     required String label,
//   }) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.white, size: 30),
//         const SizedBox(height: 4),
//         Text(value, style: const TextStyle(color: Colors.white)),
//         Text(label, style: const TextStyle(color: Colors.white70)),
//       ],
//     );
//   }
// }

// class WeatherBackground extends StatelessWidget {
//   final Widget child;
  
//   const WeatherBackground({Key? key, required this.child}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: double.infinity,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [
//             Colors.blue.shade800,
//             Colors.lightBlue.shade400,
//           ],
//           stops: const [0.1, 0.9],
//         ),
//       ),
//       child: SafeArea(
//         child: Stack(
//           children: [
//             // 
//             Positioned(
//               top: 100,
//               right: 30,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withOpacity(0.1),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 50,
//               left: 20,
//               child: Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.white.withOpacity(0.05),
//                 ),
//               ),
//             ),
//             // Contenu principal
//             child,
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:weather_mockon/api/weather_api.dart';
import 'package:weather_mockon/pages/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  ApiResponse? response;
  bool inProgress = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      extendBodyBehindAppBar: true,
      body: WeatherBackground(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              const SizedBox(height: 80),
              _buildSearchWidget(),
              const SizedBox(height: 20),
              if (inProgress)
                const CircularProgressIndicator(color: Colors.white)
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildWeatherWidget(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: "Chercher un emplacement...",
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  _searchController.clear();
                  setState(() {});
                },
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      ),
      style: const TextStyle(color: Colors.white),
      onSubmitted: (value) {
        _getWeatherData(value);
      },
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  Future<void> _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      response = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }

  Widget _buildWeatherWidget() {
    if (response == null) {
      return const Center(
        child: Text(
          "Recherchez un lieu",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          _buildCurrentWeather(),
          const SizedBox(height: 30),      
          _buildNextHoursForecast(),
          if (response?.forecast?.forecastday?.isNotEmpty ?? false)
            _build24HourForecast(),
        ],
      );
    }
  }

  Widget _buildCurrentWeather() {
    return Column(
      children: [
        Text(
          'Ma Position',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(2, 2),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          response?.location?.name ?? "",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "${response?.current?.tempC?.toStringAsFixed(1) ?? ""}°C",
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(2, 2),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          response?.current?.condition?.text ?? "",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        if (response?.current?.windKph != null)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildWeatherInfo(
                  icon: Icons.air,
                  value: "${response?.current?.windKph} km/h",
                  label: "Vent",
                ),
                const SizedBox(width: 20),
                _buildWeatherInfo(
                  icon: Icons.water_drop,
                  value: "${response?.current?.humidity}%",
                  label: "Humidité",
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildNextHoursForecast() {

    final now = DateTime.now();
    final currentHour = now.hour;

    final todayForecast = response?.forecast?.forecastday?.first.hour ?? [];
    
    final nextHours = todayForecast.where((hour) {
      final hourTime = DateTime.parse(hour.time ?? '');
      return hourTime.hour >= currentHour;
    }).toList();
    
    if (nextHours.length < 6 && (response?.forecast?.forecastday?.length ?? 0) > 1) {
      final tomorrowForecast = response?.forecast?.forecastday?[1].hour ?? [];
      final neededHours = 6 - nextHours.length;
      nextHours.addAll(tomorrowForecast.take(neededHours));
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            'Prochaines heures',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: nextHours.length,
            itemBuilder: (context, index) {
              final hour = nextHours[index];
              final time = DateTime.parse(hour.time ?? '');
              final hourString = '${time.hour}h';
              
              return Container(
                width: 80,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      hourString,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${hour.tempC?.round()}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (hour.condition?.icon != null)
                      Image.network(
                        'https:${hour.condition?.icon}',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _build24HourForecast() {
    final hourlyForecast = response?.forecast?.forecastday?.first.hour ?? [];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, bottom: 8, top: 20),
          child: Text(
            'Prochaines 24 heures',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyForecast.length,
            itemBuilder: (context, index) {
              final hour = hourlyForecast[index];
              final time = DateTime.parse(hour.time ?? '');
              final hourString = '${time.hour}h';
              
              return Container(
                width: 80,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      hourString,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      '${hour.tempC?.round()}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (hour.condition?.icon != null)
                      Image.network(
                        'https:${hour.condition?.icon}',
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    Text(
                      hour.condition?.text ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeatherInfo({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white)),
        Text(label, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class WeatherBackground extends StatelessWidget {
  final Widget child;
  
  const WeatherBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade800,
            Colors.lightBlue.shade400,
          ],
          stops: const [0.1, 0.9],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 100,
              right: 30,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 20,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}