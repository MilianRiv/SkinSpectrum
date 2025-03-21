import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkinSpectrum',
      theme: ThemeData(
        primaryColor: const Color(0xFF264653), // Azul Profundo
        scaffoldBackgroundColor: const Color(0xFF2A9D8F), // Verde Turquesa
        textTheme: GoogleFonts.montserratTextTheme(), // Fuente global

        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF304C89), // Azul Medianoche
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE76F51), // Rojo Terracota
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFE9C46A), // Dorado Mostaza
        ),

        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF264653), // Azul Profundo
          selectedItemColor: Color(0xFFE9C46A), // Dorado Mostaza
          unselectedItemColor: Colors.white70,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
