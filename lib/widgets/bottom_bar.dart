import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/widgets/dialogs/reset_game_dialog.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(gameControllerNotifierProvider.notifier);
    return Container(
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
            onPressed: notifier.setNextNumber,
            child: const Text('Next number'),
          ),
          const SizedBox(width: 8),
          IconButton.filled(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              showGeneralDialog(
                barrierDismissible: false,
                context: context,
                pageBuilder: (context, a1, a2) => ResetGameDialog(
                  onResetAccepted: () {
                    notifier.reset();
                    Navigator.of(context).pop();
                  },
                  onResetDenied: () => Navigator.of(context).pop(),
                ),
                transitionBuilder: (context, a1, a2, child) => FadeTransition(
                  opacity: a1,
                  child: Transform.translate(
                    offset: Offset(0, a1.value * -100),
                    child: child,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
