import 'package:flutter/cupertino.dart';
import 'package:printing_app/screens/HomeScreen.dart';
import 'package:printing_app/screens/NetworkPrintScreen.dart';
import 'package:printing_app/screens/WifiPrintScreen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  HomeScreen.routeName: (_) => HomeScreen(),
  WifiPrintScreen.routeName: (_) => WifiPrintScreen(),
  NetworkPrintScreen.routeName: (_) => NetworkPrintScreen(),
};
