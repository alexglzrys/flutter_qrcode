# qr_code_flutter_app

A new Flutter project.

## Multidex

- El soporte multidex es necesario en aplicaciones de Flutter cuando el tamaño del código supera el límite de 64K métodos o cuando la aplicación debe ser compatible con versiones antiguas de Android. Esto es común en aplicaciones grandes, complejas o aquellas que hacen un uso intensivo de bibliotecas de terceros. **https://docs.flutter.dev/deployment/android**

- Aumentar la versión del SDK de Android mínimo a la 21 **(se sugiere a la versión descrita en consola al momento de debuggerar)**
- Activar soporte Multidex con ayuda de las herramientas de flutter
```
flutter run --multidex
```

