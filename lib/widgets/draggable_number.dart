import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';

class DraggableNumber extends ConsumerWidget {
  const DraggableNumber({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(gameControllerNotifierProvider);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Draggable<int>(
        data: controller.currentNumber,
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
                  controller.currentNumber.toString(),
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
              controller.currentNumber.toString(),
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
