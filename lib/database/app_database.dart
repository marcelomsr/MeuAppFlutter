import 'package:meu_app_flutter/database/dao/Account.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'accounts.db');

  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(AccountDao.tableSql);
    },
    version: 2,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
