import 'package:flutter/material.dart';
import 'package:qr_code_flutter_app/screens/home_screen.dart';
import 'package:qr_code_flutter_app/screens/map_screen.dart';

void main() => runApp(const QRCodeApp());

class QRCodeApp extends StatelessWidget {
  const QRCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Code',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'map': (_) => const MapScreen()
      },
      // Tema principal de la aplicación (se recomienda trabajarlo en línea para ver reflejados los cambios en caliente, una vez terminado, se puede separar su declaración en un archivo de tema independiente)
      theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              unselectedItemColor: Colors.cyan,
              selectedItemColor: Colors.black38),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.cyan),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.cyan)),
    );
  }
}
