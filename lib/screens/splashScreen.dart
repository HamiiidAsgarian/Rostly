import 'package:flutter/material.dart';
import 'package:rostly/consts.dart';
import 'package:rostly/services/deviceInfo.dart';
import 'package:rostly/services/entryCounter.dart';
import 'package:rostly/services/player.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int counter;
  String _url =
      "https://static.videezy.com/system/resources/previews/000/049/581/original/testtube.mp4";

  UniqueKey _urlKey;
  var aa =
      "https://static.videezy.com/system/resources/previews/000/033/549/original/szene10.mp4";

  var bb =
      "https://static.videezy.com/system/resources/previews/000/037/964/original/baby_dog13.mp4";

  var result =
      "https://static.videezy.com/system/resources/previews/000/049/581/original/testtube.mp4";

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

  List a = [
    "https://static.videezy.com/system/resources/previews/000/033/549/original/szene10.mp4",
    "https://static.videezy.com/system/resources/previews/000/037/964/original/baby_dog13.mp4",
    "https://static.videezy.com/system/resources/previews/000/049/581/original/testtube.mp4"
  ];
  // String myUrld =
  //     "https://static.videezy.com/system/resources/previews/000/049/581/original/testtube.mp4";

  void _changeUrl(String newUrl) async {
    this.setState(() {
      _url = newUrl;
      _urlKey = UniqueKey();
    });
  }

  videoLister(list) {
    List<Widget> videoItems = [];
    int indexCounter = 0;
    if (list != null) {
      for (String item in list) {
        indexCounter++;
        videoItems.add(
          FlatButton(
              color: Colors.blue,
              onPressed: () {
                _changeUrl(item);
              },
              child: Text(indexCounter.toString())),
        );
      }
    }
    return videoItems;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> ttt = videoLister(a);
    myDevice.respondReceiver();
    return Scaffold(
      backgroundColor: kPink,
      body: Center(
        child: ListView(
          children: [
            Column(
              children: ttt,
            ),
            Player(
              videoPlayerController: VideoPlayerController.network(_url),
              newKey: _urlKey,
            ),
            FlatButton(
                onPressed: () {
                  _changeUrl(
                      "https://static.videezy.com/system/resources/previews/000/033/549/original/szene10.mp4");
                },
                child: Text("1")),
            FlatButton(
                onPressed: () {
                  _changeUrl(
                      "https://static.videezy.com/system/resources/previews/000/037/964/original/baby_dog13.mp4");
                },
                child: Text("2"))
          ],
        ),
      ),
    );
  }
}
