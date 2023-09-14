import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/widgets/animated_draggable.dart';
import 'package:order_twenty/widgets/bottom_bar.dart';
import 'package:order_twenty/widgets/dialogs/game_over_dialog.dart';
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
            barrierDismissible: false,
            context: context,
            builder: (context) => GameOverDialog(
              onResetPressed: () {
                notifier.reset();
                Navigator.of(context).pop();
              },
            ),
          );
        }
      },
    );
    return LayoutBuilder(builder: (_, cst) {
      const double size = 50;
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 48,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Number to order'.toUpperCase(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const SlotGrid().animate().slideX(begin: -1, end: 0),
            ),
          ),
          AnimatedDraggable(
            originalOffset: Offset(cst.maxWidth / 2 - size / 2, cst.maxHeight / 7),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomBar(),
          ),
        ],
      );
    });
  }
}
