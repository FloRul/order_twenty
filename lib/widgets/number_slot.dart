import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/providers/theme_controller.dart';
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

class SlotNumber extends ConsumerStatefulWidget {
  const SlotNumber({super.key, required this.index});
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SlotNumberState();
}

class _SlotNumberState extends ConsumerState<SlotNumber> {
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
    final scheme = ref.watch(themeControllerProvider.notifier).colorScheme;
    var notifier = ref.read(gameControllerNotifierProvider.notifier);
    var gameState = ref.watch(gameControllerNotifierProvider);
    var slotState = ref.watch(slotStateProvider(widget.index));
    return DragTarget<int>(
      onAccept: (data) {
        notifier.putNumber(widget.index);
        setState(() {
          _onHovered = false;
        });
      },
      onWillAccept: (data) => notifier.availableSlots.contains(widget.index),
      onMove: (_) => setState(() {
        _onHovered = true;
      }),
      onLeave: (_) => setState(() {
        _onHovered = false;
      }),
      builder: (context, candidateData, rejectedData) {
        return AnimatedContainer(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.onBackground),
              borderRadius: BorderRadius.circular(10),
              color: switch (slotState) {
                SlotState.idle => scheme.primary,
                SlotState.accepted => scheme.primaryContainer,
                SlotState.candidate => _onHovered ? scheme.tertiary : scheme.secondary,
              }
              // _data != null ? scheme.onPrimary : scheme.inversePrimary,
              ),
          duration: const Duration(milliseconds: 200),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    (widget.index + 1).toString(),
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
              ),
              Visibility(
                visible: gameState.slots[widget.index] != null,
                child: Center(child: Text(gameState.slots[widget.index]?.toString() ?? '')),
              )
            ],
          ),
        );
      },
    );
  }
}
