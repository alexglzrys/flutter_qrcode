import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_flutter_app/services/scan_service.dart';

// Este widget representa parte de una vista de una pantalla completa
// Es por ello que no cuenta con un Scaffold y se considera como un partial
class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener la instancia de ScanService gestionada por el Provider
    final scanService = Provider.of<ScanService>(context);
    // Obtener el listado de scans a mostrar en esta vista (este listado ya se enceuntra previamente filtrado antes de mostrar esta vista)
    final scans = scanService.scans;
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.add_home_work_outlined, color: Colors.cyan),
          title: Text(scans[index].value),
          subtitle: Text(scans[index].id.toString()),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () => print('scan presionado... ${scans[index].id}'),
        );
      },
      itemCount: scans.length,
    );
  }
}
