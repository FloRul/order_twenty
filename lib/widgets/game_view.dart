﻿import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/widgets/bottom_bar.dart';
import 'package:order_twenty/widgets/draggable_number.dart';
import 'package:order_twenty/widgets/slot_grid.dart';

class GameView extends ConsumerWidget {
  const GameView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(gameControllerNotifierProvider.notifier);
    ref.listen(
      gameControllerNotifierProvider.select((value) => value.currentNumber),
      (previous, next) {
        if (ref.read(gameControllerNotifierProvider.notifier).availableSlots.isEmpty) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog.adaptive(
              actionsAlignment: MainAxisAlignment.center,
              content: const Text(
                'Game over',
                textAlign: TextAlign.center,
              ),
              actions: [
                IconButton.filledTonal(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    notifier.reset();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      },
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 16),
            const Text('Number to order:'),
            DraggableNumber(
              initialNumber: ref.watch(gameControllerNotifierProvider.select(
                (value) => value.currentNumber,
              )),
            ),
          ],
        ),
        const Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SlotGrid(),
            ),
          ),
        ),
        const BottomBar(),
      ],
    );
  }
}
