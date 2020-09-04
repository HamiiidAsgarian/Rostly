import 'package:flutter/material.dart';

class GateScreen extends StatefulWidget {
  @override
  _GateScreenState createState() => _GateScreenState();
}

class _GateScreenState extends State<GateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Wellcome where are you going?"),
      ),
    );
  }
}
