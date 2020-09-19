import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:rostly/screens/splashScreen.dart';
// import 'package:rostly/screens/videoFullScreen.dart';
import 'package:rostly/services/originalPlayer.dart';
// import 'package:rostly/screens/splashScreen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((_) {
  runApp(MyApp());
  // });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: "/",
      routes: {
        "/": (context) => VideoPlayerScreen()
        // SearchScreen(),
        ,
        "/Gate": (context) => SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
    );
  }
}
