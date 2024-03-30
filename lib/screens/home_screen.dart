import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_flutter_app/models/scan_model.dart';
import 'package:qr_code_flutter_app/partials/address_view.dart';
import 'package:qr_code_flutter_app/partials/maps_view.dart';
import 'package:qr_code_flutter_app/providers/db_provider.dart';
import 'package:qr_code_flutter_app/providers/user_interface_provider.dart';
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
      // El contenido principal de esta página se encuentra condicionado al tab seleccionado en la barra de navegación inferior
      body: const _HomeScreenBody(),
      // Widgets con configuración compleja es importante separarlos en clases independientes, ya sea en la mismo archivo o archivos separados
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

// Widget privado que retorna la vista correspondiente al tab seleccionado
class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la instancia de UserIntefaceProvider (gestionada por Provider)
    final userInterfaceProvider = Provider.of<UserIntefaceProvider>(context);

    // TODO: Temporal leer la base de datos
    //final newScan = ScanModel(value: 'https://somosplasa.com');
    DBProvider.db.getAllScans();

    // Verificar el tab de bavegación inferior actualmente seleccionado, y retornar la vista o partial correspondiente como contenido principal de HomeScreen
    switch (userInterfaceProvider.selectedOptionMenu) {
      case 0:
        return const AddressView();
      case 1:
        return const MapsView();
      default:
        return const Center(child: Text('Vista 404'));
    }
  }
}
