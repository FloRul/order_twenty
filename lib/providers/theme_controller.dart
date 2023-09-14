import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  (ThemeData, ThemeData) build() {
    return (
      FlexThemeData.light(
        scheme: FlexScheme.deepOrangeM3,
      ).copyWith(textTheme: GoogleFonts.playTextTheme()),
      FlexThemeData.dark(scheme: FlexScheme.deepOrangeM3).copyWith(
        textTheme: GoogleFonts.playTextTheme(),
      ),
    );
  }
}
