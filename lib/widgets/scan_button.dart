import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// Widget encargado de mostrar el botón flotante encargado de activar la camara para detectar los códigos QR y proceder a escanearlos
class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        String barcodeResponse;
        try {
          // Invocar el plugin lector de códigos QR
          // (color de linea detectoram, leyenda botón cancelar, se usará el flash, tipo de código a detectar)
          barcodeResponse = await FlutterBarcodeScanner.scanBarcode(
              "#00FFFF", 'Cancelar', false, ScanMode.QR);
          print(barcodeResponse);
        } on PlatformException {
          barcodeResponse = 'Error al obtener la versión de la plataforma';
        }
      },
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
