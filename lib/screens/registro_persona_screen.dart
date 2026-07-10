import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/persona.dart';
import '../providers/centro_diurno_provider.dart';

class RegistroPersonaScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _cedulaCtrl = TextEditingController();
  final _diagnosticoCtrl = TextEditingController();

  RegistroPersonaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CentroDiurnoProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Registrar Adulto Mayor')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nombreCtrl,
                    decoration: InputDecoration(
                      labelText: 'Nombre Completo *',
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      prefixIcon: const Icon(Icons.person, color: Color(0xFF555555)),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _cedulaCtrl,
                    decoration: InputDecoration(
                      labelText: 'Cédula *',
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      prefixIcon: const Icon(Icons.badge, color: Color(0xFF555555)),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (v) => v!.isEmpty ? 'Requerido' : null,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _diagnosticoCtrl,
                    decoration: InputDecoration(
                      labelText: 'Diagnóstico Médico (Opcional)',
                      labelStyle: TextStyle(color: Colors.grey.shade700),
                      prefixIcon: const Icon(Icons.medical_information, color: Color(0xFF555555)),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  provider.isLoading
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF78C0B4),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final nueva = Persona(
                                  id: '', // Supabase generará el UUID
                                  nombreCompleto: _nombreCtrl.text,
                                  cedula: _cedulaCtrl.text,
                                  diagnosticoMedico: _diagnosticoCtrl.text.isEmpty
                                      ? null
                                      : _diagnosticoCtrl.text,
                                );
                                final exito = await context
                                    .read<CentroDiurnoProvider>()
                                    .guardarPersona(nueva);
                                if (exito && context.mounted) Navigator.pop(context);
                              }
                            },
                            child: const Text('Guardar Registro', style: TextStyle(fontSize: 16)),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}