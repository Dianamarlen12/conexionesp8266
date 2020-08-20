import 'package:flutter/material.dart';
import 'mqtt_stream.dart';
import 'Adafruit_feed.dart';

class intensidad extends StatefulWidget {
  @override
  _intensidadState createState() => _intensidadState();
}

class _intensidadState extends State<intensidad> {
  double _currentSliderValue = 100;

  AppMqttTransactions myMqtt = AppMqttTransactions();
  String feed="emmaRomero/feeds/LED_CONTROL";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscribe(feed);
  }

  void subscribe(String feed) {
    myMqtt.subscribe(feed);
  }

  void publish(String feed, String value) {
    myMqtt.publish(feed, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("INTENSIDAD DE LED"),
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text("SELECCION DE INTENSIDAD PARA LED", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, ),),
              SizedBox(height: 150,),
              Slider(
                value: _currentSliderValue,
                min: 0,
                max: 100,
                divisions: 10,
                label: _currentSliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    _currentSliderValue = value;
                    print(_currentSliderValue);
                  });
                  String public=_currentSliderValue.toString();
                  publish(feed, public);
                },
              )],
          )
      ),
    );
  }
}