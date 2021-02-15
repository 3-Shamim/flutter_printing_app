import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothScannerScreen extends StatefulWidget {
  static const routeName = "/bluetooth-scanner";

  @override
  _BluetoothScannerScreenState createState() => _BluetoothScannerScreenState();
}

class _BluetoothScannerScreenState extends State<BluetoothScannerScreen> {
  BluetoothDevice device;
  BluetoothState state;
  BluetoothDeviceState deviceState;
  FlutterBlue bluetoothInstance = FlutterBlue.instance;

  ///Initialisation and listening to device state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //checks bluetooth current state
    FlutterBlue.instance.state.listen((state) {
      if (state == BluetoothState.off) {
        //Alert user to turn on bluetooth.
        print('OFF');
      } else if (state == BluetoothState.on) {
        //if bluetooth is enabled then go ahead.
        // Make sure user's device gps is on.
        print('ON');
        scanForDevices();
      }
    });
  }

  ///// **** Scan and Stop Bluetooth Methods  ***** /////

  void scanForDevices() async {
    bluetoothInstance.scan().listen((scanResult) async {
      print(scanResult);
      // if (scanResult.device.name == "your_device_name") {
      //   print("found device");
      //   //Assigning bluetooth device
      //   device = scanResult.device;
      //   //After that we stop the scanning for device
      //
      //   stopScanning();
      // }
    });
  }

  void stopScanning() {
    bluetoothInstance.stopScan();
    // scanSubscription.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    stopScanning();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Bluetooth Demo"),
        ),
        body: Center(child: Text("Bluetooth Demo")),
      );
}
