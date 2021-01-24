import 'package:calc/screens/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class FirstRoute extends StatefulWidget {
  @override
  _FirstRouteState createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  // final price = TextEditingController();
  final price = MoneyMaskedTextController(
      leftSymbol: 'R\$ ', decimalSeparator: ',', thousandSeparator: '.');

  @override
  void dispose() {
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Valor do produto'),
        elevation: 0,
      ),
      body: Container(
        // color: Theme.of(context).backgroundColor,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: TextField(
                      controller: price,
                      autofocus: true,
                      decoration: const InputDecoration(
                          hintText: 'R\$ 0,00',
                          labelText: 'Quanto você deseja receber?'),
                      keyboardType: TextInputType.number,
                    )),
                Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        disabledColor: Colors.greenAccent,
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'CALCULAR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              Icon(Icons.arrow_forward, color: Colors.white)
                            ],
                          ),
                        ),
                        onPressed: () {
                          if (price.text.compareTo('R\$ 0,00') != 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SecondRoute(price: price.text)),
                            );
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Insira um preço"),
                                  );
                                });
                          }
                        }))
              ],
            )),
      ),
    );
  }
}
