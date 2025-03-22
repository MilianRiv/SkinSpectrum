import 'package:flutter/material.dart';

class PrivacySecurityScreen extends StatefulWidget {
  const PrivacySecurityScreen({super.key});

  @override
  State<PrivacySecurityScreen> createState() => _PrivacySecurityScreenState();
}

class _PrivacySecurityScreenState extends State<PrivacySecurityScreen> {
  bool _biometricLock = true;
  bool _shareData = false;
  bool _consentGiven = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Privacidad y Seguridad"),
        centerTitle: true,
        backgroundColor: const Color(0xFF304C89), // Azul Medianoche
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Controles de seguridad",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF264653), // Azul profundo
            ),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            value: _biometricLock,
            onChanged: (value) {
              setState(() {
                _biometricLock = value;
              });
            },
            title: const Text("Bloqueo biométrico (Huella / PIN)"),
            subtitle: const Text("Requiere autenticación para abrir la app."),
            activeColor: const Color(0xFF2A9D8F), // Verde turquesa
          ),
          const Divider(),

          const SizedBox(height: 10),
          const Text(
            "Gestión de datos",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF264653),
            ),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            value: _shareData,
            onChanged: (value) {
              setState(() {
                _shareData = value;
              });
            },
            title: const Text("Compartir datos de escaneo"),
            subtitle: const Text("Permitir enviar resultados a médicos certificados."),
            activeColor: const Color(0xFFE76F51), // Rojo terracota
          ),
          SwitchListTile(
            value: _consentGiven,
            onChanged: (value) {
              setState(() {
                _consentGiven = value;
              });
            },
            title: const Text("Consentimiento de análisis clínico"),
            subtitle: const Text("Autorizo el uso de mis datos para análisis médicos."),
            activeColor: const Color(0xFFE9C46A), // Dorado mostaza
          ),

          const Divider(height: 40),

          ElevatedButton.icon(
            onPressed: () {
              // Aquí podrías mostrar una pantalla de términos o borrar datos
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Tu configuración se ha guardado correctamente."),
                  backgroundColor: Color(0xFF2A9D8F),
                  duration: Duration(seconds: 3),
                ),
              );
            },
            icon: const Icon(Icons.check_circle_outline),
            label: const Text("Guardar cambios"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2A9D8F),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
            ),
          ),
        ],
      ),
    );
  }
}
