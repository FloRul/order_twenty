import 'package:flutter/material.dart';
import 'package:order_twenty/widgets/number_slot.dart';

class TogglesGrid extends StatefulWidget {
  const TogglesGrid({super.key, this.size = 20});
  final int size;
  @override
  State<TogglesGrid> createState() => _TogglesGridState();
}

class _TogglesGridState extends State<TogglesGrid> {
  List<Widget> _getTogglesNumber() => List.generate(
        20,
        (index) => NumberSlot(
          index: index,
        ),
      );

  @override
  void initState() {
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
