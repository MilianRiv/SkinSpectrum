import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = "Español";

  final List<String> _languages = [
    "Español",
    "Inglés"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Seleccionar Idioma"),
        backgroundColor: const Color(0xFF304C89),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: _languages.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final language = _languages[index];
          return ListTile(
            title: Text(
              language,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: _selectedLanguage == language
                ? const Icon(Icons.check_circle, color: Color(0xFF2A9D8F))
                : null,
            onTap: () {
              setState(() {
                _selectedLanguage = language;
              });

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Idioma cambiado a $language"),
                  backgroundColor: const Color(0xFFE76F51),
                  duration: const Duration(seconds: 2),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
