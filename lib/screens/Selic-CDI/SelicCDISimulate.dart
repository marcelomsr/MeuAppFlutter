import 'dart:math';

import 'package:meu_app_flutter/components/MessageDialog.dart';
import 'package:meu_app_flutter/utils/Constants.dart';
import 'package:meu_app_flutter/components/TextEditor.dart';
import 'package:flutter/material.dart';
import 'package:meu_app_flutter/Utils/SharedPreferences.dart';

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

  int valorTotal;
  int quantidadeDeMeses;

  @override
  void initState() {
    super.initState();

    valorTotal = UserSimplePreferences.obterValorTotal() ?? 1000;
    quantidadeDeMeses = UserSimplePreferences.obterQuantidadeDeMeses() ?? 3;
  }

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
              label: "Valor inicial",
              controller: _controllerFieldStartValue = TextEditingController(
                text: this.valorTotal.toString(),
              ),
            ),
            TextEditor(
              label: "Duração (meses)",
              controller: _controllerFieldNumberOfMonths =
                  TextEditingController(
                text: this.quantidadeDeMeses.toString(),
              ),
            ),
            ElevatedButton(
              child: Text(Constants.textSimulate),
              onPressed: () async {
                // Altera o valor que é exibido no campo
                this.valorTotal = int.tryParse(_controllerFieldStartValue.text);
                this.quantidadeDeMeses =
                    int.tryParse(_controllerFieldNumberOfMonths.text);

                await UserSimplePreferences.definirValorTotal(
                    int.tryParse(_controllerFieldStartValue.text));
                await UserSimplePreferences.definirQuantidadeDeMeses(
                    int.tryParse(_controllerFieldNumberOfMonths.text));

                double valorInicial =
                    double.tryParse(_controllerFieldStartValue.text);
                int numeroDeMeses =
                    int.tryParse(_controllerFieldNumberOfMonths.text);

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

                setState(() {});

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
