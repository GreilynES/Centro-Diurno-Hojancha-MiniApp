import 'package:flutter/material.dart';
import '../models/persona.dart';
import '../models/medicamento.dart';
import '../models/signos_vitales.dart';
import '../services/supabase_service.dart';

class CentroDiurnoProvider extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();

  bool isLoading = false;
  String? errorMessage;

  List<Persona> personas = [];
  List<Persona> personasFiltradas = [];
  List<Medicamento> medicamentosActuales = [];
  List<SignosVitales> signosVitalesActuales = [];

  // Gestión de Personas
  Future<void> cargarPersonas() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      personas = await _service.getPersonas();
      personasFiltradas = personas;
    } catch (e) {
      errorMessage = "Error al cargar personas: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void filtrarPersonas(String query) {
    if (query.isEmpty) {
      personasFiltradas = personas;
    } else {
      personasFiltradas = personas.where((p) {
        return p.nombreCompleto.toLowerCase().contains(query.toLowerCase()) || 
               p.cedula.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<bool> guardarPersona(Persona persona) async {
    try {
      isLoading = true;
      notifyListeners();
      await _service.registrarPersona(persona);
      await cargarPersonas();
      return true;
    } catch (e) {
      errorMessage = "Error al guardar persona: $e";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Gestión de Medicamentos
  Future<void> cargarMedicamentos(String personaId) async {
    try {
      isLoading = true;
      notifyListeners();
      medicamentosActuales = await _service.getMedicamentos(personaId);
    } catch (e) {
      errorMessage = "Error al cargar medicamentos: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> guardarMedicamento(Medicamento med) async {
    try {
      isLoading = true;
      notifyListeners();
      await _service.registrarMedicamento(med);
      await cargarMedicamentos(med.personaId);
      return true;
    } catch (e) {
      errorMessage = "Error al guardar medicamento: $e";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Gestión de Signos Vitales
  Future<void> cargarSignosVitales(String personaId) async {
    try {
      isLoading = true;
      notifyListeners();
      signosVitalesActuales = await _service.getSignosVitales(personaId);
    } catch (e) {
      errorMessage = "Error al cargar signos vitales: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> guardarSignosVitales(SignosVitales signos) async {
    try {
      isLoading = true;
      notifyListeners();
      await _service.registrarSignosVitales(signos);
      await cargarSignosVitales(signos.personaId);
      return true;
    } catch (e) {
      errorMessage = "Error al guardar signos: $e";
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}