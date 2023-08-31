import 'package:flutter/material.dart';

class TogglesGrid extends StatefulWidget {
  const TogglesGrid({super.key});

  @override
  State<TogglesGrid> createState() => _TogglesGridState();
}

class _TogglesGridState extends State<TogglesGrid> {
  List<Widget> _getTogglesNumber() => List.generate(
        20,
        (index) => DragTarget<int>(
          builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) => Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      );

  final List<bool> _selected = List.filled(20, false);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runAlignment: WrapAlignment.spaceEvenly,
      alignment: WrapAlignment.spaceEvenly,
      runSpacing: 12,
      children: _getTogglesNumber().asMap().entries.map((widget) {
        return ToggleButtons(
          constraints: BoxConstraints.tight(const Size(50, 50)),
          borderRadius: BorderRadius.circular(10),
          selectedColor: Colors.red,
          isSelected: [_selected[widget.key]],
          onPressed: (_) {},
          children: [widget.value],
        );
      }).toList(),
    );
  }
}
