import 'package:flutter/material.dart';

class ConnectDoctorScreen extends StatefulWidget {
  const ConnectDoctorScreen({super.key});

  @override
  State<ConnectDoctorScreen> createState() => _ConnectDoctorScreenState();
}

class _ConnectDoctorScreenState extends State<ConnectDoctorScreen> {
  String _selectedDistance = '5 km';

  final List<String> _distances = ['2 km', '5 km', '10 km', '20 km'];

  final List<Map<String, dynamic>> _doctors = [
    {
      "name": "Dra. Carolina Martínez",
      "distance": "3 km",
      "rating": 4.5,
      "specialty": "Dermatóloga Oncológica"
    },
    {
      "name": "Dr. Jorge López",
      "distance": "5 km",
      "rating": 4.0,
      "specialty": "Especialista en Cáncer de Piel"
    },
    {
      "name": "Dra. Alejandra Torres",
      "distance": "7.5 km",
      "rating": 5.0,
      "specialty": "Dermatóloga General"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Médicos Disponibles'),
        centerTitle: true,
        backgroundColor: const Color(0xFF304C89),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Filtrar por distancia:",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                DropdownButton<String>(
                  value: _selectedDistance,
                  borderRadius: BorderRadius.circular(10),
                  items: _distances
                      .map((d) => DropdownMenuItem(
                            value: d,
                            child: Text(d),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDistance = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _doctors.length,
              itemBuilder: (context, index) {
                final doctor = _doctors[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Color(0xFF2A9D8F),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    title: Text(
                      doctor["name"],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(doctor["specialty"]),
                        const SizedBox(height: 4),
                        Row(
                          children: List.generate(5, (i) {
                            double rating = doctor["rating"];
                            return Icon(
                              i < rating.floor()
                                  ? Icons.star
                                  : i < rating
                                      ? Icons.star_half
                                      : Icons.star_border,
                              size: 18,
                              color: const Color(0xFFE9C46A),
                            );
                          }),
                        ),
                        const SizedBox(height: 4),
                        Text("Distancia: ${doctor["distance"]}"),
                      ],
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Has contactado a ${doctor["name"]}."),
                            backgroundColor: const Color(0xFF264653),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE76F51),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("Contactar"),
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
