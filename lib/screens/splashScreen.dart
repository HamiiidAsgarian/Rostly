import 'package:flutter/material.dart';
import 'package:rostly/consts.dart';
import 'package:http/http.dart' as http;
import 'package:rostly/screens/userModel.dart';

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
    run() async {
      final UserModel user = await createUser("name22", "job11");
      print(user.id);
      print(user.job);
      print(user.name);
      print(user.createdAt);

      Navigator.pushReplacementNamed(context, "/Gate");
    }

    run();
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
