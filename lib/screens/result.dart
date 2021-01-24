import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:toast/toast.dart';

class SecondRoute extends StatelessWidget {
  final String price;

  SecondRoute({Key key, @required this.price}) : super(key: key);

  final List<double> factors = [
    0.0474,
    0.0719,
    0.0810,
    0.0885,
    0.0970,
    0.1055,
    0.1138,
    0.1223,
    0.1309,
    0.1396,
    0.1482,
    0.1570
  ];

  List<String> simulation() {
    FlutterMoneyFormatter fmf = new FlutterMoneyFormatter(
        amount: 0,
        settings: MoneyFormatterSettings(
            symbol: 'R\$',
            thousandSeparator: '.',
            decimalSeparator: ',',
            symbolAndNumberSeparator: ' '));

    final getInstallmentWithFee = factors.asMap().entries.map((factor) {
      int onlyNumbers = int.parse(price.replaceAll(RegExp("\\D"), ''));
      double priceNumber = onlyNumbers / 100;
      int installmentNumber = factor.key + 1;
      double totalWithFee = factors[factor.key] * priceNumber + priceNumber;
      double installmentWithFee = totalWithFee / installmentNumber;

      return installmentNumber.toString() +
          'x de ' +
          fmf.copyWith(amount: installmentWithFee).output.symbolOnLeft;
    });

    return getInstallmentWithFee.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$price"),
        elevation: 0,
      ),
      body: ListView(
          children: simulation()
              .asMap()
              .entries
              .map((e) => ListTile(title: Text(e.value)))
              .toList()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: simulation().join('\n')));
          Toast.show("Copiado com sucesso", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        },
        child: Icon(
          Icons.content_copy,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
