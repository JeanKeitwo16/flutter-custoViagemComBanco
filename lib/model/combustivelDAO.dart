import 'package:custoviagem/DatabaseHelper.dart';
import 'package:custoviagem/model/combustivel.dart';
import 'package:sqflite/sqflite.dart';

class PessoaDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<void> insertCombustivel(Combustivel combustivel) async {
    final db = await _dbHelper.database;
    await db.insert('Combustivel', combustivel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateCombustivel(Combustivel combustivel) async {
    final db = await _dbHelper.database;
    await db.update('Combustivel', combustivel.toMap(), where: 'id = ?', whereArgs: [combustivel.id]);
  }

  Future<void> deleteCombustivel(Combustivel combustivel) async {
    final db = await _dbHelper.database;
    await db.delete('Combustivel', where: 'id = ?', whereArgs: [combustivel.id]);
  }
  Future<List<Combustivel>> selectCombustivel() async{
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Combustivel');
    return List.generate(tipoJSON.length, (i){
      return Combustivel.fromMap(tipoJSON[i]);
    });
  }
}
