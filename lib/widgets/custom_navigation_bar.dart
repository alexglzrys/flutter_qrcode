import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_flutter_app/providers/user_interface_provider.dart';

// Widget encargado de mostrar la barra de navegación inferior de la aplicación
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la instancia de UserIntefaceProvider (gestionada por Provider)
    final userInterceProvider = Provider.of<UserIntefaceProvider>(context);

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration), label: 'Direcciones'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa')
      ],
      elevation: 0,
      // Recuperar la opción de menú actualmente seleccionada
      currentIndex: userInterceProvider.selectedOptionMenu,
      onTap: (value) {
        // Establecer la nueva opción de menú seleccionada
        // Intermanente, en el setter de "selectedOptionMenu" se encuentra declarado un "notifyListeners()".
        // Por tanto, es en este punto donde nuestra aplicación reaccionará a los cambios y la UI se actualizará (gracias a Provider)
        userInterceProvider.selectedOptionMenu = value;
      },
    );
  }
}
