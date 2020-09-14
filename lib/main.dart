import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostly/screens/gateScreen.dart';
import 'package:rostly/screens/searchScreen.dart';
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
        "/": (context) => SearchScreen(),
        "/Gate": (context) => GateScreen(),
      },
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
    );
  }
}
