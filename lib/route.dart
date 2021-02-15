import 'package:flutter/cupertino.dart';
import 'package:printing_app/screens/BluetoothPrintScreen.dart';
import 'package:printing_app/screens/HomeScreen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (_) => HomeScreen(),
  BluetoothPrintScreen.routeName: (_) => BluetoothPrintScreen(),
};
