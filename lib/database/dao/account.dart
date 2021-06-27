import 'package:meu_app_flutter/models/Account.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meu_app_flutter/database/app_database.dart';

class AccountDao {
  static const String tableSql = 'CREATE TABLE $_tableName( '
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_site TEXT, '
      '$_user TEXT, '
      '$_password TEXT, '
      '$_description TEXT)';

  static const String _tableName = 'accounts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _site = 'site';
  static const String _user = 'user';
  static const String _password = 'password';
  static const String _description = 'description';

  Future<int> save(Account account) async {
    final Database db = await getDatabase();
    Map<String, dynamic> accountMap = _toMap(account);
    return db.insert(_tableName, accountMap);
  }

  Map<String, dynamic> _toMap(Account account) {
    final Map<String, dynamic> accountMap = Map();
    accountMap[_id] = account.id;
    accountMap[_name] = account.name;
    accountMap[_site] = account.site;
    accountMap[_user] = account.user;
    accountMap[_password] = account.password;
    accountMap[_description] = account.description;
    return accountMap;
  }

  Future<List<Account>> findAll() async {
    final Database db = await getDatabase();
    List<Account> accounts = await _toList(db);
    return accounts;
  }

  Future<Account> findOne(int id) async {
    final Database db = await getDatabase();
    Account account = await _toAccount(db, id);
    return account;
  }

  Future<Account> _toAccount(Database db, int id) async {
    for (Map<String, dynamic> row
        in await db.query(_tableName, where: '"id" = ?', whereArgs: [id])) {
      final Account account = Account(
        row[_id],
        row[_name],
        row[_site],
        row[_user],
        row[_password],
        row[_description],
      );
      return account;
    }
    return null;
  }

  Future<List<Account>> _toList(Database db) async {
    final List<Account> accounts = [];

    for (Map<String, dynamic> row in await db.query(_tableName)) {
      final Account account = Account(
        row[_id],
        row[_name],
        row[_site],
        row[_user],
        row[_password],
        row[_description],
      );
      accounts.add(account);
    }
    return accounts;
  }

  Future<int> update(Account account) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> accountMap = _toMap(account);
    return db.update(
      _tableName,
      accountMap,
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
