import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order_twenty/providers/theme_controller.dart';

class CurrentNumber extends ConsumerWidget {
  const CurrentNumber({
    required this.number,
    required this.size,
    super.key,
  });
  final int number;
  final double size;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = ref.watch(themeControllerProvider.notifier).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Material(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              color: scheme.background,
              border: Border.all(
                color: scheme.primary,
                width: 5,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
