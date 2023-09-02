import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';

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
                        notifier.reset();
                        Navigator.of(context).pop();
                      },
                    ),
                    FilledButton(
                      child: const Text('No'),
                      onPressed: () {
                        notifier.reset();
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
    );
  }
}
