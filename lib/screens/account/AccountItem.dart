import 'package:One4All/Constants.dart';
import 'package:One4All/models/Account.dart';
import 'package:One4All/screens/account/Form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AccountItem extends StatelessWidget {
  final Account _account;

  AccountItem(this._account);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Text(_account.name.toString()),
        subtitle: Text(_account.user.toString()),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade500,
          child: Text(
            _account.name.length >= 2
                ? _account.name.toString().substring(0, 2)
                : Constants.textNoNameAccounts,
            style: TextStyle(color: Colors.white),
          ),
        ),
        onLongPress: () {
          Clipboard.setData(
            new ClipboardData(
              text: _account.password,
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                Constants.passwordCopied,
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.grey.shade900,
            ),
          );
        },
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AccountForm(_account);
              },
            ),
          );
        },
        trailing: new Column(
          children: <Widget>[
            new Container(
              child: new IconButton(
                icon: new Icon(Icons.menu),
                onPressed: () {
                  print('Icon button pressed.');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
