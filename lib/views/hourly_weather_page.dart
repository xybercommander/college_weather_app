import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:weather_app/utils/weather_images.dart';
import 'package:weather_app/views/daily_weather_page.dart';

class HourlyWeatherPage extends StatefulWidget {
  final List<dynamic>? hourlyWeatherData;
  final List<dynamic>? currentWeatherData;
  final Map<String, dynamic>? dailyWeatherData;
  final Map<String, dynamic>? currentWeatherDetailedData;
  const HourlyWeatherPage({ 
    Key? key, 
    this.hourlyWeatherData, 
    this.currentWeatherData, 
    this.dailyWeatherData, 
    this.currentWeatherDetailedData 
  }) : super(key: key);

  @override
  _HourlyWeatherPageState createState() => _HourlyWeatherPageState();
}

class _HourlyWeatherPageState extends State<HourlyWeatherPage> {

  String convertFahrenhiteToCelcius(double value) {
    int celcius = ((value - 32) * 5) ~/ 9;
    return celcius.toString();
  }

  List<String> weekday = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(          
          children: [
            Container(
              padding: EdgeInsets.only(top: 60),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(weatherImages[widget.currentWeatherData![0]['WeatherIcon']].toString()),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(weekday[DateTime.now().weekday - 1], style: TextStyle(color: Color(0xff00314B), fontSize: 24, fontFamily: "Poppins-Bold")),
                  // SizedBox(height: 12,),
                  Text(DateFormat('hh:mm a').format(DateTime.now()), style: TextStyle(color: Color(0xff00314B), fontSize: 36, fontFamily: "Poppins-Bold")),
                  SizedBox(height: 32,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    height: 280,
                    width: MediaQuery.of(context).size.width,                    
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7.0, sigmaY: 7.0),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 24),                       
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.network(weatherIcons[widget.currentWeatherData![0]['WeatherIcon']].toString(), color: Color(0xff00314B), height: 50, width: 50,),
                                        Text(
                                          "${widget.currentWeatherData![0]['WeatherText']}", 
                                          style: TextStyle(color: Color(0xff00314B), fontSize: 16, fontFamily: "Poppins-Bold")
                                        ),
                                        Text(
                                          widget.currentWeatherData![0]['IsDayTime'] ? "Morning" : "Night", 
                                          style: TextStyle(color: Color(0xff00314B), fontFamily: "Poppins-Bold")
                                        ),
                                      ],
                                    ),
                                    Text(widget.currentWeatherData![0]['Temperature']['Metric']['Value'].toString() + "°C", style: TextStyle(color: Color(0xff00314B), fontSize: 40, fontFamily: "Poppins-Bold")),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 55,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/Wind.png"),
                                        Text("Wind", style: TextStyle(color: Color(0xff00314B), fontFamily: "Poppins-Bold", fontSize: 10),),
                                        Text(
                                          widget.currentWeatherDetailedData!['wind']['speed'].toString() + "m/sec", 
                                          style: TextStyle(color: Color(0xff00314B), fontFamily: "Poppins-Bold", fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 55,
                                    child: Column(                                    
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/Humidity.png"),
                                        Text("Humidity", style: TextStyle(color: Color(0xff00314B), fontFamily: "Poppins-Bold", fontSize: 10),),
                                        Text(
                                          widget.currentWeatherDetailedData!['main']['humidity'].toString() + "%", 
                                          style: TextStyle(color: Color(0xff00314B), fontFamily: "Poppins-Bold", fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 55,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset("assets/icons/Visibility.png"),
                                        Text("Visibilty", style: TextStyle(color: Color(0xff00314B), fontFamily: "Poppins-Bold", fontSize: 10),),
                                        Text(
                                          widget.currentWeatherDetailedData!['visibility'].toString() + "m", 
                                          style: TextStyle(color: Color(0xff00314B), fontFamily: "Poppins-Bold", fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 1.9,
                decoration: BoxDecoration(
                  color: Color(0xff002936),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  )
                ),
                child: Column(                  
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Today", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Poppins-Bold"),),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, 
                                PageTransition(
                                  child: DailyWeatherPage(dailyWeatherData: widget.dailyWeatherData, weatherDetails: widget.currentWeatherDetailedData,), 
                                  type: PageTransitionType.bottomToTop,
                                  // duration: Duration(milliseconds: 400)
                                )
                              );
                            },
                            child: Text("Next 5 Days >", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Poppins-Bold"),)
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16,),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 11,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            height: MediaQuery.of(context).size.width / 3,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xff467280),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("${convertFahrenhiteToCelcius(widget.hourlyWeatherData![index]['Temperature']['Value'])}°C", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: "Poppins-Bold"),),
                                Image.network(weatherIcons[widget.currentWeatherData![0]['WeatherIcon']].toString(), color: Colors.white, height: 25, width: 25,),
                                Text("${widget.hourlyWeatherData![index]['DateTime'].toString().substring(11, 16)}", style: TextStyle(color: Colors.white, fontSize: 14, fontFamily: "Poppins"),),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}