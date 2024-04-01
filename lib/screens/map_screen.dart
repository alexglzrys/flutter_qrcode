import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_code_flutter_app/models/scan_model.dart';
import 'package:qr_code_flutter_app/utils/utils.dart';

// Widget para mostrar una ubicación en un mapa de Google
// El paquete google_maps_flutter requiere trabajar con widgets con estado para manejar de manera efectiva la interacción del usuario, la actualización dinámica del mapa y el ciclo de vida del mapa, lo que proporciona una experiencia de usuario fluida y optimizada.
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // En el contexto de Google Maps en Flutter, este Completer se utiliza típicamente para esperar a que el widget GoogleMap esté completamente inicializado antes de interactuar con él.
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    // Recuperar los argumentos enviados en la ruta (scan de geolocalización seleccionado) asociada con esta pantalla
    final ScanModel scan =
        ModalRoute.of(context)!.settings.arguments as ScanModel;

    // Define la posición inicial de la cámara en un mapa de Google. Se utiliza para especificar la ubicación y la orientación de la cámara en el mapa.
    // Esta posición se puede usar al iniciar el mapa para que el usuario vea una ubicación específica y con un nivel de zoom determinado.
    final CameraPosition initialPosition = CameraPosition(
      // Usar el método utilitario para proporcionar la Latitud y Longitud en el formato compatible que espera la librería de GoogleMpasFlutter
      target:
          getLatLng(scan.value), // Coordenadas a mostrar como centro del mapa
      zoom: 17.5, // La cercanía al mapa
      tilt: 50, // Inclinación o perspectiva del mapa
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Ubicación en mapa')),
      // Widget de terceros para mostrar una geolocalización en un mapa de Google
      body: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
