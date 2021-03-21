import 'dart:async';

import 'package:bharath_pe/Screens/GetPhoneNumber.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDelay = 5;

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() async{
    await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => GetPhoneNumber()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.blueAccent,
              child: CircleAvatar(
                radius: 21,
                backgroundColor: Colors.white,
                child: Icon(Icons.menu),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            RichText(
                text: TextSpan(
                    text: 'Bharat',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * 0.1,
                    ),
                    children: [
                  TextSpan(
                      text: 'Pe',
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ))
                ]))
          ],
        ),
      ),
    );
  }
}
