import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';

class NumberSlot extends ConsumerStatefulWidget {
  const NumberSlot({required this.index, super.key});

  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NumberSlotState();
}

class _NumberSlotState extends ConsumerState<NumberSlot> {
  late int? _data;

  @override
  void initState() {
    _data = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    var notifier = ref.read(gameControllerNotifierProvider.notifier);
    return DragTarget<int>(
      onAccept: (data) {
        setState(() {
          _data = data;
        });
        notifier.putNumber(widget.index);
      },
      onWillAccept: (data) => notifier.availableSlots.contains(widget.index),
      onMove: (details) => print('moving on #${widget.index} : ${details.offset}'),
      onLeave: (data) => print('leaving target #${widget.index}'),
      builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) => AnimatedContainer(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.onBackground),
          borderRadius: BorderRadius.circular(10),
          color: _data != null ? scheme.onPrimary : scheme.background,
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
              visible: _data != null,
              child: Center(child: Text(_data?.toString() ?? '')),
            )
          ],
        ),
      ),
    );
  }
}
