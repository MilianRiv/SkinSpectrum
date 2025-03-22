import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'connect_doctor_screen.dart'; // ✅ Nueva pantalla simulada

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  Map<String, double> scanResults = {
    "Lesión benigna": 65.0,
    "Lesión maligna": 20.0,
    "Sin anomalías": 15.0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: Colors.teal[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: scanResults.isEmpty
            ? const Center(
                child: Text(
                  "No hay resultados disponibles.",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Resultados del Análisis",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: scanResults.length,
                      itemBuilder: (context, index) {
                        String label = scanResults.keys.elementAt(index);
                        double percentage = scanResults[label]!;
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Icon(
                              Icons.analytics,
                              color: percentage > 50 ? Colors.red : Colors.green,
                            ),
                            title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text("Probabilidad: ${percentage.toStringAsFixed(1)}%"),
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'ver') {
                                  _showDetailDialog(context, label, percentage);
                                } else if (value == 'eliminar') {
                                  _confirmDelete(context, label);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(value: 'ver', child: Text('Ver Detalles')),
                                const PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen(initialIndex: 0)),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE76F51),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Center(
                      child: Text(
                        "Realizar otro escaneo",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ConnectDoctorScreen()), // ✅ Se enlaza a la nueva pantalla
          );
        },
        backgroundColor: const Color(0xFF2A9D8F),
        icon: const Icon(Icons.local_hospital, color: Colors.white),
        label: const Text(
          "Enlazar con un médico",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, String label, double percentage) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Detalles del resultado"),
        content: Text(
          "Tipo de lesión: $label\nProbabilidad: ${percentage.toStringAsFixed(1)}%",
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cerrar"),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, String label) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("¿Eliminar resultado?"),
        content: Text("¿Estás segur@ de eliminar \"$label\"? Esta acción no se puede deshacer."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                scanResults.remove(label);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Resultado \"$label\" eliminado."),
                  backgroundColor: const Color(0xFF264653),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
