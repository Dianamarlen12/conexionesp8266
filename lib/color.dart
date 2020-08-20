import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'mqtt_stream.dart';
import 'Adafruit_feed.dart';

class Colores extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ColoresState();
}

class _ColoresState extends State<Colores> {
  Color currentColor = Colors.limeAccent;
  List<Color> currentColors = [Colors.limeAccent, Colors.green];

  AppMqttTransactions myMqtt = AppMqttTransactions();
  String feed="emmaRomero/feeds/Color_RGB";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subscribe(feed);
  }

  void changeColor(Color color) => setState(() => currentColor = color);

  void changeColors(List<Color> colors) =>
      setState(() => currentColors = colors);

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
          title: Text('LED RGB Color Picker'),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          AlertDialog(
            titlePadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            content: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                ColorPicker(
                  pickerColor: currentColor,
                  onColorChanged: changeColor,
                  colorPickerWidth: 400.0,
                  pickerAreaHeightPercent: 0.6,
                  enableAlpha: true,
                  displayThumbColor: true,
                  showLabel: true,
                  paletteType: PaletteType.hsv,
                  pickerAreaBorderRadius: const BorderRadius.only(
                    topLeft: const Radius.circular(2.0),
                    topRight: const Radius.circular(2.0),
                  ),
                ),
                RaisedButton(
                  child: Text("Publicar", style: TextStyle(color: Colors.grey),),
                    color: currentColor,
                    onPressed: () {
                    String get=currentColor.value.toRadixString(16).toString();
                    String public=get.substring(2, 8);
                    print(get);
                    print(public);
                    publish(feed, public);
                })
              ],
            )),
          ),
        ]));
  }
}
