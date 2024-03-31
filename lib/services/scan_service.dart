import 'package:flutter/material.dart';
import 'package:qr_code_flutter_app/models/scan_model.dart';
import 'package:qr_code_flutter_app/providers/db_provider.dart';

// Este servicio se encarga de centralizar todas las tareas relacionadas con los scans
// Se encarga de notificar a todos los widgets sucritos de cualquier cambio en la información
class ScanService extends ChangeNotifier {
  // Listado de scans de tipo http (web)
  List<ScanModel> scans = [];
  String selectedType = 'http';

  // Método para registrar un nuevo scan en base de datos
  newScan(String value) async {
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
}
