import 'package:flutter/material.dart';

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
