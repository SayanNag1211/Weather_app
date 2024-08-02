import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WeatherDatabaseHelper {
  static final WeatherDatabaseHelper _instance = WeatherDatabaseHelper._internal();
  factory WeatherDatabaseHelper() => _instance;
  WeatherDatabaseHelper._internal();

  static Database? _database;

  
  Future<Database> _getDatabase(String dbName) async {
    if (_database != null) return _database!;
    String path = join(await getDatabasesPath(), dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE weather (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        response TEXT
      )
    ''');
  }

  Future<void> insertWeather(String dbName, String response) async {
    final Database db = await _getDatabase(dbName);
    await db.insert(
      'weather', 
      {'response': response},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getWeatherResponse(String dbName) async {
    final Database db = await _getDatabase(dbName);
    final List<Map<String, dynamic>> maps = await db.query('weather');
    if (maps.isNotEmpty) {
      return maps.first['response'] as String?;
    }
    return null;
  }
  Future<bool> doesDatabaseExist(String dbName) async {
    String path = join(await getDatabasesPath(), dbName);
    return databaseFactory.databaseExists(path);
  }
}
