import 'package:flutter/material.dart';

class WifiPrintScreen extends StatelessWidget {
  static const routeName = "/wifi-print";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wifi Print"),
      ),
      body: Container(
        child: Center(child: Text("Wifi Print")),
      ),
    );
  }
}
