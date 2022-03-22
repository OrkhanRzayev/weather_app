// ignore_for_file: prefer_const_literals_to_create_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/current_weather.dart';
import 'package:weather_app/models/location.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 List<Location> locations = [ Location('baku', 'azerbaycan')];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weahter App',
      home: CurrentWeatherPage(locations, context),
    );
  }
}




