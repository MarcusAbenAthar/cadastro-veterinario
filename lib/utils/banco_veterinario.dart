// ignore_for_file: avoid_print
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BancoVeterinario {
  static const tabela = 'animais_cadastrados';
  static const colunaCodigo = 'codigo';
  static const colunaNome = 'nome';
  static const colunaNomeDono = 'nomeDono';
  static const colunaTelefone = 'telefone';
  static const colunaFoto = 'foto';

  static Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    Database db = await openDatabase(
      join(dbPath, 'animais_cadastrados'),
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE IF NOT EXISTS $tabela($colunaCodigo INTEGER PRIMARY KEY UNIQUE,
            $colunaNome TEXT,
            $colunaNomeDono TEXT,
            $colunaTelefone TEXT,
            $colunaFoto TEXT)''');
      },
      version: 1,
    );
    return db;
  }

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>>? selectQueryResult,
      int? insertAndUpdateQueryResult,
      List<dynamic>? params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }
}
