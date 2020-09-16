import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostly/screens/splashScreen.dart';
import 'package:rostly/services/originalPlayer.dart';
// import 'package:rostly/screens/splashScreen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: "/",
      routes: {
        "/": (context) => VideoPlayerApp()
        // SearchScreen(),
        ,
        "/Gate": (context) => SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
    );
  }
}
