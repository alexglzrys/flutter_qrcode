import 'package:flutter/material.dart';

// Este widget representa parte de una vista de una pantalla completa
// Es por ello que no cuenta con un Scaffold y se considera como un partial
class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Address View'));
  }
}
