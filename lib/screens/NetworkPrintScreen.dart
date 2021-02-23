import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';

class NetworkPrintScreen extends StatelessWidget {
  static const routeName = "/network-print";

  void testReceipt(NetworkPrinter printer) {
    printer.text("Test");
    printer.feed(2);
    printer.cut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network Print"),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () async {
              print('Pressed');

              const PaperSize paper = PaperSize.mm80;
              final profile = await CapabilityProfile.load();
              final printer = NetworkPrinter(paper, profile);

              final PosPrintResult res = await printer.connect('192.168.0.110', port: 9100);

              if (res == PosPrintResult.success) {
                testReceipt(printer);
                printer.disconnect();
              }

              print('Print result: ${res.msg}');

            },
            child: Text("Network Print"),
          ),
        ),
      ),
    );
  }
}
