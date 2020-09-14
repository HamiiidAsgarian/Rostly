import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../consts.dart';

class TextFieldNetflix extends StatelessWidget {
  const TextFieldNetflix({
    //  this._mycontroller;
    @required this.onChanged,
    Key key,
  }) : super(key: key);
  // final _mycontroller = new TextEditingController();
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    var _mycontroller = new TextEditingController();
    _mycontroller.addListener(() {
      // print(_mycontroller.text.length);
    });
    return Container(
      // color: Colors.blue,
      // padding: EdgeInsets.all(0),
      height: 50,
      child: Center(
        child: TextField(
          onChanged: onChanged,
          style: TextStyle(color: Colors.white, fontSize: 20),
          textAlign: TextAlign.left,
          // controller: searchCtrl,
          keyboardType: TextInputType.text,
          cursorColor: kLogoRed,
          cursorWidth: 2,
          cursorRadius: Radius.zero,
          showCursor: true,
          enableInteractiveSelection: true,
          decoration: new InputDecoration(
              prefixIcon: Icon(
                FontAwesome5Solid.search,
                size: 20,
                color: kGreyHitText,
              ),
              fillColor: kTextFieldBackgroundBlack,
              filled: true,
              // border: InputBorder.none,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7)),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              // focusedBorder: InputBorder.none,
              // enabledBorder: InputBorder.none,
              // errorBorder: InputBorder.none,
              // disabledBorder: InputBorder.none,

              // contentPadding:
              //     EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),

              // focusedBorder: OutlineInputBorder(
              //   borderSide: BorderSide(color: Colors.red, width: 1.0),
              // ),
              // enabledBorder: OutlineInputBorder(
              //   borderSide: BorderSide(color: Colors.green, width: 5.0),
              // ),
              hintText: 'Type a word to search',
              hintStyle: TextStyle(color: kGreyHitText, fontSize: 17)),
        ),
      ),
    );
  }
}

// Icon(AntDesign.save),
////////////////////////////////Icon(FontAwesome5Solid.search),
// Icon(FontAwesome.search),
// Icon(MaterialIcons.search),
// Icon(FontAwesome5.sad_tear),
////////////////////////////////Icon(FontAwesome5Solid.search),

///this has a lot of icons^^^
// Icon(FontAwesome5Brands.searchengin),
//////////////////////////////////////////////////////////////////////////////////
class FlatButtonNetflixRed extends StatelessWidget {
  const FlatButtonNetflixRed({
    @required this.onPress,
    Key key,
  }) : super(key: key);

  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 150.0,
      height: 50.0,
      child: FlatButton(
        // padding: EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(7), topRight: Radius.circular(7)),
          // side: BorderSide(color: null),
        ),
        onPressed: onPress,
        child: Text(
          "SEARCH",
          style: buttonTextStyle,
        ),
        color: kButtonRed,
      ),
    );
  }
}
