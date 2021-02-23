import 'dart:typed_data';
import 'package:flutter/material.dart' hide Image;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'dart:io' show Platform;
import 'package:image/image.dart';

class BluetoothPrintScreen extends StatefulWidget {

  static const routeName = "/bluetooth-print";

  @override
  _BluetoothPrintScreenState createState() => _BluetoothPrintScreenState();
}

class _BluetoothPrintScreenState extends State<BluetoothPrintScreen> {

  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  List<Map<String, dynamic>> _printAbleData = [];
  String _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      Map<String, dynamic> arguments =
          ModalRoute.of(context).settings.arguments;
      _printAbleData = arguments["data"];

      if (Platform.isAndroid) {
        bluetoothManager.state.listen((val) {
          print('state = $val');
          if (!mounted) return;
          if (val == 12) {
            print('on');
            initPrinter();
          } else if (val == 10) {
            print('off');
            setState(() => _devicesMsg = 'Bluetooth Disconnect!');
          }
        });
      } else {
        initPrinter();
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print'),
      ),
      body: _devices.isEmpty
          ? Center(child: Text(_devicesMsg ?? ''))
          : ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (c, i) {
          return ListTile(
            leading: Icon(Icons.print),
            title: Text(_devices[i].name),
            subtitle: Text(_devices[i].address),
            onTap: () {
              _startPrint(_devices[i]);
            },
          );
        },
      ),
    );
  }

  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen((val) {
      if (!mounted) return;
      setState(() => _devices = val);
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
  }

  Future<Ticket> testTicket() async {
    final Ticket ticket = Ticket(PaperSize.mm80);

    ticket.text(
        'Regular: aA bB cC dD eE fF gG hH iI jJ kK lL mM nN oO pP qQ rR sS tT uU vV wW xX yY zZ');
    ticket.text('Special 1: àÀ èÈ éÉ ûÛ üÜ çÇ ôÔ',
        styles: PosStyles(codeTable: PosCodeTable.westEur));
    ticket.text('Special 2: blåbærgrød',
        styles: PosStyles(codeTable: PosCodeTable.westEur));

    ticket.text('Bold text', styles: PosStyles(bold: true));
    ticket.text('Reverse text', styles: PosStyles(reverse: true));
    ticket.text('Underlined text',
        styles: PosStyles(underline: true), linesAfter: 1);
    ticket.text('Align left', styles: PosStyles(align: PosAlign.left));
    ticket.text('Align center', styles: PosStyles(align: PosAlign.center));
    ticket.text('Align right',
        styles: PosStyles(align: PosAlign.right), linesAfter: 1);

    ticket.text('Text size 200%',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));

    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);

    // var ticket = await _ticket(PaperSize.mm80);
    var ticket = await testTicket();

    print('===================> Start Printing');
    final result = await _printerManager.printTicket(ticket);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(result.msg),
      ),
    );
  }

  Future<Ticket> _ticket(PaperSize paper) async {
    final ticket = Ticket(paper);
    int total = 0;

    // Image assets
    // final ByteData data = await rootBundle.load('assets/images/rabbit_black.jpg');
    // final Uint8List bytes = data.buffer.asUint8List();
    // final Image image = decodeImage(bytes);
    // ticket.image(image);

    ticket.text(
      '4M Pharma LTD.',
      styles: PosStyles(align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2),
      linesAfter: 1,
    );

    for (var i = 0; i < _printAbleData.length; i++) {
      total += _printAbleData[i]['total_price'];
      ticket.text(_printAbleData[i]['title']);
      ticket.row([
        PosColumn(
            text: '${_printAbleData[i]['price']} x ${_printAbleData[i]['qty']}',
            width: 6),
        PosColumn(text: 'Price ${_printAbleData[i]['total_price']}', width: 6),
      ]);
    }

    ticket.feed(1);
    ticket.row([
      PosColumn(text: 'Total', width: 6, styles: PosStyles(bold: true)),
      PosColumn(text: 'Price $total', width: 6, styles: PosStyles(bold: true)),
    ]);
    ticket.feed(2);
    ticket.text('Thank You',styles: PosStyles(align: PosAlign.center, bold: true));
    ticket.cut();

    return ticket;
  }

  @override
  void dispose() {
    _printerManager.stopScan();
    super.dispose();
  }

}