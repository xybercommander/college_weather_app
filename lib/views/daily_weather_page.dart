import 'package:flutter/material.dart';
import 'package:weather_app/utils/weather_images.dart';

class DailyWeatherPage extends StatefulWidget {
  final Map<String, dynamic>? dailyWeatherData;
  final Map<String, dynamic>? weatherDetails;
  const DailyWeatherPage({ Key? key, this.dailyWeatherData, this.weatherDetails }) : super(key: key);

  @override
  _DailyWeatherPageState createState() => _DailyWeatherPageState();
}

class _DailyWeatherPageState extends State<DailyWeatherPage> {

  String convertFahrenhiteToCelcius(double value) {
    int celcius = ((value - 32) * 5) ~/ 9;
    return celcius.toString();
  }

  List<String> weekdays = ["Sun", "Mon", "Tues", "Wed", "Thurs", "Fri", "Sat"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff002936),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16,),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff002936),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [            
            SizedBox(height: 32,),
            Container(
              padding: EdgeInsets.only(right: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: Color(0xff51A7C0),
                borderRadius: BorderRadius.circular(20)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network(weatherIcons[widget.dailyWeatherData!['DailyForecasts'][0]['Day']['Icon']].toString(), color: Colors.white, height: 80, width: 80,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Tomorrow", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: convertFahrenhiteToCelcius(widget.dailyWeatherData!['DailyForecasts'][0]['Temperature']['Minimum']['Value']),
                              style: TextStyle(color: Colors.white, fontSize: 64, fontWeight: FontWeight.bold)
                            ),
                            TextSpan(
                              text: "/" + convertFahrenhiteToCelcius(widget.dailyWeatherData!['DailyForecasts'][0]['Temperature']['Maximum']['Value']) + "°",
                              style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)
                            ),
                          ]
                        )
                      ),
                      Text(
                        widget.dailyWeatherData!['DailyForecasts'][0]['Day']['IconPhrase'],
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)
                      )
                    ],
                  )
                ]
              )
            ),
            SizedBox(height: 16,),
            Center(
              child: Container(
                width: 270,
                height: 110,
                decoration: BoxDecoration(
                  color: Color(0xff46727F),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/icons/Wind.png", color: Colors.white,),
                          Text("Wind", style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold", fontSize: 10),),
                          Text(
                            widget.weatherDetails!['wind']['speed'].toString() + "m/sec", 
                            style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold", fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 55,
                      child: Column(                                    
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/icons/Humidity.png", color: Colors.white,),
                          Text("Humidity", style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold", fontSize: 10),),
                          Text(
                            widget.weatherDetails!['main']['humidity'].toString() + "%", 
                            style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold", fontSize: 10),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 55,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/icons/Visibility.png", color: Colors.white,),
                          Text("Visibilty", style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold", fontSize: 10),),
                          Text(
                            widget.weatherDetails!['visibility'].toString() + "m", 
                            style: TextStyle(color: Colors.white, fontFamily: "Poppins-Bold", fontSize: 10),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16,),
            Expanded(
              child: SizedBox(
                height: 300,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Column(                      
                      children: [
                        SizedBox(height: 16,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              weekdays[((DateTime.now().day + index) % 7)], 
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 200,                              
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.network(weatherIcons[widget.dailyWeatherData!['DailyForecasts'][index + 1]['Day']['Icon']].toString(), color: Colors.white, height: 30, width: 30,),
                                  SizedBox(width: 2,),
                                  Text(                              
                                    widget.dailyWeatherData!['DailyForecasts'][index + 1]['Day']['IconPhrase'], 
                                    style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              convertFahrenhiteToCelcius(widget.dailyWeatherData!['DailyForecasts'][index + 1]['Temperature']['Minimum']['Value'])
                              + "/"
                              + convertFahrenhiteToCelcius(widget.dailyWeatherData!['DailyForecasts'][index + 1]['Temperature']['Maximum']['Value']),
                              style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 16,)
                      ],
                    );
                  },
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}