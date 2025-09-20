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

  /// Inicializa el juego generando cartas y reiniciando variables
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

    
    if (_selectedIndices.length == 2) {
      _checkSelectedPair();
    }
  }

  void _checkSelectedPair() {
    final firstIndex = _selectedIndices[0];
    final secondIndex = _selectedIndices[1];

 
    if (_cardColors[firstIndex] != _cardColors[secondIndex]) {
      Future.delayed(const Duration(milliseconds: 800), () {
        if (!mounted) return;
        setState(() {
          _cardRevealed[firstIndex] = false;
          _cardRevealed[secondIndex] = false;
          _selectedIndices.clear();
        });
      });
    } else {
      
      _selectedIndices.clear();


      if (_cardRevealed.every((revealed) => revealed)) {
        _showGameFinishedMessage();
      }
    }
  }

  
  void _showGameFinishedMessage() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          '¡Felicidades! Has completado el Memorama.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        action: SnackBarAction(
          label: 'Reiniciar',
          onPressed: _initializeGame,
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildCard(int index) {
    return GestureDetector(
      onTap: () => _handleCardTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: _cardRevealed[index] ? _cardColors[index] : Colors.grey[400],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black26,
            width: 1.5,
          ),
        ),
      ),
    );
  }


  Widget _buildGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _cols,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: _cardColors.length,
      itemBuilder: (context, index) {
        return _buildCard(index);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Memorama(Examen-1) - Alejandro Gaspar Vázquez ",
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
        child: _buildGrid(),
      ),
    );
  }
}
