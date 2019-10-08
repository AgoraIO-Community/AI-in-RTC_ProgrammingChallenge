import 'package:climbing_app/frame/db/sqlite.dart';
import 'package:flutter/cupertino.dart';

class BaseModel {
  String toTableName() {
    Type type = this.runtimeType;
    String className = type.toString().toLowerCase();
    String prefix = "climbing_";
    String tableName = prefix + className;
    return tableName;
  }

  @override
  Map<String, Object> toMap() {
    return new Map();
  }

  /**  BEGIN 插入操作  */
  @protected
  Future<void> _insertSql(List<Map> models, bool replaced) async {
    String tableName = this.toTableName();
    Map columns = this.toMap();

    List<dynamic> args = new List();

    String sql = ((replaced == true) ? "REPLACE" : "INSERT");
    sql += " INTO " + tableName;

    sql += " (";
    for (String key in columns.keys) {
      sql += " `" + key + "`, ";
    }
    sql += "`createdAt`, ";
    sql += "`updatedAt`";
    sql += ") VALUES ";

    for (Map item in models) {
      sql += "(";
      int nowMillisecond = DateTime.now().millisecondsSinceEpoch;
      for (String key in columns.keys) {
        sql += " ?, ";
        args.add(item[key]);
      }
      if (item["createdAt"] != null) {
        sql += ("\"" + item["createdAt"] + "\", ");
      } else {
        sql += ("\"" + (nowMillisecond.toString()) + "\", ");
      }
      sql += ("\"" + (nowMillisecond.toString()) + "\"");
      sql += "),";
    }

    sql = sql.substring(0, sql.length - 1);

    await ClimbingSqliteHelper.executeSql(sql: sql, arguments: args);
  }

  Future<void> insertModel(Map map) async {
    await _insertSql([map], false);
  }

  Future<void> insertModels(List<Map> maps) async {
    await _insertSql(maps, false);
  }

  Future<void> replaceOrInsertModel(Map map) async {
    await _insertSql([map], true);
  }

  Future<void> replaceOrInsertModels(List<Map> maps) async {
    await _insertSql(maps, true);
  }

  /**  END 插入操作  */

  /** BEGIN 查询操作 */
  String querySql = "";
  List<String> queryCols = <String>[];
  List<dynamic> queryArgs = <dynamic>[];

  @protected
  void startQSql() {
    if (querySql.length <= 0) {
      String tableName = this.toTableName();
      querySql += "SELECT ";
      if (queryCols.length > 0) {
        for (String col in queryCols) {
          querySql += "`" + col + "`,";
        }
        querySql = querySql.substring(0, querySql.length - 1);
        querySql += " FROM ";
      } else {
        querySql += " * FROM ";
      }

      querySql += tableName + " ";
    }
  }

  @protected
  void whereQSql() {
    if (querySql.split("WHERE").length <= 1) {
      querySql += " WHERE ";
    }
  }

  BaseModel columns(List<String> cols) {
    queryCols = cols;
    return this;
  }

  BaseModel where(Map map) {
    startQSql();
    whereQSql();
    for (String key in map.keys) {
      querySql += " " + key + " = ? AND ";
      queryArgs.add(map[key]);
    }
    querySql = querySql.substring(0, (querySql.length - ("AND ").length));
    return this;
  }

  BaseModel limit({ int offset, int limit }) {
    startQSql();
    querySql += " LIMIT ?, ?";
    queryArgs.add(offset);
    queryArgs.add(limit);
    return this;
  }

  Future<List<Map>> queryList() async {
    startQSql();
    List<Map> a = await ClimbingSqliteHelper.querySql(
        sql: querySql, arguments: queryArgs);
    return a;
  }

  Future<Map> queryOne() async {
    limit(offset: 0, limit: 1);
    List<Map> items = await queryList();
    if (items.length <= 0)
    {
      return Future.value(null);
    }
    else
    {
      return items[0];
    }
  }
/** END 查询操作 */

}
