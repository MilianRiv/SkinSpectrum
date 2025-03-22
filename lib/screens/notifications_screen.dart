import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        "title": "Resultado disponible",
        "subtitle": "Tu último escaneo ya está listo para revisar.",
        "time": "Hace 5 min"
      },
      {
        "title": "Consejo del día",
        "subtitle": "Recuerda hidratar tu piel antes de dormir.",
        "time": "Hoy 8:00 a.m."
      },
      {
        "title": "Nuevo video agregado",
        "subtitle": "Consulta lo último sobre prevención de cáncer de piel.",
        "time": "Ayer"
      },
      {
        "title": "Actualización disponible",
        "subtitle": "SkinSpectrum se ha actualizado con mejoras.",
        "time": "Hace 3 días"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificaciones"),
        backgroundColor: const Color(0xFF304C89), // Azul Medianoche
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              leading: const Icon(Icons.notifications_active_rounded, color: Color(0xFFE76F51)),
              title: Text(item["title"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item["subtitle"]!),
              trailing: Text(
                item["time"]!,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () {}, // Aquí se puede expandir para más detalle
            ),
          );
        },
      ),
    );
  }
}
