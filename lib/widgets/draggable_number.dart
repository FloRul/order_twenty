import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/providers/theme_controller.dart';

class DraggableNumber extends StatefulHookConsumerWidget {
  const DraggableNumber({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DraggableNumberState();
}

class _DraggableNumberState extends ConsumerState<DraggableNumber> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    var flipController = useAnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    var fadeScaleController = useAnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    var runFadeScaleDown = useState<bool>(false);
    runFadeScaleDown.addListener(
      () {
        if (runFadeScaleDown.value) {
          fadeScaleController.repeat();
        } else {
          fadeScaleController.stop();
        }
      },
    );
    ref.listen(
      gameControllerNotifierProvider.select(
        (value) => value.currentNumber,
      ),
      (_, __) => setState(() {
        flipController.reset();
        flipController.forward();
        runFadeScaleDown.value = !runFadeScaleDown.value;
      }),
    );

    final currentNumber = ref.watch(gameControllerNotifierProvider.select((value) => value.currentNumber));
    final notifier = ref.read(gameControllerNotifierProvider.notifier);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Draggable<int>(
        onDragStarted: () => notifier.dragging = true,
        onDragEnd: (_) => notifier.dragging = false,
        data: currentNumber,
        onDragCompleted: () => setState(() {
          fadeScaleController.reset();
          fadeScaleController.forward();
        }),
        feedback: CurrentNumber(
          number: currentNumber,
        )
            .animate(
              autoPlay: false,
              controller: fadeScaleController,
            )
            .fadeOut(begin: 1)
            .scaleXY(
              begin: 1,
              end: 0,
            ),
        child: CurrentNumber(
          number: currentNumber,
        )
            .animate(controller: flipController)
            .flip(direction: Random().nextBool() ? Axis.vertical : Axis.horizontal, curve: Curves.easeOut),
      ),
    );
  }
}

class CurrentNumber extends ConsumerWidget {
  const CurrentNumber({required this.number, super.key});
  final int number;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = ref.watch(themeControllerProvider.notifier).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              color: scheme.background,
              border: Border.all(
                color: scheme.primary,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
