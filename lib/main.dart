import 'package:flutter/material.dart';
import 'color.dart';
import 'intensity.dart';
import 'temperature.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PRACTICA 2 IOT',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PRACTICA2 IOT"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50,
              width: 300,
              child: RaisedButton(
                  color: Colors.red,
                  elevation: 3,
                  child: Text(
                    "COLOR",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Colores()));
                  }),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 50,
              width: 300,
              child: RaisedButton(
                  color: Colors.red,
                  elevation: 3,
                  child: Text(
                    "TEMPERATURA",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Temperatura()));
                  }),
            ),
            SizedBox(
              height: 80,
            ),
            Container(
              height: 50,
              width: 300,
              child: RaisedButton(
                  color: Colors.red,
                  elevation: 3,
                  child: Text(
                    "INTENSIDAD",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => intensidad()));
                  }),
            )
          ],
        ),
      ),
    );
  }
}