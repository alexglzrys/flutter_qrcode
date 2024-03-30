import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// Provider referente a la gestión y almacenamiento de información en la base de datos SQLite
class DBProvider {
  // La instancia de la base de datos
  static Database? _database;
  // Unica instancia de la clase DBProvider (Patrón Singletón)
  static final DBProvider db = DBProvider._();

  // Constructor privado
  // Se alinea con el próposito patrón singletón para que no se puedan generar multiples instancias desde fuera de la clase (solo se puede crear una y solo una dentro de la propia clase)
  DBProvider._();

  // Getter para recuperar la instancia de la base de datos (singleton, solo existe una única conexión en toda la aplicación)
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    // Si la base de datos no esta inicializada, se crea una instancia de la misma
    _database = await _initDB();
    return _database!;
  }

  // Método privado para inicializar la base de datos
  Future<Database> _initDB() async {
    // Obtener el directorio de documentos de la aplicación, donde almacenaremos la base de datos
    // Como la DB es un archivo físico es importante el uso del paquete "path_provider", ya que proporciona soporte robusto para obtener rutas de directorios especificos de la plataforma (Android, iOS, Linux, windows, Linux) donde se ejecute la aplicación
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ScanQR.db');
    print('[Path DB] $path');

    // Abrir la base de datos (si no existe, automáticamente se crea)
    // Para cualquier modificación posterior en la base de datos, es necesario incrementar la versión (control de versionamiento). Ya que de lo contrario si encuentra la misma versión (instalada en el dspositivo), los cambios no surtirán efecto
    return await openDatabase(path, version: 1, onOpen: (db) async {
      print('Base de datos ScanQR [abierta]');
    }, onCreate: (db, version) async {
      // Crear la estructura de la base de datos (Tablas y relaciones)
      await db.execute('''
      CREATE TABLE scans (
        id INTEGER PRIMARY KEY,
        type TEXT,
        value TEXT
      );
      ''');
    });
  }
}
