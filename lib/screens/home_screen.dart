import 'package:flutter/material.dart';
import 'package:qr_code_flutter_app/widgets/scan_button.dart';
import 'package:qr_code_flutter_app/widgets/custom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        elevation: 0,
        centerTitle: true,
        // Botones con acciones o disparadores de tareas
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: const Center(child: Text('Home Screen')),
      // Widgets con configuración compleja es importante separarlos en clases independientes, ya sea en la mismo archivo o archivos separados
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
