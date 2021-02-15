import 'package:flutter/material.dart' hide Image;

class BlueToothPrintScreen extends StatefulWidget {
  static const routeName = "/bluetooth-print";

  @override
  _BlueToothPrintScreenState createState() => _BlueToothPrintScreenState();
}

class _BlueToothPrintScreenState extends State<BlueToothPrintScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth print'),
        ),
        body: Center(child: Text("Bluetooth print")));
  }
}
