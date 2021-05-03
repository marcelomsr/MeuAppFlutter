import 'package:One4All/database/dao/Account.dart';
import 'package:One4All/models/Account.dart';
import 'package:One4All/screens/account/AccountItem.dart';
import 'package:One4All/screens/account/Form.dart';
import 'package:One4All/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';

class AccountList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AccountListState();
  }
}

class AccountListState extends State<AccountList> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid;
  var initializationSettingsiOS;
  var initializationSettings;

  void _showNotification() async {
    await _demoNotification();
  }

  Future<void> _demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel Id', 'channel Name', 'channel Description',
        importance: Importance.Max,
        priority: Priority.Max,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Hello, buddy',
        'A message from flutter buddy', platformChannelSpecifics,
        payload: 'test payload');
  }

  @override
  void initState() {
    super.initState();

    initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/launcher_icon');

    initializationSettingsiOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsiOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new AccountList()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('OK'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountList()));
            },
          ),
        ],
      ),
    );
  }

  final AccountDao _dao = AccountDao();

  final TextEditingController _filter = new TextEditingController();
  String _searchText = '';

  Widget appBarTitle = new Text(
    Constants.titleAppBarAccounts,
  );

  Icon _actionIcon = new Icon(
    Icons.search,
  );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: Constants.showDrawer(context),
      appBar: _buildAppBar(context),
      body: FutureBuilder<List<Account>>(
        initialData: [],
        future: _dao.findAll(),
        builder: (contexto, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return _buildLoading();
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Account> accounts = snapshot.data
                  .where(
                      (food) => food.name.toLowerCase().contains(_searchText))
                  .toList();
              accounts.sort(
                (a, b) {
                  return a.name.toLowerCase().compareTo(b.name.toLowerCase());
                },
              );
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Account account = accounts[index];
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: Key(account.id.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        _dao.delete(account.id);
                        snapshot.data.remove(account);
                      });
                      var accountNameDeleted = account.name;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '$accountNameDeleted deleted.',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.grey.shade900,
                          action: SnackBarAction(
                            label: Constants.undo,
                            textColor: Constants.colorApp,
                            onPressed: () {
                              _dao.save(account);
                              setState(() {
                                accounts.add(account);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red.shade400,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: AccountItem(account),
                  );
                },
                itemCount: accounts.length,
              );
              break;
          }
          return Text(Constants.unknownError);
        },
      ),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: appBarTitle,
      actions: <Widget>[
        new IconButton(
          icon: _actionIcon,
          onPressed: () {
            _pressedSearchIcon();
          },
        ),
      ],
    );
  }

  void _pressedSearchIcon() {
    setState(() {
      if (this._actionIcon.icon == Icons.search) {
        this._actionIcon = new Icon(
          Icons.close,
          color: Colors.white,
        );
        this.appBarTitle = new TextField(
          controller: _filter,
          autofocus: true,
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: Colors.white),
            hintText: Constants.search,
            //hintStyle: new TextStyle(color: Colors.white),
          ),
          onChanged: (String text) {
            _handleSearchStart();
          },
        );
      } else {
        _handleSearchEnd();
      }
    });
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _showNotification();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return AccountForm(null);
          }),
        );
      },
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(Constants.loading),
        ],
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _searchText = _filter.text.toLowerCase();
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this._actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );

      this.appBarTitle = new Text(
        Constants.titleAppBarAccounts,
        style: new TextStyle(color: Colors.white),
      );

      _filter.clear();
      _searchText = '';
    });
  }
}
