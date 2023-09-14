import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'number_slot.g.dart';

@riverpod
SlotState slotState(SlotStateRef ref, int index) {
  var isDragging = ref.watch(
    gameControllerNotifierProvider.select(
      (value) => value.dragging,
    ),
  );

  var availableSlots = ref.watch(
    gameControllerNotifierProvider.notifier.select(
      (value) => value.availableSlots,
    ),
  );

  var slots = ref.watch(
    gameControllerNotifierProvider.select(
      (value) => value.slots,
    ),
  );
  var canReceive = availableSlots.contains(index);
  var hasAccepted = slots[index] != null;
  var res = switch ((isDragging, canReceive, hasAccepted)) {
    (true, true, false) => SlotState.candidate,
    (_, _, true) => SlotState.accepted,
    (_, _, false) => SlotState.idle,
  };
  return res;
}

enum SlotState {
  idle,
  candidate,
  accepted,
}

class SlotNumber extends StatefulHookConsumerWidget {
  const SlotNumber({super.key, required this.index});
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SlotNumberState();
}

class _SlotNumberState extends ConsumerState<SlotNumber> with SingleTickerProviderStateMixin {
  late bool _onHovered;

  @override
  void initState() {
    _onHovered = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _onHovered = false;
  }

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(vsync: this, duration: 1.seconds);
    final scheme = Theme.of(context).colorScheme;
    var notifier = ref.read(gameControllerNotifierProvider.notifier);
    var gameState = ref.watch(gameControllerNotifierProvider);
    var slotState = ref.watch(slotStateProvider(widget.index));
    return DragTarget<int>(
      onAccept: (data) {
        notifier.putNumber(widget.index);
        controller.reset();
        setState(() {
          _onHovered = false;
        });
      },
      onWillAccept: (data) => notifier.availableSlots.contains(widget.index),
      onMove: (_) {
        setState(() {
          _onHovered = true;
        });
      },
      onLeave: (_) => setState(() {
        _onHovered = false;
        controller.reset();
      }),
      builder: (context, candidateData, rejectedData) {
        if (candidateData.isNotEmpty) {
          controller.repeat(period: 500.milliseconds, reverse: true);
        } else {
          controller.stop();
        }
        return AnimatedContainer(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: switch (slotState) {
                SlotState.idle => scheme.surfaceVariant,
                SlotState.accepted => scheme.primaryContainer,
                SlotState.candidate => _onHovered ? scheme.outline : scheme.outlineVariant,
              }),
          duration: const Duration(milliseconds: 200),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    (widget.index + 1).toString(),
                    style: TextStyle(fontSize: 10, color: scheme.onBackground),
                  ),
                ),
              ),
              Visibility(
                visible: gameState.slots[widget.index] != null,
                child: Center(
                  child: Text(
                    gameState.slots[widget.index]?.toString() ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold, color: scheme.onBackground),
                  ),
                ),
              )
            ],
          ),
        )
            .animate(
              controller: controller,
              autoPlay: false,
            )
            .scaleXY(begin: 1, end: 1.2);
      },
    );
  }
}
