import 'package:flutter/material.dart';
import 'package:rostly/consts.dart';
import 'package:rostly/services/deviceInfo.dart';
import 'package:rostly/services/entryCounter.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int counter;

  @override
  void initState() {
    super.initState();
    counterRun();
  }

  counterRun() async {
    int _newCounter = await EntryCounter.run();
    setState(() {
      counter = _newCounter;
    });
  }

  final DeviceInfo myDevice =
      new DeviceInfo(urlVal: 'https://reqres.in/api/users');

  @override
  Widget build(BuildContext context) {
    myDevice.respondReceiver();

    return Scaffold(
      backgroundColor: kPink,
      body: Center(
        child: Text(counter.toString()),
      ),
    );
  }
}
