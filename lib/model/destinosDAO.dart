import 'package:custoviagem/DatabaseHelper.dart';
import 'package:custoviagem/model/destinos.dart';
import 'package:sqflite/sqflite.dart';

class PessoaDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<void> insertDestino(Destinos destinos) async {
    final db = await _dbHelper.database;
    await db.insert('Destinos', destinos.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateDestino(Destinos destinos) async {
    final db = await _dbHelper.database;
    await db.update('Destinos', destinos.toMap(), where: 'id = ?', whereArgs: [destinos.id]);
  }

  Future<void> deleteDestino(Destinos destinos) async {
    final db = await _dbHelper.database;
    await db.delete('Destinos', where: 'id = ?', whereArgs: [destinos.id]);
  }
  Future<List<Destinos>> selectDestino() async{
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Destinos');
    return List.generate(tipoJSON.length, (i){
      return Destinos.fromMap(tipoJSON[i]);
    });
  }
}
