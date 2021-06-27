import 'package:meu_app_flutter/components/MessageDialog.dart';
import 'package:meu_app_flutter/screens/selic-CDI/Selic.dart';
import 'package:meu_app_flutter/screens/account/AccountList.dart';
import 'package:meu_app_flutter/screens/investment/Price.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Constants {
  static const titleAppBarAccounts = 'Accounts';
  static const textNoNameAccounts = 'Ah';
  static const passwordCopied = 'Password copied.';
  static const unknownError = 'unknown error.';
  static const undo = 'Undo';
  static const loading = 'Loading..';
  static const titleAppBarCreateAccount = 'Create Account';
  static const titleAppBarEditAccount = 'Edit Account';
  static const tipFieldNameCreateAccount = 'Name of account';
  static const tipFieldSiteCreateAccount = 'Site';
  static const tipFieldUserCreateAccount = 'User';
  static const tipFieldPasswordCreateAccount = 'Password';
  static const tipFieldDescriptionCreateAccount = 'Description';
  static const textSaveButton = 'Save';
  static const titleAppBarSelic = 'Rate Selic/CDI';
  static const formatDate = 'dd/MM/yyyy';
  static const percentage = '%';
  static const about = 'About';
  static const close = 'Close';
  static const search = 'Search..';
  static const drawerHeader = 'Drawer Header';
  static const titleAppBarPrice = 'Price';
  static const labelSelic = "SELIC %";
  static const labelCDI = "CDI %";
  static const textPerYear = " a.a.";
  static const textPerMonth = " a.m.";
  static const textSimulateWithTheseParameters =
      "Simulate with these paramenters";
  static const titleAppBarSelicCDISimulate = "Simulate Selic/CDI";
  static const textSimulate = "Simulate";

  static Color colorApp = Colors.blue.shade500;
  static BorderRadius borderRadius = BorderRadius.circular(20.0);

  static Widget showDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(Constants.drawerHeader),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text(Constants.titleAppBarAccounts),
            onTap: () {
              _goTo(context, AccountList());
            },
          ),
          ListTile(
            title: Text(Constants.titleAppBarSelic),
            onTap: () {
              _goTo(context, SelicView());
            },
          ),
          ListTile(
            title: Text(Constants.titleAppBarPrice),
            onTap: () {
              _goTo(context, ListPrices());
            },
          ),
          ListTile(
            title: Text(Constants.about),
            onTap: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MessageDialog(
                    title: Constants.about,
                    content: packageInfo.version,
                    textCloseButton: Constants.close,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  static void _goTo(BuildContext context, var destiny) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return destiny;
        },
      ),
    );
  }
}
