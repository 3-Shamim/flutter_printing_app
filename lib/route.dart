import 'package:flutter/cupertino.dart';
import 'package:printing_app/screens/BlueToothPrintScreen.dart';
import 'package:printing_app/screens/BluetoothScannerScreen.dart';
import 'package:printing_app/screens/HomeScreen.dart';
import 'package:printing_app/screens/WifiPrintScreen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (_) => HomeScreen(),
  BlueToothPrintScreen.routeName: (_) => BlueToothPrintScreen(),
  WifiPrintScreen.routeName: (_) => WifiPrintScreen(),
  BluetoothScannerScreen.routeName: (_) => BluetoothScannerScreen(),
};
