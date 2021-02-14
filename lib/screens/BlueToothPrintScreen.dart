import 'package:flutter/material.dart' hide Image;
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';

class BlueToothPrintScreen extends StatefulWidget {
  static const routeName = "/bluetooth-print";

  @override
  _BlueToothPrintScreenState createState() => _BlueToothPrintScreenState();
}

class _BlueToothPrintScreenState extends State<BlueToothPrintScreen> {
  String _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;
  List<Map<String, dynamic>> printAbleData = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context).settings.arguments;
      printAbleData = arguments["data"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth print'),
        ),
        body: Text("Bluetooth print"));
  }
}
