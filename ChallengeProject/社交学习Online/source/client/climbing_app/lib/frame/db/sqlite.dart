import 'dart:async';
import 'package:climbing_app/frame/db/models/base_model.dart';
import 'package:climbing_app/frame/db/models/contact.dart';
import 'package:climbing_app/frame/db/models/keyvalue.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

class ClimbingSqliteHelper {
  @protected
  static Future<String> _dbPath() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "/climbing_local.db";
    return path;
  }

  // 私有方法调用数据库
  @protected
  static Future<Database> _db_fn(Function(Database db) callback) async {
    String path = await _dbPath();
    return openDatabase(path, version: 1, singleInstance: false,
        onOpen: (Database db) async {
      if (callback == null) {
        return;
      }
      await callback(db);
      await db.close();
    });
  }

  static Future<void> executeSql({String sql, List<dynamic> arguments}) async {
    Database db = await _db_fn(null);
    return db.execute(sql, arguments);
  }

  static Future<List<Map<String, dynamic>>> querySql({String sql, List<dynamic> arguments}) async {
    Database db = await _db_fn(null);
    return db.rawQuery(sql, arguments);
  }

  // 创建数据库表
  static void createTables() {
    print("start createTables ... ");
    _db_fn((Database db) {
      registerClass(ContactModel(), db);
      registerClass(KeyValueModel(), db);
    });
  }

  static Future<void> registerClass(BaseModel baseModel, Database db) async {
    String tableName = baseModel.toTableName();
    Map columns = baseModel.toMap();
    if (columns.length <= 0) {
      return;
    }
    String sql = "CREATE TABLE IF NOT EXISTS `" + tableName + "` (";
    sql += "`id`  INTEGER  Primary Key AUTOINCREMENT, ";
    for (String key in columns.keys) {
      Map attribute = columns[key];
      String type = (attribute["type"] != null) ? attribute["type"] : "";
      String attr = (attribute["attr"] != null) ? attribute["attr"] : "";
      if (type.length <= 0) {
        continue;
      }

      // 创建列结构
      sql += '`' + key + '` ' + type + " " + attr + ", ";
    }
    // 增加最后修改时间和数据添加时间
    sql += "`createdAt`  DATE  Not NULL, ";
    sql += "`updatedAt`  DATE  Not NULL ";
    sql += ")";
    await db.execute(sql);
  }
}
