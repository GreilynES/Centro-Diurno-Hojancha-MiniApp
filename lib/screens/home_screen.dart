import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/centro_diurno_provider.dart';
import 'registro_persona_screen.dart';
import 'gestion_individual_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CentroDiurnoProvider>().cargarPersonas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CentroDiurnoProvider>();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Centro Diurno Hojancha'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar por nombre o cédula',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => provider.filtrarPersonas(value),
            ),
          ),
          Expanded(
            child: provider.isLoading && provider.personas.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: provider.personasFiltradas.length,
                    itemBuilder: (context, index) {
                      final persona = provider.personasFiltradas[index];
                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFF78C0B4).withOpacity(0.15),
                            child: const Icon(Icons.person, color: Color(0xFF78C0B4)),
                          ),
                          title: Text(
                            persona.nombreCompleto,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            'Cédula: ${persona.cedula}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GestionIndividualScreen(persona: persona),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF78C0B4),
        foregroundColor: Colors.white,
        child: const Icon(Icons.person_add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RegistroPersonaScreen()),
        ),
      ),
    );
  }
}