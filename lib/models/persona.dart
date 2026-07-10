class Persona {
  final String id;
  final String nombreCompleto;
  final String cedula;
  final String? diagnosticoMedico;

  Persona({
    required this.id,
    required this.nombreCompleto,
    required this.cedula,
    this.diagnosticoMedico,
  });

  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['id'].toString(),
      nombreCompleto: json['nombre_completo'],
      cedula: json['cedula'],
      diagnosticoMedico: json['diagnostico_medico'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre_completo': nombreCompleto,
      'cedula': cedula,
      'diagnostico_medico': diagnosticoMedico,
    };
  }
}