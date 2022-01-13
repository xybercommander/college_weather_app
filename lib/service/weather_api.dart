import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather_app/apiKeys.dart';

class WeatherApi {

  Future<List<dynamic>> getHourlyWeatherData(String lat, String long) async {
    List<dynamic> res = [];
    try {
      Response locationResponse = await get(
        Uri.parse("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$apiKey1&q=$lat%2C$long")
      );
      dynamic locationData = jsonDecode(locationResponse.body);
      String locationKey = locationData['Key']; 
      print(locationKey);     
      
      Response hourlyResponse = await get(
        Uri.parse("http://dataservice.accuweather.com/forecasts/v1/hourly/12hour/$locationKey?apikey=$apiKey1")
      );
      dynamic hourlyData = jsonDecode(hourlyResponse.body);
      res = hourlyData;
    } catch(e) {
      print(e.toString());
    }      
    return res;
  }

  Future<List<dynamic>> getCurrentWeatherData(String lat, String long) async {
    List<dynamic> res = [];
    try {
      Response locationResponse = await get(
        Uri.parse("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$apiKey1&q=$lat%2C$long")
      );
      dynamic locationData = jsonDecode(locationResponse.body);
      String locationKey = locationData['Key'];
      
      Response currentResponse = await get(
        Uri.parse("http://dataservice.accuweather.com/currentconditions/v1/$locationKey?apikey=$apiKey1")
      );
      dynamic currentData = jsonDecode(currentResponse.body);
      // print("WIND SPEED -----> " + currentData['Wind']['Speed']);
      res = currentData;
    } catch(e) {
      print(e.toString());
    }      
    return res;
  }

  Future<Map<String, dynamic>> getDailyWeatherData(String lat, String long) async {
    Map<String, dynamic> res = {};
    try {
      Response locationResponse = await get(
        Uri.parse("http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=$apiKey1&q=$lat%2C$long")
      );
      dynamic locationData = jsonDecode(locationResponse.body);
      String locationKey = locationData['Key'];
      
      Response dailyResponse = await get(
        Uri.parse("http://dataservice.accuweather.com/forecasts/v1/daily/5day/$locationKey?apikey=$apiKey1")
      );
      dynamic dailyData = jsonDecode(dailyResponse.body);      
      res = dailyData;
    } catch(e) {
      print(e.toString());
    }      
    return res;
  }

  Future<Map<String, dynamic>> getCurrentWeatherDetailed(String lat, String long) async {
    Map<String, dynamic> res = {};
    try {
      Response response = await get(
        Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=$apiKey2")
      );
      dynamic data = jsonDecode(response.body);
      res = data;
    } catch(e) {
      print(e.toString());
    }
    return res;
  }

}