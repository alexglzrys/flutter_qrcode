# qr_code_flutter_app

A new Flutter project.

## Multidex

- El soporte multidex es necesario en aplicaciones de Flutter cuando el tamaño del código supera el límite de 64K métodos o cuando la aplicación debe ser compatible con versiones antiguas de Android. Esto es común en aplicaciones grandes, complejas o aquellas que hacen un uso intensivo de bibliotecas de terceros. **https://docs.flutter.dev/deployment/android**

- Aumentar la versión del SDK de Android mínimo a la 21 **(se sugiere a la versión descrita en consola al momento de debuggerar)**
- Activar soporte Multidex con ayuda de las herramientas de flutter
```
flutter run --multidex
```

# Habilitar el SDK de Google Maps en Android

- Ir a la consola de Google Developers **https://console.cloud.google.com**
- Seleccionar el proyecto dónde se desea habilitar Google Maps
- Seleccionar del menú principal la opción **APIs y servicios** - **Biblioteca**
- Seleccionar y Habilitar **Google Maps SDK Android**
- *Nota: Cada Plataforma requiere habilitar su respectiva SDK*

Google Maps ha cambiado recientemente sus políticas de uso, ahora exige a los usuarios a facturar por el uso de su SDK al momento de integrarla en sus respectivas aplicaciones, **Google Maps nos regala $200 US en creditos para usar su servicio durante el mes actual, al finalizar el mes, nos vuelve a regalar otros $200 US en crédito y así sucesivamente**. Eso equivale a unas 28,500 solicitudes de cardas de mapas sin costo, por lo que es más que suficiente al momento de programar. En caso de exceder este crédito, Google comienza a facturar con cargo a la tarjeta registrada durante el proceso de integración y registro del SDK de Google Maps.

# Generar API Keys y asociarlas a cada SDK

- Seleccionar del menú principal la opción **APIs y servicios** - **Credenciales**
- Crear credenciales
- Seleccionar **Clave de API**
- Seleccionar la nueva API Key generada, y proceder a configurarla y asociarla con su respectiva SDK
- Se recomienda que cada API Key se asocie con un producto o servicio en particualar. 
