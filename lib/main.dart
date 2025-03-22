import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _determineStartScreen() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Puedes cambiar el delay si quieres mostrar el Splash por más tiempo
    await Future.delayed(const Duration(seconds: 2));

    if (isLoggedIn) {
      return const HomeScreen(initialIndex: 3); // Ir al perfil
    } else {
      return const LoginScreen(); // Ir a login si no ha iniciado sesión
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _determineStartScreen(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const MaterialApp(
            home: SplashScreen(), // Muestra animación inicial
            debugShowCheckedModeBanner: false,
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SkinSpectrum',
          theme: ThemeData(
            primaryColor: const Color(0xFF264653), // Azul Profundo
            scaffoldBackgroundColor: const Color(0xFF2A9D8F), // Verde Turquesa
            textTheme: GoogleFonts.montserratTextTheme(),

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
          home: snapshot.data!,
        );
      },
    );
  }
}
