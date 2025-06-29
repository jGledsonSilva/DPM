import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dpm/screens/welcome_screen.dart';
import 'package:dpm/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase inicializado com sucesso!");
  } catch (e) {
    print("Falha ao inicializar o Firebase: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      home: const WelcomeScreen(),
    );
  }
}
