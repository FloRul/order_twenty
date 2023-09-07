import 'package:flutter/material.dart';

class GameOverDialog extends StatelessWidget {
  const GameOverDialog({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.center,
      content: const Text(
        'Game over',
        textAlign: TextAlign.center,
      ),
      actions: [
        IconButton.filledTonal(
          icon: const Icon(Icons.refresh),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
