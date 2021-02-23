import 'package:flutter/material.dart';
import 'package:printing_app/screens/NetworkPrintScreen.dart';
import 'package:printing_app/screens/WifiPrintScreen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/";

  /// Example Data
  final List<Map<String, dynamic>> data = [
    {
      'title': 'Product 1',
      'price': 10000,
      'qty': 2,
      'total_price': 20000,
    },
    {
      'title': 'Product 2',
      'price': 20000,
      'qty': 2,
      'total_price': 40000,
    },
    {
      'title': 'Product 3',
      'price': 12000,
      'qty': 1,
      'total_price': 12000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    int _total = 0;

    for (var i = 0; i < data.length; i++) {
      _total += data[i]['total_price'];
    }

    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (c, i) {
                return ListTile(
                  title: Text(data[i]['title']),
                  subtitle:
                      Text('Price ${data[i]['price']} x ${data[i]['qty']}'),
                  trailing: Text('Price ${data[i]['total_price']}'),
                );
              },
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(15),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Total :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Price $_total :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Row(
                    children: [
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text('W-Print'),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, WifiPrintScreen.routeName,
                              arguments: {
                                "data": data,
                              });
                        },
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      FlatButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        child: Text('N-Print'),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, NetworkPrintScreen.routeName,
                              arguments: {
                                "data": data,
                              });
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
