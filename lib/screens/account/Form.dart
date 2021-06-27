import 'package:meu_app_flutter/Constants.dart';
import 'package:meu_app_flutter/components/TextEditor.dart';
import 'package:meu_app_flutter/database/dao/Account.dart';
import 'package:meu_app_flutter/models/Account.dart';
import 'package:flutter/material.dart';

class AccountForm extends StatefulWidget {
  final Account account;

  AccountForm(this.account);

  @override
  State<StatefulWidget> createState() => AccountFormState();
}

class AccountFormState extends State<AccountForm> {
  TextEditingController _controllerFieldName;
  TextEditingController _controllerFieldSite;
  TextEditingController _controllerFieldUser;
  TextEditingController _controllerFieldPassword;
  TextEditingController _controllerFieldDescription;

  final AccountDao _dao = AccountDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.account != null
            ? Text(Constants.titleAppBarEditAccount)
            : Text(Constants.titleAppBarCreateAccount),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextEditor(
              controller: _controllerFieldName = TextEditingController(
                text: widget.account != null ? widget.account.name : '',
              ),
              tip: Constants.tipFieldNameCreateAccount,
              icon: Icons.description,
            ),
            TextEditor(
              controller: _controllerFieldSite = TextEditingController(
                text: widget.account != null ? widget.account.site : '',
              ),
              tip: Constants.tipFieldSiteCreateAccount,
              icon: Icons.cloud_done,
            ),
            TextEditor(
              controller: _controllerFieldUser = TextEditingController(
                text: widget.account != null ? widget.account.user : '',
              ),
              tip: Constants.tipFieldUserCreateAccount,
              icon: Icons.person,
            ),
            TextEditor(
              controller: _controllerFieldPassword = TextEditingController(
                text: widget.account != null ? widget.account.password : '',
              ),
              tip: Constants.tipFieldPasswordCreateAccount,
              password: true,
              icon: Icons.lock,
            ),
            TextEditor(
              controller: _controllerFieldDescription = TextEditingController(
                text: widget.account != null ? widget.account.description : '',
              ),
              tip: Constants.tipFieldDescriptionCreateAccount,
              maxLines: 5,
              inputType: TextInputType.multiline,
              icon: Icons.chat,
            ),
            ElevatedButton(
              child: Text(Constants.textSaveButton),
              onPressed: () {
                _saveAccount(context, widget.account);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveAccount(BuildContext context, Account account) {
    final String name = _controllerFieldName.text;
    final String site = _controllerFieldSite.text;
    final String user = _controllerFieldUser.text;
    final String password = _controllerFieldPassword.text;
    final String description = _controllerFieldDescription.text;

    if (name != null && user != null && password != null) {
      final int id = (account != null ? account.id : null);
      final accountSaved = Account(id, name, site, user, password, description);

      Future<int> future;

      if (accountSaved.id != null)
        future = _dao.update(accountSaved);
      else
        future = _dao.save(accountSaved);

      future.then((id) => Navigator.pop(context, accountSaved));
    }
  }
}
