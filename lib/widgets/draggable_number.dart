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

class _DraggableNumberState extends ConsumerState<DraggableNumber> {
  @override
  void initState() {
    _currentNumber = widget.initialNumber;
    super.initState();
  }

  int? _currentNumber;

  @override
  Widget build(BuildContext context) {
    ref.listen(
      gameControllerNotifierProvider.select(
        (value) => value.currentNumber,
      ),
      (previous, next) => setState(() {
        _currentNumber = next;
      }),
    );
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
        child:  Material(
            child: Container(
              width: 75,
              height: 75,
              color: Theme.of(context).colorScheme.secondaryContainer,
              padding: const EdgeInsets.all(8),
              child: Text(
                _currentNumber.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ).animate().rotate(),
        ),
    );
  }
}
