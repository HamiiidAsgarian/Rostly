import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rostly/consts.dart';
import 'package:http/http.dart' as http;
import 'package:rostly/screens/userModel.dart';
import 'package:device_info/device_info.dart';

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

class DeviceInfo {
  final windowsWith = window.physicalSize.width;
  final windowsheight = window.physicalSize.height;

  Future<UserModel> _deviceInfoSender(String name, String job) async {
    final String url = 'https://reqres.in/api/users';
    final response = await http.post(url,
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
        body: {"name": name, "job": job});

    if (response.statusCode == 201) {
      final String responseString = response.body;
      return (userModelFromJson(responseString));
    } else
      return null;
  }

  Future<List> deviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    List<String> info = [
      androidInfo.manufacturer,
      androidInfo.brand,
      androidInfo.model,
      androidInfo.version.release
    ];
    return (info);
    // return ('Running on ${androidInfo.manufacturer}-${androidInfo.brand}-${androidInfo.model} / android:${androidInfo.version.release} '); // e.g. "Moto G (4)"
  }

  respondReceiver() async {
    List info = await deviceInfo();

    final UserModel receivedInfo = await _deviceInfoSender(info[0], info[1]);
    print(receivedInfo.job);
    print(receivedInfo.name);
    // print(user.createdAt);
    // print(user.id);

    // Navigator.pushReplacementNamed(context, "/Gate");
  }
}
