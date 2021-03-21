import 'package:bharath_pe/Screens/GetOTP.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:mobile_number/sim_card.dart';

class GetPhoneNumber extends StatefulWidget {
  @override
  _GetPhoneNumberState createState() => _GetPhoneNumberState();
}

class _GetPhoneNumberState extends State<GetPhoneNumber> {
  static final formKey = GlobalKey<FormState>();

  String _mobileNumber = '';
  List<SimCard> _simCard = <SimCard>[];
  TextEditingController getPhoneNumber = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });
    initMobileNumberState();
  }


  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    try {
      mobileNumber = await MobileNumber.mobileNumber;
      _simCard = await MobileNumber.getSimCards;
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }
    if (!mounted) return;

    setState(() {
      _mobileNumber = mobileNumber;
    });
  }

  Widget fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
        'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
        .toList();
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {

    print(_mobileNumber);
    //showMobileListDialog(context);

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
                  child: Form(
                    key: formKey,
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
                                      controller: getPhoneNumber,
                                      onTap: (){
                                        showMobileListDialog(context);
                                      },
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
            ),
          )
        ],
      ),
    );
  }
  void showMobileListDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.height / 1.2,
              height: MediaQuery.of(context).size.height / 4,
              child: Container(
                alignment: Alignment.topRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Continue with'),
                    ListTile(
                      onTap: (){
                          getPhoneNumber.text = _mobileNumber;
                          Navigator.pop(context);
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        radius: 25,
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        '${_mobileNumber}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20

                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                          'None of the above',
                        style: TextStyle(
                          color: Colors.blue
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
