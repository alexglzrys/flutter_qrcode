import 'package:flutter/material.dart';

// Widget encargado de mostrar la barra de navegación inferior de la aplicación
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration), label: 'Direcciones'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa')
      ],
      elevation: 0,
      currentIndex: 1,
    );
  }
}
