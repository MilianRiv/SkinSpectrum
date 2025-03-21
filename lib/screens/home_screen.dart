import 'package:flutter/material.dart';
import 'scan_screen.dart';
import 'results_screen.dart';
import 'advice_screen.dart';
import 'profile_screen.dart';
import '../widgets/bottom_navbar.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex; // ✅ Permite recibir el índice de inicio

  const HomeScreen({super.key, this.initialIndex = 0}); // ✅ Por defecto abre "Escaneo"

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // ✅ Usa el índice que se pasa
  }

  final List<Widget> _screens = [
    const ScanScreen(),
    const AdviceScreen(),
    const ResultsScreen(),
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Image.asset('assets/animations/logo.png', height: 40),
        backgroundColor: Colors.teal[800],
      ), */
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
