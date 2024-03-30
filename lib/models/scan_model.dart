import 'dart:convert';
// Modelo generado desde https://app.quicktype.io/

// Modelo para representar un recurso escaneado desde un código QR (sitio Web o Coordenadas de Geolocalización)
class ScanModel {
  // El identificador del recurso
  int? id;
  // http (sitio Web) | geo (Geolocalización)
  String? type;
  // Uri | geolocation
  String value;

  ScanModel({
    this.id,
    this.type,
    required this.value,
  }) {
    // Inicializar el tipo de recurso escaneado (solo se permiten direcciones Web o coordenadas de geolocalización)
    if (value.contains('http')) {
      type = 'http';
    } else {
      type = 'geo';
    }
  }

  factory ScanModel.fromRawJson(String str) =>
      ScanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  // Codificador
  // Constructor para generar una instancia de ScanModel a partir de un Mapa (que cumpla con la estructura JSON)
  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  // Decodificador
  // Convertir una instancia de ScanModel a un Mapa
  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };
}
