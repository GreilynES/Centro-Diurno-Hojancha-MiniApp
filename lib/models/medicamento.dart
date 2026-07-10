class Medicamento {
  final String id;
  final String personaId;
  final String nombreMedicamento;
  final String dosis;
  final String frecuencia;
  final String? observaciones;

  Medicamento({
    required this.id,
    required this.personaId,
    required this.nombreMedicamento,
    required this.dosis,
    required this.frecuencia,
    this.observaciones,
  });

  factory Medicamento.fromJson(Map<String, dynamic> json) {
    return Medicamento(
      id: json['id'].toString(),
      personaId: json['persona_id'].toString(),
      nombreMedicamento: json['nombre_medicamento'],
      dosis: json['dosis'],
      frecuencia: json['frecuencia'],
      observaciones: json['observaciones'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'persona_id': personaId,
      'nombre_medicamento': nombreMedicamento,
      'dosis': dosis,
      'frecuencia': frecuencia,
      'observaciones': observaciones,
    };
  }
}