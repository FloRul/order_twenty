import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/game_controller.dart';
import 'package:order_twenty/widgets/number_slot.dart';

class SlotGrid extends ConsumerWidget {
  const SlotGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(gameControllerNotifierProvider);

    return WrapSuper(
      alignment: WrapSuperAlignment.center,
      wrapType: WrapType.balanced,
      lineSpacing: 16,
      spacing: 16,
      children: List.generate(
        controller.size,
        (index) => SlotNumber(index: index),
      ).asMap().entries.map((widget) {
        return widget.value;
      }).toList(),
    );
  }
}
