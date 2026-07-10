class SignosVitales {
  final String id;
  final String personaId;
  final String fecha;
  final String hora;
  final String presionArterial;
  final int frecuenciaCardiaca;
  final int frecuenciaRespiratoria;
  final double temperaturaCorporal;
  final int saturacionOxigeno;

  SignosVitales({
    required this.id,
    required this.personaId,
    required this.fecha,
    required this.hora,
    required this.presionArterial,
    required this.frecuenciaCardiaca,
    required this.frecuenciaRespiratoria,
    required this.temperaturaCorporal,
    required this.saturacionOxigeno,
  });

  factory SignosVitales.fromJson(Map<String, dynamic> json) {
    return SignosVitales(
      id: json['id'].toString(),
      personaId: json['persona_id'].toString(),
      fecha: json['fecha'],
      hora: json['hora'],
      presionArterial: json['presion_arterial'],
      frecuenciaCardiaca: json['frecuencia_cardiaca'],
      frecuenciaRespiratoria: json['frecuencia_respiratoria'],
      temperaturaCorporal: (json['temperatura_corporal'] as num).toDouble(),
      saturacionOxigeno: json['saturacion_oxigeno'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'persona_id': personaId,
      'fecha': fecha,
      'hora': hora,
      'presion_arterial': presionArterial,
      'frecuencia_cardiaca': frecuenciaCardiaca,
      'frecuencia_respiratoria': frecuenciaRespiratoria,
      'temperatura_corporal': temperaturaCorporal,
      'saturacion_oxigeno': saturacionOxigeno,
    };
  }
}