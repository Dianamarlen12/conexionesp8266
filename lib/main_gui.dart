import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'mqtt_stream.dart';
import 'Adafruit_feed.dart';

class MqttGui extends StatefulWidget{
  @override
  _MqttGuiState createState() => _MqttGuiState();
  }

class _MqttGuiState extends State<MqttGui>{

  AppMqttTransactions myMqtt = AppMqttTransactions();
  final TopicController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Getting/Handling data from Adafruit"),
      centerTitle: true,
      ),
      body:
        _body()
    );
  }

  Widget _body (){
    return Column(
      children: <Widget>[
        _subscriptionData(),
        SizedBox(height: 20.0,),
        _viewData(),
        SizedBox(height: 20.0,),
        _publishData()
      ],
    );
  }

  //First element of the UI
  Widget _subscriptionData (){
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Feed/Topic: ",
                style: TextStyle(fontSize: 20, color: Colors.white),),
              Flexible(
                child: TextField(
                  controller: TopicController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(

                      ),
                      hintText: "Full name of Feed on Adafruit"
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          RaisedButton(
            color: Colors.redAccent,
            textColor: Colors.white,
            child: Text("Subscribe"),
            onPressed: (){
              subscribe(TopicController.text);
            },
          ),
          SizedBox(height: 20,),
          Text("Value received from Temperature sensor")
        ],
      )
    );
  }

  _viewData(){
    return StreamBuilder(
      stream: AdafruitFeed.sensorStream,
      builder: (context, snapsot){
        String reading = snapsot.data;
        if(reading == null){
          reading = "no value avalble";
        }
        return Text(reading);
      }
   );
  }

  Widget _publishData (){
    return Container(
        margin: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Value: ",
                  style: TextStyle(fontSize: 20, color: Colors.white),),
                Flexible(
                  child: TextField(
                    controller: valueController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Value to publish"
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            RaisedButton(
              color: Colors.redAccent,
              textColor: Colors.white,
              child: Text("Send DATA"),
              onPressed: (){
                publish(TopicController.text, valueController.text);
              },
            ),
            SizedBox(height: 20,),
            //Text("Value received from Temperature sensor")
          ],
        )
    );
  }

  //Controller methods for adafruit
  void subscribe(String feed){
    myMqtt.subscribe(feed);
  }

  void publish(String feed, String value){
    myMqtt.publish(feed, value);
  }
}