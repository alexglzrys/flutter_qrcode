import 'package:flutter/material.dart';

// Widget encargado de mostrar el botón flotante encargado de activar la camara para detectar los códigos QR y proceder a escanearlos
class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      elevation: 0,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
