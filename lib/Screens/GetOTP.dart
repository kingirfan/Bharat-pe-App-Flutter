import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetOTP extends StatefulWidget {
  @override
  _GetOTPState createState() => _GetOTPState();
}

class _GetOTPState extends State<GetOTP> {
  final interval = const Duration(seconds: 1);
  final int timerMaxSeconds = 60;
  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
      });
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
    currentSeconds = 0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('called');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
      ),
      bottomSheet: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.network(
              'https://image.shutterstock.com/image-illustration/world-travel-sights-famous-landmarks-260nw-1140751670.jpg',
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomLeft,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    right: 10,
                    left: 10,
                    bottom: MediaQuery.of(context).size.width * 0.25),
                height: MediaQuery.of(context).size.height * 0.40,
                alignment: Alignment.bottomCenter,
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'OTP \n',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text:
                                        'OTP is necessary for us to verify your mobile number ',
                                    style: TextStyle(
                                        height: 1.25,
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                                WidgetSpan(
                                    child: Container(
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    cursorColor: Colors.transparent,
                                    decoration: InputDecoration(
                                      hintText: '0000',
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                        fontSize: 20,
                                        letterSpacing: 2,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
                                      ),
                                    ),
                                  ),
                                )),
                                WidgetSpan(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '$timerText',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                WidgetSpan(
                                    child: Container(
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 120,
                                    child: RaisedButton(
                                      child: Text(
                                        'Ok',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: Colors.purpleAccent,
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetOTP();
                                        }));
                                      },
                                    ),
                                  ),
                                )),
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
