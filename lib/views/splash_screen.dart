import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_app/service/weather_api.dart';
import 'package:weather_app/views/hourly_weather_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  List<dynamic> hourlyWeatherData = [];
  List<dynamic> currentWeatherData = [];
  Map<String, dynamic> currentWeatherDetailedData = {};
  Map<String, dynamic> dailyWeatherData = {};


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getCoordinates() async {
    Position position = await _determinePosition();
    print("LATITUDE ---------> " + position.latitude.toString());
    print("LONGITUDE ---------> " + position.longitude.toString());

    hourlyWeatherData = await WeatherApi().getHourlyWeatherData(position.latitude.toString().substring(0,6), position.longitude.toString().substring(0,6));
    currentWeatherData = await WeatherApi().getCurrentWeatherData(position.latitude.toString().substring(0,6), position.longitude.toString().substring(0,6));    
    currentWeatherDetailedData = await WeatherApi().getCurrentWeatherDetailed(position.latitude.toString().substring(0,6), position.longitude.toString().substring(0,6));
    dailyWeatherData = await WeatherApi().getDailyWeatherData(position.latitude.toString().substring(0,6), position.longitude.toString().substring(0,6));
    
    print(currentWeatherDetailedData);
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, PageTransition(
        child: HourlyWeatherPage(
          hourlyWeatherData: hourlyWeatherData,
          currentWeatherData: currentWeatherData,
          dailyWeatherData: dailyWeatherData,
          currentWeatherDetailedData: currentWeatherDetailedData,
        ), 
        type: PageTransitionType.rightToLeftWithFade,
        duration: Duration(milliseconds: 500)
      ));
    });
  }

  @override
  void initState() {    
    super.initState();
    getCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              child: Lottie.asset("assets/animations/weather_loading.json"),
            ),
            Container(              
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset("assets/animations/loading.json"),
            ),
          ],
        ),
      ),
    );
  }
}