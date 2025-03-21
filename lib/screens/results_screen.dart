import 'package:flutter/material.dart';
import 'home_screen.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, double> scanResults = {
      "Lesión benigna": 65.0,
      "Lesión maligna": 20.0,
      "Sin anomalías": 15.0,
    };

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Historial'),
        backgroundColor: Colors.teal[700], // ✅ Azul Medianoche
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                      title: Text(
                        label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Probabilidad: ${percentage.toStringAsFixed(1)}%"),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                      onTap: () {}, // Aquí podría abrir detalles del resultado
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ✅ Navega a HomeScreen y selecciona la pestaña de escaneo
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen(initialIndex: 0)), // 0 = Escaneo
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE76F51), // ✅ Rojo Terracota de la paleta global
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

      // ✅ Botón flotante para enlazar con un médico
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showDoctorConnectionMessage(context);
        },
        backgroundColor: const Color(0xFF2A9D8F), // ✅ Verde Turquesa
        icon: const Icon(Icons.local_hospital, color: Colors.white),
        label: const Text(
          "Enlazar con un médico",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // ✅ Función para mostrar el SnackBar con mensaje
  void _showDoctorConnectionMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          "Conéctate con un médico certificado SkinSpectrum.",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: const Color(0xFF304C89), // ✅ Azul Medianoche
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Abrir",
          textColor: Colors.white,
          onPressed: () {
            // Aquí podríamos abrir la pantalla de médicos
          },
        ),
      ),
    );
  }
}
