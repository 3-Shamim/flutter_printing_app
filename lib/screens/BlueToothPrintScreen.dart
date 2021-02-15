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
  bool _connected = false;
  BluetoothDevice _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Map<String, dynamic> arguments =
          ModalRoute.of(context).settings.arguments;
      printAbleData = arguments["data"];
      initBluetooth();
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothManager.startScan(timeout: Duration(seconds: 4));

    bool isConnected = await bluetoothManager.isConnected;

    bluetoothManager.state.listen((state) {
      switch (state) {
        case 12:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        case 10:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Bluetooth print'),
        ),
        body: Center(child: Text(tips)));
  }
}
