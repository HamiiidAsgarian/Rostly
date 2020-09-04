import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rostly/consts.dart';
import 'package:rostly/services/deviceInfo.dart';

class SplashScreen extends StatelessWidget {
  final DeviceInfo myDevice = new DeviceInfo();

  @override
  Widget build(BuildContext context) {
    myDevice.respondReceiver();
    return Scaffold(
      backgroundColor: kPink,
      body: Center(
          child: ColorFiltered(
        child: Image.asset("images/logo.png"),
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
      )),
    );
  }
}
