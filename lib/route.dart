import 'package:flutter/cupertino.dart';
import 'package:printing_app/screens/BluetoothScannerScreen.dart';
import 'package:printing_app/screens/HomeScreen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (_) => HomeScreen(),
  BluetoothScannerScreen.routeName: (_) => BluetoothScannerScreen(),
};
