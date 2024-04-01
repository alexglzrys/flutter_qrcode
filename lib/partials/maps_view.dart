import 'package:flutter/material.dart';

// Este widget representa parte de una vista de una pantalla completa
// Es por ello que no cuenta con un Scaffold y se considera como un partial
class MapsView extends StatelessWidget {
  const MapsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.map_outlined, color: Colors.cyan),
          title: const Text('http://localhost.com'),
          subtitle: const Text('ID: 251'),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
          onTap: () => print('scan presionado...'),
        );
      },
      itemCount: 10,
    );
  }
}
