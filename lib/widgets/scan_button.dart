import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_flutter_app/services/scan_service.dart';
import 'package:qr_code_flutter_app/utils/utils.dart';

// Widget encargado de mostrar el botón flotante encargado de activar la camara para detectar los códigos QR y proceder a escanearlos
class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        // Recuperar la instancia de ScanService administrada por el gestor de estado Provider. No me interesa escuchar los cambios en el estado dentro de este método
        final scanService = Provider.of<ScanService>(context, listen: false);
        String barcodeResponse;
        try {
          // Invocar el plugin lector de códigos QR
          // (color de linea detectoram, leyenda botón cancelar, se usará el flash, tipo de código a detectar)
          barcodeResponse = await FlutterBarcodeScanner.scanBarcode(
              "#00FFFF", 'Cancelar', false, ScanMode.QR);
          print(barcodeResponse);
          // Verificar si el usuario ha cancelado la captura del código QR (presionó el botón cancelar)
          if (barcodeResponse == '-1') {
            return;
          }
          // Registrar scan en base de datos
          final scan = await scanService.newScan(barcodeResponse);

          // Después de resolverse la promesa, es importante...
          // Comprobar si el widget asociado al contexto está montado actualmente en el árbol de widgets. Esto ayuda a prevenir problemas que ocurren cuando se intenta interactuar con un widget que ya no forma parte de la escena
          if (!context.mounted) return;

          // Verificar el tipo de scan,
          if (scan.type == 'http') {
            // En caso de un sitio Web, lanzar el navegador apuntando hacia la URL escaneada
            launchInWebView(Uri.parse(scan.value));
          } else {
            // En caso de una coordenada de Geolocalización, mostrar la pantalla de visualización de mapa con los datos del scan capturado como argumento
            Navigator.pushNamed(context, 'map', arguments: scan);
          }
        } on PlatformException {
          barcodeResponse = 'Error al obtener la versión de la plataforma';
        }
      },
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
