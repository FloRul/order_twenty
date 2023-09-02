import 'package:flutter/material.dart';

class NumberSlot extends StatefulWidget {
  const NumberSlot({
    super.key,
    required this.index,
    this.data,
  });
  final int index;
  final int? data;

  @override
  State<NumberSlot> createState() => _NumberSlotState();
}

class _NumberSlotState extends State<NumberSlot> {
  late int? _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onAccept: (data) => setState(() {
        _data = data;
      }),
      onMove: (details) => print('moving on #${widget.index} : ${details.offset}'),
      onLeave: (data) => print('leaving target #${widget.index}'),
      builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) => AnimatedContainer(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.onBackground),
            borderRadius: BorderRadius.circular(10)),
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
