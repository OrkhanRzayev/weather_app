import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
            icon: Icon(Icons.check_rounded),
            color: Color.fromARGB(180, 0, 0, 0),
          )
        ],
      ),
      backgroundColor: Color.fromARGB(255, 253, 250, 241),
    );
  }
}
