import 'package:flutter/material.dart';
import 'Memorama.dart'; // importamos nuestro archivo de juego

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(fontFamily: null), // usa fuente predeterminada
  home: const MemoramaPage(),
);
  }
}
