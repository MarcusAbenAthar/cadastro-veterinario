import 'package:cadastro_veterinario/model/animal_model.dart';
import 'package:cadastro_veterinario/utils/banco_veterinario.dart';
import 'package:sqflite/sqflite.dart';

class AnimalRepository {
  static Future<List<Animal>> getAllData() async {
    final db = await BancoVeterinario.initDatabase();
    final List<Map<String, dynamic>> data =
        await db.query('animais_cadastrados');
    // print(data);
    return data.map((e) => Animal.fromJson(e)).toList();
  }

  static Future<Animal> getAnimal(String codigo) async {
    final db = await BancoVeterinario.initDatabase();
    const sql =
        'SELECT * FROM ${BancoVeterinario.tabela} WHERE ${BancoVeterinario.colunaCodigo} = ?';
    final data = await db.rawQuery(sql, [codigo]);
    final animal = Animal.fromJson(data[0]);
    return animal;
  }

  static Future<void> addAnimal(Animal animal) async {
    final db = await BancoVeterinario.initDatabase();
    const tabela = BancoVeterinario.tabela;
    final resultado = await db.insert(tabela, animal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    BancoVeterinario.databaseLog('addAnimal', tabela, null, resultado);
  }

  static Future<void> deleteAnimal(Animal animal) async {
    final sql =
        '''DELETE FROM ${BancoVeterinario.tabela} WHERE ${BancoVeterinario.colunaCodigo} = ${animal.codigo}''';
    final db = await BancoVeterinario.initDatabase();
    final resultado = await db.rawDelete(sql);
    BancoVeterinario.databaseLog('deleteAnimal', sql, null, resultado);
  }

  static Future<void> updateAnimal(Animal animal) async {
    final db = await BancoVeterinario.initDatabase();
    const tabela = BancoVeterinario.tabela;

    final resultado = await db.update(tabela, animal.toMap(),
        where: '${BancoVeterinario.colunaCodigo} = ?',
        whereArgs: [animal.codigo]);
    BancoVeterinario.databaseLog('updateAnimal', tabela, null, resultado);
  }

  static Future<int?> animalCount() async {
    final db = await BancoVeterinario.initDatabase();
    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM ${BancoVeterinario.tabela}'));
    return count;
  }
}
