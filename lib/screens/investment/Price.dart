import 'package:One4All/Constants.dart';
import 'package:flutter/material.dart';

class ListPrices extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListPricesState();
  }
}

class ListPricesState extends State<ListPrices> {
  List<String> employees;

  @override
  Widget build(BuildContext context) {
    /*
    employees.add('EGIE3');
    employees.add('JBSS3');
    employees.add('KLBN11');
    employees.add('LCAM3');
    employees.add('MGLU3');
    employees.add('NTCO3');
    employees.add('PETR4');
    employees.add('VVAR3');
    employees.add('WEGE3');
    employees.add('VIVT4');
    */

    return new Scaffold(
      drawer: Constants.showDrawer(context),
      appBar: AppBar(
        title: Text(Constants.titleAppBarPrice),
        actions: <Widget>[],
      ),
      //floatingActionButton: atualizar_lista,
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32.0),
            child: DataTable(
              sortColumnIndex: 2,
              sortAscending: true,
              columns: <DataColumn>[
                DataColumn(
                  label: Text('Name'),
                  numeric: false,
                ),
                DataColumn(
                  label: Text('%'),
                  numeric: false,
                ),
                DataColumn(
                  label: Text('R\$'),
                  numeric: true,
                ),
              ],
              rows: <DataRow>[
                DataRow(
                  selected: true,
                  cells: <DataCell>[
                    DataCell(Text('PETR4')),
                    DataCell(Text('0,2')),
                    DataCell(Text('24,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
                DataRow(
                  selected: false,
                  cells: <DataCell>[
                    DataCell(Text('KLBN11')),
                    DataCell(Text('0,3')),
                    DataCell(Text('14,50')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
    String url1 = 'https://app.tororadar.com.br/acoes/$employee/';
    String url2 = 'https://app.tororadar.com.br/empresa/$employee/';
    String value = '';

    read(url1).then((contents) {
      int startIndexValue = contents.indexOf('R\$') + 10;
      value = contents.substring(startIndexValue, startIndexValue + 20).trim();
      print('url1: R\$ ' + value);
    });

    read(url2).then((contents) {
      int startIndexValue = contents.indexOf('R\$ ');
      value = contents.substring(startIndexValue, startIndexValue + 20).trim();

      // Considera do início até o começo da tag
      value = value.substring(0, value.indexOf('<'));

      print('url2: ' + value);
    });
*/
