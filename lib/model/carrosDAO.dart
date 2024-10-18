import 'package:custoviagem/DatabaseHelper.dart';
import 'package:custoviagem/model/carros.dart';
import 'package:sqflite/sqflite.dart';

class PessoaDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<void> insertCarro(Carros carro) async {
    final db = await _dbHelper.database;
    await db.insert('Carros', carro.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateCarro(Carros carro) async {
    final db = await _dbHelper.database;
    await db.update('Carros', carro.toMap(), where: 'id = ?', whereArgs: [carro.id]);
  }

  Future<void> deleteCarro(Carros carro) async {
    final db = await _dbHelper.database;
    await db.delete('Carros', where: 'id = ?', whereArgs: [carro.id]);
  }
  Future<List<Carros>> selectCarro() async{
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Carros');
    return List.generate(tipoJSON.length, (i){
      return Carros.fromMap(tipoJSON[i]);
    });
  }
}
