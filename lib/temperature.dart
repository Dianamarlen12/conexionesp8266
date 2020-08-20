import 'package:flutter/material.dart';
import 'package:flutter_thermometer/thermometer_widget.dart';
import 'package:flutter_thermometer/thermometer.dart';
import 'mqtt_stream.dart';
import 'Adafruit_feed.dart';

class Temperatura extends StatefulWidget {
  @override
  _TemperaturaState createState() => _TemperaturaState();
}

class _TemperaturaState extends State<Temperatura> {
  AppMqttTransactions myMqtt = AppMqttTransactions();
  String feedTEM="emmaRomero/feeds/TEMPERATURE";
  double getTem=0.0;
  String op=" °C";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscribe(feedTEM);
    print("getTem");
    print(getTem);
  }

  void subscribe(String feed) {
    myMqtt.subscribe(feed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Temperatura"),
        centerTitle: true,
      ),
      body: _viewData(),
    );
  }

  _viewData() {
    return StreamBuilder(
        stream: AdafruitFeed.sensorStream,
        builder: (context, snapshot) {
          String reading = snapshot.data;
          if (reading == null) {
            print(reading);
            reading="0.0";
          }
          getTem=double.parse(reading);
          return Container(
            margin: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: Thermometer(
              outlineColor : Colors.black54,
              outlineThickness: 3.0,
              radius: 32.0,
              label: ThermometerLabel( "$getTem $op", textStyle: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
              barWidth: 32.0,
              mercuryColor: getTem>=80? Colors.red : getTem<=25? Colors.green : Colors.orange,
              value: getTem,
              minValue: 0,
              maxValue: 100,
            ),
          );
        }
    );
  }
}
