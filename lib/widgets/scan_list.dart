import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_flutter_app/services/scan_service.dart';
import 'package:qr_code_flutter_app/utils/utils.dart';

// Widget encargado de mostrar un listado de los scans filtrados por tipo, almacenados en la base de datos
class ScanList extends StatelessWidget {
  const ScanList({super.key, required this.type});
  // El tipo de scan a mostrar en el listado
  final String type;

  @override
  Widget build(BuildContext context) {
    // Obtener la instancia de ScanService gestionada por el Provider
    final scanService = Provider.of<ScanService>(context);
    // Obtener el listado de scans a mostrar en esta vista (este listado ya se enceuntra previamente filtrado antes de mostrar esta vista)
    final scans = scanService.scans;

    return ListView.builder(
      itemBuilder: (context, index) {
        // Dismissible se utiliza comúnmente en combinación con ListView para permitir que los elementos de la lista sean eliminados mediante un gesto de deslizamiento.
        return Dismissible(
          // Flutter requiere un identificador por cada elemento en la lista que puede ser eliminado
          key: UniqueKey(),
          // Dirección permitida de deslizamiento
          direction: DismissDirection.endToStart,
          // Acciones a ejecutar cuando se activa el deslizamiento sobre el elemento
          onDismissed: (direction) async {
            // Eliminar el elemento scan de la base de datos
            await scanService.deleteScanById(scans[index].id!);
          },
          // Información visual que se revelará cuando el usuario activa el deslizamiento sobre el elemento
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
              leading: Icon(
                  // Condicionar el icono con base al tipo de scan renderizado en la lista
                  type == 'http'
                      ? Icons.add_home_work_outlined
                      : Icons.map_outlined,
                  color: Colors.cyan),
              title: Text(scans[index].value),
              subtitle: Text(scans[index].id.toString()),
              trailing: const Icon(Icons.arrow_forward_ios_outlined),
              onTap: () {
                print('scan presionado... ${scans[index].id}');
                // Verificar el tipo de scan presionado
                if (scans[index].type == 'http') {
                  // En caso de un sitio Web, lanzar el navegador apuntando hacia la URL escaneada
                  launchInWebView(Uri.parse(scans[index].value));
                } else {
                  // En caso de una coordenada de Geolocalización, mostrar la pantalla de visualización de mapa con los datos del scan capturado como argumento
                  Navigator.pushNamed(context, 'map', arguments: scans[index]);
                }
              }),
        );
      },
      itemCount: scans.length,
    );
  }
}
