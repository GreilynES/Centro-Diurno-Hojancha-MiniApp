import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/persona.dart';
import '../models/medicamento.dart';
import '../providers/centro_diurno_provider.dart';

class MedicamentosScreen extends StatefulWidget {
  final Persona persona;
  const MedicamentosScreen({super.key, required this.persona});

  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<MedicamentosScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _dosisCtrl = TextEditingController();
  final _frecuenciaCtrl = TextEditingController();
  final _obsCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CentroDiurnoProvider>().cargarMedicamentos(widget.persona.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CentroDiurnoProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text('Medicamentos - ${widget.persona.nombreCompleto}')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: ExpansionTile(
                    iconColor: const Color(0xFF5C93C4),
                    collapsedIconColor: const Color(0xFF5C93C4),
                    title: const Text('Agregar Medicamento', style: TextStyle(fontWeight: FontWeight.bold)),
                    children: [
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nombreCtrl,
                        decoration: InputDecoration(
                          labelText: 'Nombre *',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          prefixIcon: const Icon(Icons.medication, color: Color(0xFF555555)),
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (v) => v!.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _dosisCtrl,
                        decoration: InputDecoration(
                          labelText: 'Dosis *',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          prefixIcon: const Icon(Icons.scale, color: Color(0xFF555555)),
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (v) => v!.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _frecuenciaCtrl,
                        decoration: InputDecoration(
                          labelText: 'Frecuencia *',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          prefixIcon: const Icon(Icons.access_time, color: Color(0xFF555555)),
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (v) => v!.isEmpty ? 'Requerido' : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _obsCtrl,
                        decoration: InputDecoration(
                          labelText: 'Observaciones',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          prefixIcon: const Icon(Icons.note, color: Color(0xFF555555)),
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              final med = Medicamento(
                                id: '',
                                personaId: widget.persona.id,
                                nombreMedicamento: _nombreCtrl.text,
                                dosis: _dosisCtrl.text,
                                frecuencia: _frecuenciaCtrl.text,
                                observaciones: _obsCtrl.text,
                              );
                              context.read<CentroDiurnoProvider>().guardarMedicamento(med);
                              _nombreCtrl.clear();
                              _dosisCtrl.clear();
                              _frecuenciaCtrl.clear();
                              _obsCtrl.clear();
                            }
                          },
                          child: const Text('Guardar'),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Divider(color: Colors.grey[300], thickness: 1, height: 1),
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    itemCount: provider.medicamentosActuales.length,
                    itemBuilder: (context, index) {
                      final med = provider.medicamentosActuales[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF5C93C4).withOpacity(0.15),
                            child: const Icon(Icons.medication, color: Color(0xFF5C93C4)),
                          ),
                          title: Text(
                            med.nombreMedicamento,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${med.dosis} - ${med.frecuencia}\nObs: ${med.observaciones ?? 'N/A'}',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}