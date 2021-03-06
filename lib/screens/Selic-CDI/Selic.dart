import 'package:meu_app_flutter/utils/Constants.dart';
import 'package:meu_app_flutter/components/TextEditor.dart';
import 'package:meu_app_flutter/screens/Selic-CDI/SelicCDISimulate.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:meu_app_flutter/Utils/SharedPreferences.dart';

class SelicView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SelicViewState();
  }
}

class SelicViewState extends State<SelicView> {
  TextEditingController _controllerSelicValue;
  TextEditingController _controllerCDIValue;

  String taxaSelic = '';
  String porcentagemCDI = '';
  CalculaJuros _interest;
  var focusNodeSelic = FocusNode();
  var focusNodeCDI = FocusNode();

  @override
  void initState() {
    focusNodeSelic.addListener(() {
      print(focusNodeSelic.hasFocus);
      if (!focusNodeSelic.hasFocus) {
        this.definirValores();
      }
    });

    focusNodeCDI.addListener(() {
      print(focusNodeCDI.hasFocus);
      if (!focusNodeCDI.hasFocus) {
        this.definirValores();
      }
    });

    super.initState();

    taxaSelic = UserSimplePreferences.obterTaxaSelic() == null
        ? '5.25'
        : UserSimplePreferences.obterTaxaSelic().toString();
    porcentagemCDI = UserSimplePreferences.obterPorcentagemCDI() == null
        ? '100'
        : UserSimplePreferences.obterPorcentagemCDI().toString();

    _interest = CalculaJuros(
      double.tryParse(taxaSelic),
      double.tryParse(porcentagemCDI),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Constants.showDrawer(context),
      appBar: AppBar(
        title: Text(Constants.titleAppBarSelic),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            /*
            Esse decoration faz um desenho azul, com borda arredondada e
            cor gradient
            decoration: BoxDecoration(
              borderRadius: Constants.borderRadius,
              color: Color(0xff5a348b),
              gradient: LinearGradient(
                colors: [Color(0xff8d70fe), Color(0xff2da9ef)],
                begin: Alignment.centerRight,
                end: Alignment(-1.0, -1.0),
              ),
            ),*/
            child: Column(
              children: <Widget>[
                TextEditor(
                  label: Constants.labelSelic,
                  controller: _controllerSelicValue = TextEditingController(
                    text: this.taxaSelic,
                  ),
                  inputType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onFocusNode: focusNodeSelic,
                  //functionCompleteEditing: definirValores,
                ),
                TextEditor(
                  label: Constants.labelCDI,
                  controller: _controllerCDIValue = TextEditingController(
                    text: this.porcentagemCDI,
                  ),
                  inputType: TextInputType.number,
                  textAlign: TextAlign.center,
                  onFocusNode: focusNodeCDI,
                  //functionCompleteEditing: definirValores,
                ),
                _createDataTable(),
                ElevatedButton(
                  child: Text(Constants.textSimulateWithTheseParameters),
                  onPressed: () {
                    _interest = CalculaJuros(
                      double.tryParse(_controllerSelicValue.text),
                      double.tryParse(_controllerCDIValue.text),
                    );

                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return SelicCDISimulate(
                          _interest._jurosBruto,
                          _interest._jurosAte6Meses,
                          _interest._juros6Meses1Ano,
                          _interest._juros1Ano1Ano6Meses,
                          _interest._juros1Ano6Meses2Anos,
                        );
                      }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> definirValores() async {
    // Altera os valores que s??o exibidos nos campos
    this.taxaSelic = _controllerSelicValue.text;
    this.porcentagemCDI = _controllerCDIValue.text;

    await UserSimplePreferences.definirTaxaSelic(
        double.tryParse(this.taxaSelic));
    await UserSimplePreferences.definirPorcentagemCDI(
        double.tryParse(this.porcentagemCDI));

    _interest = CalculaJuros(
      double.tryParse(this.taxaSelic),
      double.tryParse(this.porcentagemCDI),
    );

    setState(() {});
  }

  Widget _createDataTable() {
    return DataTable(
      columns: <DataColumn>[
        DataColumn(
          label: Text(''),
        ),
        DataColumn(
          label: Text(''),
        ),
      ],
      rows: <DataRow>[
        DataRow(cells: <DataCell>[
          DataCell(
            Container(
              width: 185,
              child: myRowDataIcon(
                Icons.arrow_forward,
                _interest._rateSelic.toString() +
                    Constants.percentage +
                    Constants.textPerYear,
              ),
            ),
          ),
          DataCell(
            Container(
              width: 90,
              child: Text(
                _interest._jurosBruto.toStringAsPrecision(4) +
                    Constants.percentage +
                    Constants.textPerMonth,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(
            myRowDataIcon(
              Icons.arrow_forward,
              _interest._jurosAte6Meses.toStringAsPrecision(4) +
                  Constants.percentage +
                  Constants.textPerMonth,
            ),
          ),
          DataCell(
            Text(
              DateFormat(Constants.formatDate).format(
                DateTime.now(),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(
            myRowDataIcon(
              Icons.arrow_forward,
              _interest._juros6Meses1Ano.toStringAsPrecision(4) +
                  Constants.percentage +
                  Constants.textPerMonth,
            ),
          ),
          DataCell(
            Text(
              DateFormat(Constants.formatDate).format(
                DateTime.now().add(Duration(days: 181)),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(
            myRowDataIcon(
              Icons.arrow_forward,
              _interest._juros1Ano1Ano6Meses.toStringAsPrecision(4) +
                  Constants.percentage +
                  Constants.textPerMonth,
            ),
          ),
          DataCell(
            Text(
              DateFormat(Constants.formatDate).format(
                DateTime.now().add(Duration(days: 361)),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ]),
        DataRow(cells: <DataCell>[
          DataCell(
            myRowDataIcon(
              Icons.arrow_forward,
              _interest._juros1Ano6Meses2Anos.toStringAsPrecision(4) +
                  Constants.percentage +
                  Constants.textPerMonth,
            ),
          ),
          DataCell(
            Text(
              DateFormat(Constants.formatDate).format(
                DateTime.now().add(Duration(days: 721)),
              ),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ],
    );
  }
}

class CalculaJuros {
  double _rateSelic;
  double _rateCDI;
  double _jurosBruto;
  double _jurosAte6Meses;
  double _juros6Meses1Ano;
  double _juros1Ano1Ano6Meses;
  double _juros1Ano6Meses2Anos;

  CalculaJuros(double rateSelic, double rateCDI) {
    _rateSelic = rateSelic;
    _rateCDI = rateCDI;
    double rate = _rateSelic * _rateCDI / 100;
    _jurosBruto = rate / 12;
    _jurosAte6Meses =
        ((_jurosBruto / 100) - (_jurosBruto / 100) * 22.5 / 100) * 100;
    _juros6Meses1Ano =
        ((_jurosBruto / 100) - (_jurosBruto / 100) * 20.0 / 100) * 100;
    _juros1Ano1Ano6Meses =
        ((_jurosBruto / 100) - (_jurosBruto / 100) * 17.5 / 100) * 100;
    _juros1Ano6Meses2Anos =
        ((_jurosBruto / 100) - (_jurosBruto / 100) * 15.0 / 100) * 100;
  }
}

ListTile myRowDataIcon(IconData iconVal, String rowVal) {
  return ListTile(
    leading: Icon(iconVal, color: new Color(0xffffffff)),
    title: Text(
      rowVal,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  );
}
