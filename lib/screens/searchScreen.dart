import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
// import 'package:rostly/consts.dart';
import 'package:rostly/services/searchServices.dart';
import 'package:rostly/widgets/MyWidgets.dart';

import '../consts.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    super.initState();
  }

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
                    print(dialog['sentence']);
                  },
                  child: Icon(FontAwesome5Solid.play_circle)),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Text(dialog['sentence'],
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    // ignore: deprecated_member_use
                    style: Theme.of(context).textTheme.subhead),
              ),
            ]),
      ));
    }
    return dialogsTitle;
  }

  List<Widget> dialogList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(17, 17, 17, 1),
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
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
                      // print(htmlRequestsUrl + "/rostly/v1/dialogs");
                      var respondedDialogs =
                          await myHTTPsearchService.respondReceiver("keyword");
                      print(respondedDialogs[0]['sentence']);
                      print(respondedDialogs.runtimeType);
                      print(dialogList.runtimeType);

                      var a = dialogsMapper(respondedDialogs);
                      print(a);
                      setState(() {
                        dialogList = a;
                      });

                      // myHTTPsearchService.respondReceiver("sssss");
                      // print("aaaa");
                    },
                  ))
            ],
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
}
