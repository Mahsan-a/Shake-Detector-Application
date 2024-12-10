import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:flutter/cupertino.dart';
import 'package:csv/csv.dart';
import 'package:shake/shake.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

List<List<dynamic>> rows = List<List<dynamic>>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // variables for x, y, z acceleration
  double x, y, z;
  int ShakeCount = 0;
  int GestureCount = 0;
  //variable for our start/stop button state
  /// Whether the pop-up window has been displayed.
  bool btnON = false;
  //ShakeDetector detector;
  @override
  void initState() {
    super.initState();
    //final PhoneShakeCallback onPhoneShake;
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
      // Shake the threshold, the maximum value can be different for different mobile phones, such as a brand mobile phone can only reach 20.
      int value = 10;
      if (btnON == true) {
        print(btnON);
        //ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
        accelerometerEvents.listen((AccelerometerEvent event) {
          setState(() {
            print(event.x);
            print(event.y);
            print(event.z);
            if (event.x >= value ||
                event.x <= -value ||
                event.y >= value ||
                event.y <= -value ||
                event.z >= value ||
                event.z <= -value) {
                print(event.x);
                print(event.y);
                print(event.z);
                ShakeCount++;
              //onPhoneShake();
            }
          });
        });
      }
    });
    //super.initState();
  }
//@override
//  void dispose() {
//    detector.stopListening();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Sensor gesture/shake detector"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                  child: new Container(
                    child: new Text("NUMBER OF GESTURES (DoubleTap HERE)"),
                    decoration: new BoxDecoration(color: Colors.amber),
                  ),
                  onDoubleTap: (){
                    GestureCount++;
                    Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("DoubleTapped")));
                  }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(GestureCount.toStringAsFixed(2),    //trim the z axis value to 2 digit after decimal point
                  style: TextStyle(fontSize: 20.0)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                child: Text("NUMBER OF SHAKES : ",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(ShakeCount.toStringAsFixed(2),    //trim the z axis value to 2 digit after decimal point
                  style: TextStyle(fontSize: 20.0)),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(

                child: btnON ? Text("Tracking Started") : Text("Tracking Stopped"),
                onPressed: () {
                  if(btnON==false) {
                    print('Tracking Stopped!!!');
                    print(btnON);
                  }
                  else {
                    print('Tracking Started!!!');
                    print(btnON);
                  }

                  //switching button state
                  setState(() {

                    btnON  = !btnON;}
                  );
                },

              ),
            ),
          ],
        ),

      ),
    );

  }
}
