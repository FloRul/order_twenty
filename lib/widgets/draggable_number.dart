import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';

class DraggableNumber extends ConsumerStatefulWidget {
  const DraggableNumber({
    super.key,
    required this.initialNumber,
  });
  final int initialNumber;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DraggableNumberState();
}

class _DraggableNumberState extends ConsumerState<DraggableNumber> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _currentNumber = widget.initialNumber;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    ref.listenManual(
      gameControllerNotifierProvider.select(
        (value) => value.currentNumber,
      ),
      (previous, next) => setState(() {
        _currentNumber = next;
        _controller.reset();
        _controller.forward();
      }),
    );
    super.initState();
  }

  int? _currentNumber;
  late AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(gameControllerNotifierProvider.notifier);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Draggable<int>(
        onDragStarted: () => notifier.dragging = true,
        onDragEnd: (_) => notifier.dragging = false,
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
            width: 75,
            height: 75,
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
        )
            .animate(controller: _controller)
            .flip(direction: Random().nextBool() ? Axis.vertical : Axis.horizontal, curve: Curves.easeOut),
      ),
    );
  }
}
