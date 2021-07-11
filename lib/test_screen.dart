import 'dart:convert';

import 'package:clay_containers/widgets/clay_container.dart';
import 'package:flutter/material.dart';
import 'package:health_care/model/airconditonal.dart';
import 'package:health_care/response/airconditional_response.dart';
import 'package:health_care/response/model_airconditional_response.dart';
import 'package:health_care/response/power_response.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'helper/config.dart';
import 'helper/constants.dart' as Constants;
import 'helper/models.dart';
import 'helper/mqttClientWrapper.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Id> tbs = List();
  List<IdModel> listModel = List();

  List<String> dropDownItems = List();
  List<String> dropDownItemsModel = List();

  String currentSelectedValue;
  String model;
  String mahang;
  String idprotocol;
  String imageBongDen;
  var color;

  int _value = 6;
  int mode = 0;
  int fan = 0;
  int eco = 0;
  int air = 0;
  int nhietDo = 18;
  int power = 0;
  String power2;

  List<String> listMode = ['0', '1', '2', '3'];
  List<String> listFan = ['0', '2', '3', '4'];
  List<String> listEco = ['Eco', 'Nor', 'High'];
  List<String> listAir = ['0', '1', '2', '3', '4', '5'];
  List<String> listPower = ['0', '1'];

  MQTTClientWrapper mqttClientWrapper;

  String pubTopic;

  @override
  void initState() {
    initMqtt();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  padding: EdgeInsets.only(left: 30),
                  child: Image.asset(
                    'assets/images/ic_fire.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    width: 50,
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
            SizedBox(
              height: 100,
            ),
            Container(
              height: 200,
              width: 200,
              child: Image.asset(
                imageBongDen ?? 'assets/images/ic_dentat.PNG',
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(
              height: 100,
            ),
            buildButtonPower(),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('% pin'),
            ),
            SizedBox(
              height: 30,
            ),
            buildSlider(),
          ],
        ),
      ),
    );
  }



  Future<void> initMqtt() async {
    mqttClientWrapper = MQTTClientWrapper(
        () => print('Success'), (message) => handleDevice(message));
    await mqttClientWrapper.prepareMqttClient(Constants.mac);

    // getHang();

    mqttClientWrapper.subscribe(Constants.mac, (_message) {
      print('_DetailScreenState.initMqtt $_message');
      var powerResponse = powerResponseFromJson(_message);
      power2 = powerResponse.power;
      setState(() {});
      print('_TestScreenState.initMqtt $power2');
      if (power2 == '0') {
        power = 0;
      }
      if (power2 == '1') {
        power = 1;
      }
      print('_TestScreenState.initMqtt so $power');
    });
  }


  void subPower(String message) {
    final powerResponse = powerResponseFromJson(message);
    power2 = powerResponse.power;
    print('_TestScreenState.subPower $power2');
  }

  void getModel() async {
    Airconditional a =
        Airconditional(mahang, '', '', '', '', '', '', '', Constants.mac, '');
    pubTopic = Constants.GET_MODEL;
    publishMessage(pubTopic, jsonEncode(a));
  }

  void getHang() async {
    Airconditional a =
        Airconditional('', '', '', '', '', '', '', '', Constants.mac, '');
    pubTopic = Constants.GET_HANG;
    publishMessage(pubTopic, jsonEncode(a));
  }

  Future<void> publishMessage(String topic, String message) async {
    if (mqttClientWrapper.connectionState ==
        MqttCurrentConnectionState.CONNECTED) {
      mqttClientWrapper.publishMessage(topic, message);
    } else {
      await initMqtt();
      mqttClientWrapper.publishMessage(topic, message);
    }
  }

  void handleDevice(String message) async {
    switch (pubTopic) {
      case Constants.GET_HANG:
        final airConditionerResponse = airConditionerResponseFromJson(message);
        tbs = airConditionerResponse.id;
        setState(() {});
        break;
      case Constants.GET_MODEL:
        final modelAirconditionalResponse =
            modelAirconditionalResponseFromJson(message);
        listModel = modelAirconditionalResponse.id;
        setState(() {});
        print('_TestScreenState.dropdownModelAir listmodel $listModel');
        break;
    }
    pubTopic = '';

    dropDownItems.clear();
    tbs.forEach((element) {
      dropDownItems.add(element.hang);
    });

    dropDownItemsModel.clear();
    listModel.forEach((element) {
      dropDownItemsModel.add(element.model);
    });
    print('_TestScreenState.handleDevice $dropDownItems');
    print('_TestScreenState.handleDeviceModel $dropDownItemsModel');
  }

  Widget buildSlider(){
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
                  activeColor: Colors.green,
                  inactiveColor: Colors.orange,
                  label: '$_value',
                  onChanged: (double newValue) {
                    setState(() {
                      _value = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()} dollars';
                  }
              )
          ),
        ]
    );
  }


  Widget buildButtonPower() {
    if (power == 0) {
      imageBongDen = 'assets/images/ic_dentat.PNG';
      print('_TestScreenState.buildButtonPower power1: $power');
    }
    if (power == 1) {
      imageBongDen = 'assets/images/ic_densang.PNG';
      print('_TestScreenState.buildButtonPower power2: $power');
    }

    return RaisedButton(
      onPressed: () {
        power++;
        // if (power == 1) {
        //   image = 'assets/images/ic_densang.PNG';
        //   print('_TestScreenState.buildButtonPower power: $power');
        // }
        if (power > 1) {
          power = 0;
          imageBongDen = 'assets/images/ic_densang.PNG';
          print('_TestScreenState.buildButtonPower power3: $power');

        }
          // Airconditional airconditional = Airconditional(
          //   '',
          //   'set',
          //   idprotocol,
          //   listPower[power],
          //   listFan[fan],
          //   listMode[mode],
          //   listAir[air],
          //   '${nhietDo}',
          //   Constants.mac,
          //   listEco[eco],
          // );
          // pubTopic = 'TECHNO1';
          // publishMessage(pubTopic, jsonEncode(airconditional));
          setState(() {});

      },
      child: Text('Power'),
      color: color,
    );
  }

  Widget changeColorPower(Airconditional airconditional, int i) {
    if (i == 0) {
      airconditional.color = Colors.red;
    }
  }
}
