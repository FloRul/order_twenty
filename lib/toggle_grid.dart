import 'package:flutter/material.dart';

class TogglesGrid extends StatefulWidget {
  const TogglesGrid({super.key, this.size = 20});
  final int size;
  @override
  State<TogglesGrid> createState() => _TogglesGridState();
}

class _TogglesGridState extends State<TogglesGrid> {
  late final Map<int, int?> _slots;

  List<Widget> _getTogglesNumber() => List.generate(
        20,
        (index) => NumberTarget(
          index: index,
        ),
      );

  @override
  void initState() {
    _slots = List.filled(widget.size, null).asMap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runAlignment: WrapAlignment.spaceEvenly,
      alignment: WrapAlignment.spaceEvenly,
      runSpacing: 12,
      children: _getTogglesNumber().asMap().entries.map((widget) {
        return widget.value;
      }).toList(),
    );
  }
}

class NumberTarget extends StatefulWidget {
  const NumberTarget({
    super.key,
    required this.index,
    this.data,
  });
  final int index;
  final int? data;

  @override
  State<NumberTarget> createState() => _NumberTargetState();
}

class _NumberTargetState extends State<NumberTarget> {
  late int? _data;
  late bool _canAcceptData;

  @override
  void initState() {
    _data = widget.data;
    _canAcceptData = false;
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
