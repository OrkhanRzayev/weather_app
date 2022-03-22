// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_null_comparison, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart';
import 'package:weather_app/models/weather.dart';

class CurrentWeatherPage extends StatefulWidget {
  final List<Location> locations;

  const CurrentWeatherPage(this.locations, BuildContext context);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState(locations);
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final List<Location> locations;
  final Location location;

  Weather? _weather;

  _CurrentWeatherPageState(List<Location> locations)
      : this.locations = locations,
        this.location = locations[0];

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(
  //         'Day and Hour',
  //         style: TextStyle(color: Color.fromARGB(180, 0, 0, 0)),
  //       ),
  //       centerTitle: true,
  //       backgroundColor: Color.fromARGB(255, 253, 250, 241),
  //       elevation: 0,
  //       leading: IconButton(
  //         onPressed: () {},
  //         icon: Icon(Icons.arrow_back_ios),
  //         color: Color.fromARGB(180, 0, 0, 0),
  //       ),
  //       actions: [
  //         IconButton(
  //           onPressed: () {},
  //           icon: Icon(Icons.share),
  //           color: Color.fromARGB(180, 0, 0, 0),
  //         )
  //       ],
  //     ),
  //     backgroundColor: Color.fromARGB(255, 253, 250, 241),
  //     bottomNavigationBar: BottomNavigationBar(
  //       backgroundColor: Colors.white,
  //       items: [
  //         BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
  //         BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
  //       ],
  //     ),
  //     body: Center(
  //       child: FutureBuilder(
  //         builder: (context, snapshot) {
  //           if (snapshot != null) {
  //             Weather? _weather = snapshot.data as Weather?;
  //             if (_weather == null) {
  //               return Text('Error');
  //             } else {
  //               return weatherBox(_weather);
  //             }
  //           } else {
  //             return CircularProgressIndicator();
  //           }
  //         },
  //         future: getCurrentWeather(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 250, 241),
      body: ListView(
        children: [
          currentWeatherInfo(this.locations, this.location, this.context),
          forecastDaily(this.location),
          forecastHourly(this.location),
        ],
      ),
    );
  }
}

currentWeatherInfo(
    List<Location> locations, Location location, BuildContext context) {
  Weather? _weather;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _weather = snapshot.data as Weather?;
        if (_weather == null) {
          return Text('Error');
        } else {
          return Column(
            children: [
              weatherBox(_weather!),
              //weatherBoxInfo(_weather),
            ],
          );
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    //future: getCurrentWeather(location),
  );
}

forecastHourly(Location location) {
  Forecast? _forecast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forecast = snapshot.data as Forecast?;
        if (_forecast == null) {
          return Text("Error getting weather");
        } else {
          return hourlyBoxes(_forecast);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}

hourlyBoxes(Forecast? forecast) {
  return Text('I am hour');
}

forecastDaily(Location location) {
  Forecast? _forecast;

  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        _forecast = snapshot.data as Forecast?;
        if (_forecast == null) {
          return Text("Error getting weather");
        } else {
          return dailyBoxes(_forecast);
        }
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
    future: getForecast(location),
  );
}

dailyBoxes(Forecast? forecast) {
  return Text('I am a Day');
}

Widget weatherBox(Weather _weather) {
  return Container(
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.all(20),
    height: 300,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 68, 65, 240),
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  _weather.description,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(157, 0, 0, 0),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(157, 0, 0, 0),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

detailsText() {
  return Text('DETAILS');
}

Future getCurrentWeather() async {
  Weather? weather;
  String city = 'baku';
  String apiKey = '3861c04723f540a8a34bc514435c4b1a';
  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {
    //TODO : throw error here
  }

  return weather;
}

Future getForecast(Location location) async {
  Forecast? forecast;
  String apiKey = '3861c04723f540a8a34bc514435c4b1a';
  String city = location.city;
  String country = location.country;

  var url =
      "https://api.openweathermap.org/data/2.5/weather?q=$city$country&appid=$apiKey&units=metric";

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    forecast = Forecast.fromJson(jsonDecode(response.body));
  }

  return forecast;
}

String getDate(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var format = DateFormat('E');
  return format.format(date);
}

String getTime(int timestamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var format = DateFormat('h:mm a');
  return format.format(date);
}
