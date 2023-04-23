import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class stopwatch extends StatefulWidget {
  const stopwatch({Key? key}) : super(key: key);

  @override
  State<stopwatch> createState() => _stopwatchState();
}

class _stopwatchState extends State<stopwatch> {
  @override
  Stopwatch sw = Stopwatch();
  Timer? time;
  String? DisplayTime = "00:00:00";
  void timestart() {
    time = Timer.periodic(Duration(milliseconds: 30), (Timer time) {
      var milliseconds = sw.elapsedMilliseconds;
      var secs = milliseconds ~/ 1000;
      var hours = (secs ~/ 3600).toString().padLeft(2, '0');
      var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
      var seconds = (secs % 60).toString().padLeft(2, '0');
      setState(() {
        DisplayTime = '$hours: $minutes:$seconds';
      });
    });
    sw.start();
  }

  void Timepause() {
    time?.cancel();
    sw.stop();
  }

  void Timeclear() {
    Timepause();
    sw.reset();

    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("StopWatch"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$DisplayTime",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 40),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        timestart();
                      },
                      child: Text("Start")),
                  ElevatedButton(
                      onPressed: () {
                        Timepause();
                      },
                      child: Text("Pause")),
                  ElevatedButton(
                      onPressed: () {
                        Timeclear();
                      },
                      child: Text("Clear"))
                ],
              )
            ],
          ),
        ));
  }
}
