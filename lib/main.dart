import 'dart:ui';
import 'package:One4All/Constants.dart';
import 'package:One4All/database/dao/Account.dart';
import 'package:One4All/models/Account.dart';
import 'package:One4All/screens/Selic-CDI/Selic.dart';
//import 'package:One4All/screens/account/AccountList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Utils/SharedPreferences.dart';

// Criar o consumo da moto.
// Criar os valores dos rendimentos mensais com gráficos.
// Criar cotaçáo das ações.
// Criar notificações.
// Criar JI e exibir as notificações.
// Alterar o nome do aplicativo para MeuAppFlutter e o nome dos packages para meu_app_flutter.
// Simulador e registrador de empréstimos.
// Seleção de idiomas
// Registro de peso

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserSimplePreferences.init();

  runApp(One4AllApp());

  AccountDao().findAll().then((accounts) {
    //print(accounts.length);
    if (accounts.length <= 0) {
      _insertDefaultContent();
    }
  });
}

void _insertDefaultContent() {
  AccountDao().save(Account(null, 'GitHub', 'www.github.com', 'gituser',
      'gitpass', 'Account for my repositories'));
  AccountDao().save(Account(null, 'Google', '', 'googleuser@gmail.com',
      'googlepass', 'Account for google services'));
  AccountDao().save(Account(null, 'Microsoft', '', 'microsoftuser@outlook.com',
      'microsoftpass', 'Account for microsoft services'));
}

class One4AllApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Constants.colorApp,
        accentColor: Constants.colorApp,
        buttonTheme: ButtonThemeData(
          buttonColor: Constants.colorApp,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: SelicView(),
    );
  }
}
