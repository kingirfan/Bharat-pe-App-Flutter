import 'package:bharath_pe/Screens/GetOTP.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetPhoneNumber extends StatefulWidget {
  @override
  _GetPhoneNumberState createState() => _GetPhoneNumberState();
}

class _GetPhoneNumberState extends State<GetPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.purpleAccent,
        ),
      ),
      backgroundColor: Colors.grey.shade50,
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
                height: MediaQuery.of(context).size.height * 0.35,
                alignment: Alignment.bottomCenter,
                child: Card(
                  elevation: 5,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Mobile Number \n',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: 'Primary Phone Number for Business',
                                    style: TextStyle(
                                        height: 2,
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                                WidgetSpan(
                                    child: Container(
                                  child: TextFormField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    cursorColor: Colors.transparent,
                                    decoration: InputDecoration(
                                      hintText: '9000000000',
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
                                        Navigator.push(context, MaterialPageRoute(builder: (context){
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
