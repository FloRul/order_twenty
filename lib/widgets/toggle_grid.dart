import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/widgets/number_slot.dart';

class TogglesGrid extends ConsumerWidget {
  const TogglesGrid({super.key});

  List<Widget> _getTogglesNumber() => List.generate(
        20,
        (index) => NumberSlot(
          index: index,
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(gameControllerNotifierProvider);
    return Wrap(
      spacing: 12,
      runAlignment: WrapAlignment.spaceEvenly,
      alignment: WrapAlignment.spaceEvenly,
      runSpacing: 12,
      children: List.generate(
        controller.size,
        (index) => NumberSlot(
          index: index,
        ),
      ).asMap().entries.map((widget) {
        return widget.value;
      }).toList(),
    );
  }
}
