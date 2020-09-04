import 'package:flutter/material.dart';
import 'package:rostly/consts.dart';
import 'package:http/http.dart' as http;
import 'package:rostly/screens/userModel.dart';
import 'package:device_info/device_info.dart';

Future<UserModel> createUser(String name, String job) async {
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

class SplashScreen extends StatelessWidget {
  // Future<http.Response> createAlbum(String name, String job) {
  //   return http.post(
  //     'https://reqres.in/api/users',
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(<String, String>{"name": name, "job": job}),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    Future<String> al() async {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(
          'Running on ${androidInfo.manufacturer}-${androidInfo.brand} / android:${androidInfo.version.release} '); // e.g. "Moto G (4)"
      // print('Running brand ${androidInfo.brand}'); // e.g. "Moto G (4)"
      // print('Running version.release ${androidInfo.version.release}');

      // print(
      //     'Running model ${androidInfo.model}'); // e.g. "Moto G (4)androidInfo.version.sdkInt

      // print(
      //     'Running version.sdkInt ${androidInfo.version.sdkInt}'); // e.g. "Moto G (4)androidInfo.version.sdkInt

      // print('Running device ${androidInfo.device}'); // e.g. "Moto G (4)"
      // print('Running display ${androidInfo.display}'); // e.g. "Moto G (4)"
      // print('Running hardware ${androidInfo.hardware}'); // e.g. "Moto G (4)"

      // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      // print('Running on ${iosInfo.utsname.machine}');
      return ('Running on ${androidInfo.manufacturer}-${androidInfo.brand}-${androidInfo.model} / android:${androidInfo.version.release} '); // e.g. "Moto G (4)"
    }

    infoSender() async {
      final UserModel user = await createUser("name22", "job11");
      print(user.id);
      print(user.job);
      print(user.name);
      print(user.createdAt);

      Navigator.pushReplacementNamed(context, "/Gate");
    }

    infoSender();
    return Scaffold(
      backgroundColor: kPink,
      body: Center(
          child: ColorFiltered(
        child: Image.asset("images/logo.png"),
        colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
      )
          // FlatButton(
          //   color: Colors.white,
          //   child: Text("data"),
          //   onPressed: () async {
          //     final UserModel user = await createUser("name", "job");
          //     print(user.id);
          //     print(user.job);
          //     print(user.name);
          //     print(user.createdAt);
          //   },
          // ),
          ),
    );
  }
}
