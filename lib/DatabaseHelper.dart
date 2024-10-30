import 'package:sqflite/sqflite.dart';
import 'package:custoviagem/model/carros.dart';
import 'package:custoviagem/model/combustivel.dart';
import 'package:custoviagem/model/destinos.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'queroirembora.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
  await db.execute(
    'CREATE TABLE Carros ('
    'id INTEGER PRIMARY KEY AUTOINCREMENT, '
    'nomeCarro VARCHAR(255) NOT NULL, '
    'autonomia DOUBLE NOT NULL);'
  );

  await db.execute(
    'CREATE TABLE Combustivel ('
    'id INTEGER PRIMARY KEY AUTOINCREMENT, '
    'precoCombustivel DOUBLE NOT NULL, '
    'tipoCombustivel VARCHAR(100) NOT NULL, '
    'dataPreco VARCHAR(15) NOT NULL);'
  );

  await db.execute(
    'CREATE TABLE Destinos ('
    'id INTEGER PRIMARY KEY AUTOINCREMENT, '
    'nomeDestino VARCHAR(255) NOT NULL, '
    'distanciaDestino DOUBLE NOT NULL);'
  );

  await db.execute(
    'CREATE TABLE Calculo ('
    'id INTEGER PRIMARY KEY AUTOINCREMENT, '
    'carroEscolhido INT, '
    'destinoEscolhido INT, '
    'combustivelEscolhido INT, '
    'custoTotal DECIMAL(10, 2));'
  );
}

  Future<int> insertCarro(Carros carro) async {
  final db = await database;
  return await db.insert('Carros', carro.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}


  Future<void> updateCarro(Carros carro) async {
    final db = await database;
    await db.update('Carros', carro.toMap(), where: 'id = ?', whereArgs: [carro.id]);
  }

  Future<void> deleteCarro(Carros carro) async {
    final db = await database;
    await db.delete('Carros', where: 'id = ?', whereArgs: [carro.id]);
  }
  Future<List<Carros>> selectCarro() async{
    final db = await database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Carros');
    print("carregando carros:");
    return List.generate(tipoJSON.length, (i){
      return Carros.fromMap(tipoJSON[i]);
    });
  }
  Future<int> insertCombustivel(Combustivel combustivel) async {
  final db = await database;
   print("Inserindo combustível: ${combustivel.toMap()}");
  return await db.insert('Combustivel', combustivel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

  Future<void> updateCombustivel(Combustivel combustivel) async {
    final db = await database;
    await db.update('Combustivel', combustivel.toMap(), where: 'id = ?', whereArgs: [combustivel.id]);
  }

  Future<void> deleteCombustivel(Combustivel combustivel) async {
    final db = await database;
    await db.delete('Combustivel', where: 'id = ?', whereArgs: [combustivel.id]);
  }
  Future<List<Combustivel>> selectCombustivel() async{
    final db = await database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Combustivel');
    print("carregando combustivel:");
    return List.generate(tipoJSON.length, (i){
      return Combustivel.fromMap(tipoJSON[i]);
    });
  }
  Future<int> insertDestino(Destinos destinos) async {
    final db = await database;
    return await db.insert('Destinos', destinos.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateDestino(Destinos destinos) async {
    final db = await database;
    await db.update('Destinos', destinos.toMap(), where: 'id = ?', whereArgs: [destinos.id]);
  }

  Future<void> deleteDestino(Destinos destinos) async {
    final db = await database;
    await db.delete('Destinos', where: 'id = ?', whereArgs: [destinos.id]);
  }
  Future<List<Destinos>> selectDestino() async{
    final db = await database;
    final List<Map<String, dynamic>> tipoJSON = await db.query('Destinos');
    return List.generate(tipoJSON.length, (i){
      return Destinos.fromMap(tipoJSON[i]);
    });
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
