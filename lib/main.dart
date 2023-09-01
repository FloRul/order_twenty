import 'dart:math';

import 'package:flutter/material.dart';
import 'package:order_twenty/toggle_grid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order twenty',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const GamePage(title: 'Order twenty'),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key, required this.title});

  final String title;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late int _currentNumber;
  late final Set<int> _alreadyPickedNumbers = {};

  @override
  void initState() {
    _currentNumber = Random().nextInt(1000);
    _alreadyPickedNumbers.add(_currentNumber);
    super.initState();
  }

  void _setNextNumber() {
    int nextInt = Random().nextInt(1000);
    if (_alreadyPickedNumbers.contains(nextInt)) {
      do {
        nextInt = Random().nextInt(1000);
      } while (!_alreadyPickedNumbers.contains(nextInt));
    }
    setState(() {
      _alreadyPickedNumbers.add(nextInt);
      _currentNumber = nextInt;
    });
  }

  void _resetGame() {
    setState(() {
      _alreadyPickedNumbers.clear();
      _currentNumber = Random().nextInt(1000);
      _alreadyPickedNumbers.add(_currentNumber);
      _remainingToOrder = 19;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                const Text('Number to order:'),
                DraggableNumber(currentNumber: _currentNumber),
              ],
            ),
            const Expanded(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: TogglesGrid(),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _setNextNumber,
                    child: const Text('Next number'),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog.adaptive(
                          actionsAlignment: MainAxisAlignment.center,
                          content: const Text(
                            'The game will reset.\n Continue ?',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            FilledButton.tonal(
                              child: const Text('Yes'),
                              onPressed: () {
                                _resetGame();
                                Navigator.of(context).pop();
                              },
                            ),
                            FilledButton(
                              child: const Text('No'),
                              onPressed: () {
                                _resetGame();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class DraggableNumber extends StatelessWidget {
  const DraggableNumber({
    super.key,
    required int currentNumber,
  }) : _currentNumber = currentNumber;

  final int _currentNumber;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Draggable<int>(
        data: _currentNumber,
        feedback: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Material(
            child: Container(
              width: 50,
              height: 50,
              color: Theme.of(context).colorScheme.secondaryContainer,
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  _currentNumber.toString(),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        child: Material(
          child: Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            padding: const EdgeInsets.all(8),
            child: Text(
              _currentNumber.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
