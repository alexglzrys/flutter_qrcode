import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_code_flutter_app/models/scan_model.dart';
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

  // Método para insertar un nuevo scan en base de datos
  Future<int> insertNewScan(ScanModel scan) async {
    // Obtener la referencia a la base de datos
    final db = await database;
    // Insertar un nuevo registro en la tabla scans
    final response = await db.insert('scans', scan.toJson());
    // La respuesta se corresponde con el id asignado al registro en la base de datos
    print('Registro: ID $response');
    return response;
  }

  // Método para recuperar todos los registros scan almacenados en la base de datos
  Future<List<ScanModel>> getAllScans() async {
    // Obtener la referencia a la base de datos
    final db = await database;
    // Recupearar todos los registros almacenados en la tabla scans
    final response = await db.query('scans');

    print(response);
    // Verificar el resultado de la respuesta
    // Si no hay datos, retornamos una lista vacia
    // Si hay registros, retornamos una lista con objetos de tipo ScanModel (cada objeto se corresponde con un registro recuperado de la BD)
    return response.isNotEmpty
        ? response.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  // Método para recuperar los registros scan almacenados en la base de datos que coincidan con el id pasado como parámetro
  Future<List<ScanModel>> getScanById(int id) async {
    // Obtener la referencia a la base de datos
    final db = await database;
    // Recupearar todos los registros almacenados en la tabla scans cuyo id sea igual al valor pasado como parametro en el método
    final response = await db.query('scans', where: 'id = ?', whereArgs: [id]);
    // Verificar el resultado de la respuesta
    // Si no hay datos, retornamos una lista vacia
    // Si hay registros, retornamos una lista con objetos de tipo ScanModel (cada objeto se corresponde con un registro recuperado de la BD)
    return response.isNotEmpty
        ? response.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  // Método para recuperar todos los registros por un tipo especificado (http o geo)
  Future<List<ScanModel>> getScansByType(String type) async {
    // Obtener la referencia a la base de datos
    final db = await database;
    // Recuperar todos los registros cuyo tipo sea el mismo que se pasa como parámetro
    final response =
        await db.query('scans', where: 'type = ?', whereArgs: [type]);
    // Verificar el resultado de la respuesta
    // Si no hay datos, retornamos una lista vacia
    // Si hay registros, retornamos una lista con objetos de tipo ScanModel (cada objeto se corresponde con un registro recuperado de la BD)
    return response.isNotEmpty
        ? response.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  // Método para actualizar un registro en la base de datos
  Future<int> updateScan(ScanModel scan) async {
    // Obtener la referencia a la base de datos
    final db = await database;
    // Actalizar un registro por su id
    final response = await db
        .update('scans', scan.toJson(), where: 'id = ?', whereArgs: [scan.id]);
    // Retona la cantidad de registros modificados en la BD
    return response;
  }

  // Método para eliminar todos los registros de una tabla en la base de datos
  Future<int> deleteAll() async {
    // Obtener la referencia a la base de datos
    final db = await database;
    // Eliminar todos los registros de la tabla especificada
    final response = await db.delete('scans');
    // Retorna la cantidada de registros eliminados
    return response;
  }

  // Método para eliminar un registro por su id
  Future<int> deleteScanById(int id) async {
    // Obtener la referencia a la base de datos
    final db = await database;
    // Eliminar un registro de la tabla scans por el id especificado
    final response = await db.delete('scans', where: 'id = ?', whereArgs: [id]);
    // Retorna la cantidada de registros eliminados
    return response;
  }

  // ? Cada método CRUD en SQFLite tiene su correspondiente RAW para realizar operaciones más complejas o a la medida.
  // ? La ventaja de usar query, insert, delete, update consiste en que las consultas SQL son escapadas por defecto e internamente se previene la inyección SQL
  // * Usar sus equivalentes en RAW deja al programador la responsabilidad de escapar los datos y prevenir inyecciones SQL, sin embargo, deja mayor libertad para ejecutar consultas que requieran un alto grado de complejidad
  // rawDelete("DELETE FROM scans")
  // rawQuery("SELECT * FROM scans WHERE type = '$type'")
  // rawInsert("INSERT INTO scans () VALUES () ")
}
