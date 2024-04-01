import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// Método utilitarion para lanzar el navegador hacia una determinada URL
Future<void> launchInWebView(Uri uri) async {
  if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
    throw Exception('No se puede lanzar la URL $uri');
  }
}

// Méotodo utilitario para obtener la latitud y longitud en formato compatible con Google Maps
LatLng getLatLng(String value) {
  // geo:75.88911,-99.181515

  // Obtener la latitud y longitud en una lista [75.88911,-99.181515]
  final List coordinates = value.substring(4).split(',');
  final double latitude = double.parse(coordinates[0]);
  final double longitude = double.parse(coordinates[1]);
  return LatLng(latitude, longitude);
}
