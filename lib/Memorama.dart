import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';


class MemoramaPage extends StatefulWidget {
  const MemoramaPage({super.key});

  @override
  State<MemoramaPage> createState() => _MemoramaPageState();
}

class _MemoramaPageState extends State<MemoramaPage> {

  late List<Color> _cardColors;


  late List<bool> _cardRevealed;

 
  List<int> _selectedIndices = [];

 
  final int _rows = 4;
  final int _cols = 5;


  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

 
  void _initializeGame() {
    int totalCards = _rows * _cols;
    int totalPairs = totalCards ~/ 2;

    
    List<Color> baseColors = List.generate(
      totalPairs,
      (index) =>
          Colors.primaries[index % Colors.primaries.length].shade400,
    );

  
    _cardColors = [...baseColors, ...baseColors]..shuffle(Random());


    _cardRevealed = List.filled(totalCards, false);


    _selectedIndices.clear();

    setState(() {});
  }


  void _handleCardTap(int index) {

    if (_cardRevealed[index] || _selectedIndices.contains(index)) return;


    setState(() {
      _cardRevealed[index] = true;
      _selectedIndices.add(index);
    });

    
   
  }

 



  /// Construye la UI completa de la página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Memorama - Alejandro Gaspar Vázquez",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _initializeGame,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reiniciar Juego',
          ),
        ],
      ),
      body: SizedBox.expand(
    
      ),
    );
  }
}
