import 'dart:ffi';
import 'dart:io';

import 'package:flutter_hoo/db/use.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider _singleton = DBProvider._internal();

  factory DBProvider() => _singleton;

  static DBProvider getInstance() => _singleton;

  static Future<DBProvider> getInstanceAndInit() async {
    _db = await _singleton._initDB();
    return _singleton;
  }

  DBProvider._internal();

  static Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await _initDB();
    return _db;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'dbHoo');
    return await openDatabase(path, onCreate: _onCreate,version: 1);
  }

  // 创建表
  Future _onCreate(Database db, int version) async {
    db.execute(
        "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY autoincrement, account TEXT, pwd TEXT, name TEXT, headImage Text);");
    db.execute(
        "CREATE TABLE IF NOT EXISTS shoe(id INTEGER PRIMARY KEY autoincrement, name TEXT, description TEXT, price REAL, brand Text, imageUrl Text);");
    db.execute(
        "CREATE TABLE IF NOT EXISTS fav_shoe(id INTEGER PRIMARY KEY autoincrement, show_id INTEGER, user_id INTEGER, date INTEGER , FOREIGN KEY(user_id) REFERENCES user(id), FOREIGN KEY(show_id) REFERENCES shoe(id));");
    return;
  }

  // ##### User表

  // 新增用户
  Future<Void> insertUser(User user) async {
    var _db = await db;
    await _db.insert("user", user.toMap(),conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<User> searchUserByNameAndPwd(String account, String pwd) async {
    var _db = await db;
    List<Map<String, dynamic>> result = await _db.query("user",where: 'name = ? and pwd = ?', whereArgs: [account,pwd]);
    //List<Map<String, dynamic>> result = await _db.query("user");
    List<User> users = result.isNotEmpty ? result.map((e) => User.fromJson(e)).toList() : [];
    if(users.length != 0)
      return users[0];
    return null;
  }

}
