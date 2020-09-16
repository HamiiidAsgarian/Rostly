import 'package:flutter/cupertino.dart';
// import 'package:rostly/screens/userModel.dart';
import 'package:http/http.dart' as http;
// import 'dart:math';
import 'dart:convert';

class SearchServices {
  SearchServices({@required this.url});
  final String url;
  // final String keyWord;

  // ignore: missing_return
  Future<UserModel> keywordSender(String keyword) async {
    final response = await http.post(url,
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
        body: {"keyword": "Random().nextInt(50 - 90).toString()"});
    // print(response.statusCode);
    if (response.statusCode == 201) {
      final String responseString = response.body;
      var finalUserModelRespond = searchUserModelFromJson(responseString);
      // print(finalUserModelRespond.scenes);
      return finalUserModelRespond;
    } else
      return null;
  }

  respondReceiver(keyWord) async {
    // List info = await deviceInfo();

    final UserModel receivedInfo = await keywordSender(keyWord);
    // print(receivedInfo.scenes);
    return (receivedInfo.scenes);
    // print("${receivedInfo.job} has posted");
    // print("${receivedInfo.name} has posted");

    // print(user.createdAt);
    // print(user.id);
  }
}

////////////////////////////////////////////////////////
// To parse this JSON data, do
//
//     final userModel = searchUserModelFromJson(jsonString);

UserModel searchUserModelFromJson(String str) =>
    UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.scenes,
    // this.job,
    // this.id,
    // this.createdAt,
  });

  List scenes;
  // String job;
  // String id;
  // DateTime createdAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        scenes: json["scenes"],
        // job: json["job"],
        // id: json["id"],
        // createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "scenes": scenes,
        // "job": job,
        // "id": id,
        // "createdAt": createdAt.toIso8601String(),
      };
}
