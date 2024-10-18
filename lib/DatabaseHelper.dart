import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
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
        'CREATE TABLE Carros (id INT PRIMARY KEY AUTO_INCREMENT,nomeCarro VARCHAR(255) NOT NULL,autonomia DOUBLE NOT NULL); CREATE TABLE Combustivel (id INT PRIMARY KEY AUTO_INCREMENT, precoCombustivel DECIMAL(10, 2) NOT NULL, tipoCombustivel VARCHAR(100) NOT NULL, dataPreco DATETIME NOT NULL);CREATE TABLE Destinos (id INT PRIMARY KEY AUTO_INCREMENT, nomeDestino VARCHAR(255) NOT ULL, distanciaDestino DOUBLE NOT NULL); CREATE TABLE Calculo (id INT PRIMARY KEY AUTO_INCREMENT, carroEscolhido INT, destinoEscolhido INT, combustivelEscolhido INT, custoTotal DECIMAL(10, 2));');
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
