import 'package:flutter/material.dart';

// Provider referente a la UI
// ChangeNotifier es una clase provista por Flutter que se utiliza para manejar el estado y notificar a los widgets cuando ese estado cambia. Esta clase está diseñada para trabajar con Provider (un paquete de terceros), que es una solución de gestión de estado que facilita el flujo de datos en la aplicación Flutter.
class UserIntefaceProvider extends ChangeNotifier {
  int _selectedOptionMenu = 0;

  // Obtener la opción de menu seleccionada
  int get selectedOptionMenu => _selectedOptionMenu;

  // Establecer la opción de menú actualmente seleccionada
  set selectedOptionMenu(int value) {
    _selectedOptionMenu = value;
    // Notificar a todos los widgets subscritos a este Provider a que deben volver a redenderizarse, puesto que deben mostrar nueva información
    notifyListeners();
  }
}
