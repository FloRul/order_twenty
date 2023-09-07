import 'package:flutter/material.dart';

class ResetGameDialog extends StatelessWidget {
  const ResetGameDialog({super.key, required this.onResetAccepted, required this.onResetDenied});
  final VoidCallback onResetAccepted;
  final VoidCallback onResetDenied;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      actionsAlignment: MainAxisAlignment.center,
      content: const Text(
        'The game will reset.\n Continue ?',
        textAlign: TextAlign.center,
      ),
      actions: [
        FilledButton.tonal(
          onPressed: onResetAccepted,
          child: const Text('Yes'),
        ),
        FilledButton(
          onPressed: onResetDenied,
          child: const Text('No'),
        ),
      ],
    );
  }
}
