import 'package:flutter/material.dart';

class Memorama extends StatefulWidget {
  const Memorama({super.key});

  @override
  State<Memorama> createState() => _MemoramaState();
}

class _MemoramaState extends State<Memorama> {
  // Aquí va toda la lógica del juego, por ejemplo:
  List<String> cards = ['A', 'B', 'C', 'A', 'B', 'C'];
  List<bool> flipped = [];

  @override
  void initState() {
    super.initState();
    flipped = List.filled(cards.length, false);
    cards.shuffle();
  }

  void flipCard(int index) {
    setState(() {
      flipped[index] = !flipped[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Memorama')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => flipCard(index),
            child: Container(
              color: Colors.blue,
              alignment: Alignment.center,
              child: flipped[index] ? Text(cards[index], style: const TextStyle(fontSize: 24, color: Colors.white)) : const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}

