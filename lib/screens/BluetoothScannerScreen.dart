// import 'dart:typed_data';

import 'package:flutter/material.dart';

class BluetoothScannerScreen extends StatefulWidget {
  static const routeName = "/bluetooth-scanner";

  @override
  _BluetoothScannerScreenState createState() => _BluetoothScannerScreenState();
}

class _BluetoothScannerScreenState extends State<BluetoothScannerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bluetooth Scanner"),
      ),
      body: Center(
        child: Text("Bluetooth Scanner"),
      ),
    );
  }
}
