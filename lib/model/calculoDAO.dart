import 'package:custoviagem/DatabaseHelper.dart';
import 'package:custoviagem/model/calculo.dart';
import 'package:sqflite/sqflite.dart';

class PessoaDAO {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  Future<void> insertCalculo(Calculo calculo) async {
    final db = await _dbHelper.database;
    await db.insert('Calculo', calculo.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateCalculo(Calculo calculo) async {
    final db = await _dbHelper.database;
    await db.update('Calculo', calculo.toMap(), where: 'id = ?', whereArgs: [calculo.id]);
  }

  Future<void> deleteCalculo(Calculo calculo) async {
    final db = await _dbHelper.database;
    await db.delete('Calculo', where: 'id = ?', whereArgs: [calculo.id]);
  }
  Future<List<Calculo>> selectCalculo() async{
    final db = await _dbHelper.database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Calculo');
    return List.generate(tipoJSON.length, (i){
      return Calculo.fromMap(tipoJSON[i]);
    });
  }
}
