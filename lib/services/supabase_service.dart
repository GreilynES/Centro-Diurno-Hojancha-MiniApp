import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/persona.dart';
import '../models/medicamento.dart';
import '../models/signos_vitales.dart';

class SupabaseService {
  final _client = Supabase.instance.client;

  // Personas
  Future<List<Persona>> getPersonas() async {
    final response = await _client.from('personas').select();
    return response.map((json) => Persona.fromJson(json)).toList();
  }

  Future<void> registrarPersona(Persona persona) async {
    await _client.from('personas').insert(persona.toJson());
  }

  // Medicamentos
  Future<List<Medicamento>> getMedicamentos(String personaId) async {
    final response = await _client.from('medicamentos').select().eq('persona_id', personaId);
    return response.map((json) => Medicamento.fromJson(json)).toList();
  }

  Future<void> registrarMedicamento(Medicamento medicamento) async {
    await _client.from('medicamentos').insert(medicamento.toJson());
  }

  // Signos Vitales
  Future<List<SignosVitales>> getSignosVitales(String personaId) async {
    final response = await _client
        .from('signos_vitales')
        .select()
        .eq('persona_id', personaId)
        .order('fecha', ascending: false)
        .order('hora', ascending: false);
    return response.map((json) => SignosVitales.fromJson(json)).toList();
  }

  Future<void> registrarSignosVitales(SignosVitales signos) async {
    await _client.from('signos_vitales').insert(signos.toJson());
  }
}