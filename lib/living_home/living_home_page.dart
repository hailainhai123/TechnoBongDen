import 'package:flutter/material.dart';
import 'package:health_care/living_home/lamp_switch.dart';

import 'LEDBulb.dart';
import 'lamp.dart';
import 'lamp_hanger_rope.dart';
import 'lamp_switch_rope.dart';
import 'room_name.dart';

final darkGray = const Color(0xFF232323);
final bulbOnColor = const Color(0xFFFFE12C);
final bulbOffColor = const Color(0xFFC1C1C1);
final animationDuration = const Duration(milliseconds: 500);

class LivingHomePage extends StatefulWidget {
  @override
  _LivingHomePageState createState() => _LivingHomePageState();
}

class _LivingHomePageState extends State<LivingHomePage> {
  var _isSwitchOn = false;
  int _value = 6;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Điều khiển đèn'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    width: 70,
                    padding: EdgeInsets.only(left: 30),
                    child: Image.asset(
                      'assets/images/ic_fire_black.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 50,
                      // child: Text('LAMP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/ic_lamp.jpg', fit: BoxFit.cover,),
                          SizedBox(
                            width: 10,
                          ),
                          Text('LAMP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(right: 30),
                    icon: Icon(
                      Icons.mic,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            // LampHangerRope(
            //     screenWidth: screenWidth,
            //     screenHeight: screenHeight,
            //     color: darkGray),
            LEDBulb(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              onColor: bulbOnColor,
              offColor: bulbOffColor,
              isSwitchOn: _isSwitchOn,
            ),
            Lamp(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              color: darkGray,
              isSwitchOn: _isSwitchOn,
              gradientColor: bulbOnColor,
              animationDuration: animationDuration,
            ),
            LampSwitch(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              toggleOnColor: bulbOnColor,
              toggleOffColor: bulbOffColor,
              color: darkGray,
              isSwitchOn: _isSwitchOn,
              onTap: () {
                setState(() {
                  _isSwitchOn = !_isSwitchOn;
                });
              },
              animationDuration: animationDuration,
            ),
            LampSwitchRope(
              screenWidth: screenWidth,
              screenHeight: screenHeight,
              color: darkGray,
              isSwitchOn: _isSwitchOn,
              animationDuration: animationDuration,
            ),
            // RoomName(
            //   screenWidth: screenWidth,
            //   screenHeight: screenWidth,
            //   color: darkGray,
            //   roomName: "living room",
            // ),
            Padding(
              padding: EdgeInsets.only(top: 600),
              child: buildSlider(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSlider() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.lightbulb,
            size: 30,
          ),
          new Expanded(
              child: Slider(
                  value: _value.toDouble(),
                  min: 1.0,
                  max: 20.0,
                  divisions: 10,
                  activeColor: Colors.black,
                  inactiveColor: Colors.white,
                  label: '$_value',
                  onChanged: (double newValue) {
                    setState(() {
                      _value = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  })),
        ]);
  }
}
