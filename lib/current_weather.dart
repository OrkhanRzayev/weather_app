// ignore_for_file: prefer_const_literals_to_create_immutables, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather.dart';

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Day and Hour',
          style: TextStyle(color: Color.fromARGB(180, 0, 0, 0)),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 253, 250, 241),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios),
          color: Color.fromARGB(180, 0, 0, 0),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
            color: Color.fromARGB(180, 0, 0, 0),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 253, 250, 241),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
        ],
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot != null) {
              Weather? _weather = snapshot.data as Weather?;
              if (_weather == null) {
                return Text('Error');
              } else {
                return weatherBox(_weather);
              }
            } else {
              return CircularProgressIndicator();
            }
          },
          future: getCurrentWeather(),
        ),
      ),
    );
  }

  Widget weatherBox(Weather _weather) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),
          height: 300,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 68, 65, 240),
              borderRadius: BorderRadius.all(Radius.circular(10))),
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
                        '${_weather.temprature}°С',
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Text(_weather.description),
        Text('${_weather.humidity}'),
        Text('${_weather.windSpeed}')
      ],
    );
  }

  Future getCurrentWeather() async {
    Weather? weather;
    String city = 'baku';
    String apiKey = 'ef644f9b6a057dc1863e125e24a0abc7';
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
}
