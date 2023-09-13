import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/widgets/current_number.dart';

class AnimatedDraggable extends StatefulHookConsumerWidget {
  const AnimatedDraggable({
    Key? key,
    required this.originalOffset,
  }) : super(key: key);
  final Offset originalOffset;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => AnimatedDraggableState();
}

class AnimatedDraggableState extends ConsumerState<AnimatedDraggable> with TickerProviderStateMixin {
  late double x;
  late double y;
  Duration animationDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    x = widget.originalOffset.dx;
    y = widget.originalOffset.dy;
  }

  @override
  Widget build(BuildContext context) {
    var flipController = useAnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    var fadeScaleController = useAnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    var runFadeScaleDown = useState<bool>(false);
    runFadeScaleDown.addListener(
      () {
        if (runFadeScaleDown.value) {
          fadeScaleController.reset();
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
    return AnimatedPositioned(
      left: x,
      top: y,
      duration: animationDuration,
      child: Draggable<int>(
        onDragStarted: () => notifier.dragging = true,
        data: currentNumber,
        onDragUpdate: (details) {
          setState(() {
            animationDuration = Duration.zero;
            x += details.delta.dx;
            y += details.delta.dy;
          });
        },
        onDragEnd: (details) {
          if (details.wasAccepted) {
            setState(() {
              fadeScaleController.reset();
              fadeScaleController.forward();
            });
          }
          animationDuration = details.wasAccepted
              ? Duration.zero
              : const Duration(
                  milliseconds: 200,
                );
          notifier.dragging = false;
          setState(() {
            x = widget.originalOffset.dx;
            y = widget.originalOffset.dy;
          });
        },
        feedback: CurrentNumber(
          number: currentNumber,
          size: 50,
        ).animate(
          controller: fadeScaleController,
          autoPlay: false,
        ),
        childWhenDragging: ref.watch(gameControllerNotifierProvider.select((value) => value.dragging))
            ? const SizedBox.shrink()
            : CurrentNumber(
                number: currentNumber,
                size: 50,
              ),
        child: CurrentNumber(
          number: currentNumber,
          size: 50,
        ).animate(controller: flipController).flip(
              direction: Random().nextBool() ? Axis.vertical : Axis.horizontal,
              curve: Curves.easeOut,
            ),
      ),
    );
  }
}
