import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_flutter_app/providers/user_interface_provider.dart';
import 'package:qr_code_flutter_app/screens/home_screen.dart';
import 'package:qr_code_flutter_app/screens/map_screen.dart';

void main() {
  runApp(
    // Declarar el uso del gestor de estado Provider (para múltiples instancias)
    MultiProvider(
        // Registrar todas las clases que administrará nuestro Provider, mismas que usará la aplicación de forma global
        providers: [
          // Cada clase registrada, Provider se encagará de generar una única instancia (singletón) ya sea de forma instantanea o peresoza (generada bajo demanda)
          // Estas instancias estarán disponibles desde cualquier parte de la aplicación, solo es cuestión de solicitarlas a Provider.
          ChangeNotifierProvider(create: (_) => UserIntefaceProvider())
        ],
        child: const QRCodeApp()),
  );
}

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
              unselectedItemColor: Colors.black38,
              selectedItemColor: Colors.cyan),
          appBarTheme: const AppBarTheme(backgroundColor: Colors.cyan),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.cyan)),
    );
  }
}
