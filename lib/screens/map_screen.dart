import 'package:flutter/material.dart';
import 'package:qr_code_flutter_app/models/scan_model.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recuperar los argumentos enviados en la ruta (scan de geolocalización seleccionado) asociada con esta pantalla
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;
    return Scaffold(body: Center(child: Text(scan.value)));
  }
}
