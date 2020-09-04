import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rostly/screens/gateScreen.dart';
import 'package:rostly/screens/splashScreen.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => SplashScreen(),
        "/Gate": (context) => GateScreen(),
      },
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
    );
  }
}
