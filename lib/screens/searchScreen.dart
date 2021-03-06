import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:rostly/consts.dart';
import 'package:rostly/services/searchServices.dart';
import 'package:rostly/widgets/MyWidgets.dart';

import '../consts.dart';
import 'package:rostly/services/player.dart';
import 'package:video_player/video_player.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _videoPlayerURL =
      "https://static.videezy.com/system/resources/previews/000/049/581/original/testtube.mp4";
  UniqueKey _urlKey;

  @override
  void initState() {
    super.initState();
  }

  List<Widget> dialogList = [];
  void changeUrl(String newUrl) async {
    this.setState(() {
      _videoPlayerURL = newUrl;
      _urlKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(17, 17, 17, 1),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFieldNetflix(
                  onChanged: (e) {
                    print(e);
                  },
                ),
              ),
              Expanded(
                  flex: 1,
                  child: FlatButtonNetflixRed(
                    onPress: () async {
                      final SearchServices myHTTPsearchService =
                          new SearchServices(
                              url: htmlRequestsUrl + "/rostly/v1/dialogs");
                      var respondedDialogs =
                          await myHTTPsearchService.respondReceiver("keyword");
                      var a = dialogsMapper(respondedDialogs);
                      // print(a);
                      setState(() {
                        dialogList = a;
                      });
                    },
                  ))
            ],
          ),
          Player(
            videoPlayerController:
                VideoPlayerController.network(_videoPlayerURL),
            newKey: _urlKey,
          ),
          Card(
            color: kBackgroundBlack,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: dialogList,
              ),
            ),
          )
        ],
      ),
    );
  }

  ////////////////////////////////////////////////// dialog widget creator function
  List<Widget> dialogsMapper(dialogs) {
    List<Widget> dialogsTitle = [];

    for (var dialog in dialogs) {
      // print(dialog.toString());
// var a = test.map((item) => zr(item)).toList();
      dialogsTitle.add(Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: double.infinity,
        height: 45,
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        decoration: BoxDecoration(
          color: kTextFieldBackgroundBlack,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    changeUrl(dialog['URL']);
                    print(dialog['URL']);
                  },
                  child: Icon(FontAwesome5Solid.play_circle)),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(
                  dialog['sentence'],
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  // ignore: deprecated_member_use
                  // style: Theme.of(context).textTheme.subhead
                ),
              ),
            ]),
      ));
    }
    return dialogsTitle;
  }
}
