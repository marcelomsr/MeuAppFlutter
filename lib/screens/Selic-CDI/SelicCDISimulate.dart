import 'dart:math';

import 'package:One4All/components/MessageDialog.dart';
import 'package:One4All/Constants.dart';
import 'package:One4All/components/TextEditor.dart';
import 'package:flutter/material.dart';
import 'package:One4All/SharedPreferences.dart';

class SelicCDISimulate extends StatefulWidget {
  final double taxaSemImposto;
  final double taxaComImposto1;
  final double taxaComImposto2;
  final double taxaComImposto3;
  final double taxaComImposto4;

  SelicCDISimulate(this.taxaSemImposto, this.taxaComImposto1,
      this.taxaComImposto2, this.taxaComImposto3, this.taxaComImposto4);

  @override
  State<StatefulWidget> createState() => SelicCDISimulateState();
}

class SelicCDISimulateState extends State<SelicCDISimulate> {
  TextEditingController _controllerFieldStartValue;
  TextEditingController _controllerFieldNumberOfMonths;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.titleAppBarSelicCDISimulate),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextEditor(
              label: "Start Value",
              controller: _controllerFieldStartValue = TextEditingController(
                text: SharedPref.getInt("startValue")
                    .then((value) =>
                        _controllerFieldStartValue.text = value.toString())
                    .toString(),
              ),
            ),
            TextEditor(
              label: "Duration (months)",
              controller: _controllerFieldNumberOfMonths =
                  TextEditingController(
                text: SharedPref.getInt("durationMonths")
                    .then((value) =>
                        _controllerFieldNumberOfMonths.text = value.toString())
                    .toString(),
              ),
            ),
            ElevatedButton(
              child: Text(Constants.textSimulate),
              onPressed: () {
                double valorInicial =
                    double.tryParse(_controllerFieldStartValue.text);
                int numeroDeMeses =
                    int.tryParse(_controllerFieldNumberOfMonths.text);

                SharedPref.setInt("startValue", valorInicial.toInt());
                SharedPref.setInt("durationMonths", numeroDeMeses);

                double valorSemImposto = 1 + widget.taxaSemImposto / 100;

                double valorComImposto;

                if (numeroDeMeses <= 6)
                  valorComImposto = 1 + widget.taxaComImposto1 / 100;
                else if (numeroDeMeses > 6 && numeroDeMeses <= 12)
                  valorComImposto = 1 + widget.taxaComImposto2 / 100;
                else if (numeroDeMeses > 12 && numeroDeMeses <= 18)
                  valorComImposto = 1 + widget.taxaComImposto3 / 100;
                else if (numeroDeMeses > 18)
                  valorComImposto = 1 + widget.taxaComImposto4 / 100;

                double montanteSemImposto =
                    (valorInicial * pow(valorSemImposto, numeroDeMeses));
                String textMontanteSemImposto = "Montante sem imposto: " +
                    montanteSemImposto.toStringAsFixed(2);

                double montanteComImposto =
                    (valorInicial * pow(valorComImposto, numeroDeMeses));
                String textMontanteComImposto = "Montante com imposto: " +
                    montanteComImposto.toStringAsFixed(2);

                String textDiferenca = "Diferença: " +
                    (montanteSemImposto - montanteComImposto)
                        .toStringAsFixed(2);

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MessageDialog(
                      title: "Simulate Result",
                      //content: value.toString(),
                      content: textMontanteSemImposto +
                          '\r\n' +
                          textMontanteComImposto +
                          '\r\n' +
                          textDiferenca,
                      textCloseButton: Constants.close,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
