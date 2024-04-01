import 'package:url_launcher/url_launcher.dart';

// Método utilitarion para lanzar el navegador hacia una determinada URL
Future<void> launchInWebView(Uri uri) async {
  if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
    throw Exception('No se puede lanzar la URL $uri');
  }
}
