import 'package:flutter/material.dart';
import 'package:qr_code_flutter_app/models/scan_model.dart';
import 'package:qr_code_flutter_app/providers/db_provider.dart';

// Este servicio se encarga de centralizar todas las tareas relacionadas con los scans
// Se encarga de notificar a todos los widgets sucritos de cualquier cambio en la información
// ScanService es un servicio de alto nivel para comunicarse con la UI, el DBProvider es un servicio de bajo nivel para comunicarse directamente con la BD
class ScanService extends ChangeNotifier {
  // Listado de scans de tipo http (web)
  List<ScanModel> scans = [];
  String selectedType = 'http';

  // Método para registrar un nuevo scan en base de datos
  Future<void> newScan(String value) async {
    // Generar una instancia de ScanModel
    final scan = ScanModel(value: value);
    // Almacenar el nuevo ScanModel en base de datos y recuperar el id asignado
    final id = await DBProvider.db.insertNewScan(scan);
    // Establecer el id a la instancia de ScanModel
    scan.id = id;
    // Insertar la nueva instancia de ScanModel a el listado de scans, siempre y cuando sean del tipo http
    if (selectedType == scan.type) {
      scans.add(scan);
      // Notificar a todos los listeners suscritos a este provider, a volverse a renderizar para mostrar los nuevos cambios
      notifyListeners();
    }
  }

  // Método para recuperar todos los registrso de scans almancenados en la base de datos
  getAllScans() async {
    // Recuperar todos los scans de la base de datos
    final myScans = await DBProvider.db.getAllScans();
    // Actualizar mi listado de scans
    scans = [...myScans];
    // Notificar a todos los listeners suscritos a este provider, a volverse a renderizar para mostrar los nuevos cambios
    notifyListeners();
  }

  // Método para recuperar todos los scans relacionados con un tipo en particular
  Future<void> getScansByType(String type) async {
    // Recuperar todos los scans que pertenecen al tipo especificado de la base de datos
    final myScans = await DBProvider.db.getScansByType(type);
    // Actualizar mi listado de scans
    scans = [...myScans];
    // Especificar que el listado de scans corresponde al tipo especificado
    selectedType = type;
    // Notificar a todos los listeners suscritos a este provider, a volverse a renderizar para mostrar los nuevos cambios
    notifyListeners();
  }

  // Método para eliminar un scan en base de datos
  deleteScanById(int id) async {
    // Eliminar el scan de la base de datos por su id
    final deletedId = await DBProvider.db.deleteScanById(id);
    // Filtrar el listado de scans actual, omitiendo aquel cuyo id se corresponda con el scan eliminado en base de datos
    final filter = scans.where((scan) => scan.id != deletedId).toList();
    // Actualizar mi listado de scans
    scans = [...filter];
    // Notificar a todos los listeners suscritos a este provider, a volverse a renderizar para mostrar los nuevos cambios
    notifyListeners();
  }

  // Método para eliminar todos los registros de scans en la base de datos
  deleteAllScans() async {
    // Eliminar todos los registros en la base de datos
    await DBProvider.db.deleteAll();
    // Actualizar mi listado de scans
    scans = [];
    // Notificar a todos los listeners suscritos a este provider, a volverse a renderizar para mostrar los nuevos cambios
    notifyListeners();
  }
}
