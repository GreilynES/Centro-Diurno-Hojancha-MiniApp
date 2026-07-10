import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/persona.dart';
import '../models/signos_vitales.dart';
import '../providers/centro_diurno_provider.dart';

class SignosVitalesScreen extends StatefulWidget {
  final Persona persona;
  const SignosVitalesScreen({super.key, required this.persona});

  @override
  _SignosVitalesScreenState createState() => _SignosVitalesScreenState();
}

class _SignosVitalesScreenState extends State<SignosVitalesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fechaCtrl = TextEditingController();
  final _horaCtrl = TextEditingController();
  final _paCtrl = TextEditingController();
  final _fcCtrl = TextEditingController();
  final _frCtrl = TextEditingController();
  final _tempCtrl = TextEditingController();
  final _satCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CentroDiurnoProvider>().cargarSignosVitales(widget.persona.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CentroDiurnoProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text('Signos Vitales - ${widget.persona.nombreCompleto}')),
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
                    iconColor: const Color(0xFFB34F5F),
                    collapsedIconColor: const Color(0xFFB34F5F),
                    title: const Text('Registrar Signos', style: TextStyle(fontWeight: FontWeight.bold)),
                    initiallyExpanded: true,
                    children: [
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _fechaCtrl,
                              decoration: InputDecoration(
                                labelText: 'Fecha (YYYY-MM-DD) *',
                                labelStyle: TextStyle(color: Colors.grey.shade700),
                                prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF555555)),
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (v) => v!.isEmpty ? '*' : null,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _horaCtrl,
                              decoration: InputDecoration(
                                labelText: 'Hora (HH:MM) *',
                                labelStyle: TextStyle(color: Colors.grey.shade700),
                                prefixIcon: const Icon(Icons.access_time, color: Color(0xFF555555)),
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (v) => v!.isEmpty ? '*' : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _paCtrl,
                        decoration: InputDecoration(
                          labelText: 'Presión Arterial (Ej: 120/80) *',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          prefixIcon: const Icon(Icons.favorite, color: Color(0xFF555555)),
                          filled: true,
                          fillColor: Colors.grey[50],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (v) => v!.isEmpty ? '*' : null,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _fcCtrl,
                              decoration: InputDecoration(
                                labelText: 'FC (lpm) *',
                                labelStyle: TextStyle(color: Colors.grey.shade700),
                                prefixIcon: const Icon(Icons.monitor_heart, color: Color(0xFF555555)),
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _frCtrl,
                              decoration: InputDecoration(
                                labelText: 'FR (rpm) *',
                                labelStyle: TextStyle(color: Colors.grey.shade700),
                                prefixIcon: const Icon(Icons.air, color: Color(0xFF555555)),
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _tempCtrl,
                              decoration: InputDecoration(
                                labelText: 'Temp (°C) *',
                                labelStyle: TextStyle(color: Colors.grey.shade700),
                                prefixIcon: const Icon(Icons.thermostat, color: Color(0xFF555555)),
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _satCtrl,
                              decoration: InputDecoration(
                                labelText: 'SatO2 (%) *',
                                labelStyle: TextStyle(color: Colors.grey.shade700),
                                prefixIcon: const Icon(Icons.opacity, color: Color(0xFF555555)),
                                filled: true,
                                fillColor: Colors.grey[50],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
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
                              final signos = SignosVitales(
                                id: '',
                                personaId: widget.persona.id,
                                fecha: _fechaCtrl.text,
                                hora: _horaCtrl.text,
                                presionArterial: _paCtrl.text,
                                frecuenciaCardiaca: int.parse(_fcCtrl.text),
                                frecuenciaRespiratoria: int.parse(_frCtrl.text),
                                temperaturaCorporal: double.parse(_tempCtrl.text),
                                saturacionOxigeno: int.parse(_satCtrl.text),
                              );
                              context.read<CentroDiurnoProvider>().guardarSignosVitales(signos);
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
                    itemCount: provider.signosVitalesActuales.length,
                    itemBuilder: (context, index) {
                      final reg = provider.signosVitalesActuales[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFB34F5F).withOpacity(0.15),
                            child: const Icon(Icons.monitor_heart, color: Color(0xFFB34F5F)),
                          ),
                          title: Text(
                            '${reg.fecha} - ${reg.hora}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'PA: ${reg.presionArterial} | FC: ${reg.frecuenciaCardiaca} | FR: ${reg.frecuenciaRespiratoria} | Temp: ${reg.temperaturaCorporal}°C | Sat: ${reg.saturacionOxigeno}%',
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