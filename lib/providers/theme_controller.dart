import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  (ThemeData, ThemeData) build() {
    return (
      FlexThemeData.light(
        scheme: FlexScheme.deepBlue,
      ),
      FlexThemeData.dark(scheme: FlexScheme.deepBlue)
    );
  }

  ColorScheme get colorScheme {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.light ? state.$1.colorScheme : state.$2.colorScheme;
  }
}
