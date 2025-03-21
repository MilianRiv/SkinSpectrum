import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Configura la animación de fade-in
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duración del fade-in
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward(); // ✅ Inicia la animación al cargar la pantalla

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose(); // ✅ Limpia el controlador al salir
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 234, 232), // ✅ Mantiene el fondo suave
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation, // ✅ Aplica la animación de fade-in
              child: Image.asset(
                'assets/animations/logo.png', // ✅ Logo arriba
                width: 420,
                height: 420,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Lottie.asset(
              'assets/animations/loading.json', // ✅ Animación abajo
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
