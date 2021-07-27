import 'package:flutter/material.dart';
class saved extends StatefulWidget {
  const saved({Key ?key}) : super(key: key);

  @override
  _savedState createState() => _savedState();
}

class _savedState extends State<saved> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
      ),
      body: Container(),
    );
  }
}

