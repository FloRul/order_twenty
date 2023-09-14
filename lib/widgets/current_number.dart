import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final scheme = Theme.of(context).colorScheme;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: scheme.onInverseSurface.withOpacity(.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Text(
              number.toString(),
              style: GoogleFonts.playTextTheme.call().bodyMedium!.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: scheme.onBackground,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
