import 'dart:math';

import 'package:order_twenty/providers/game_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'game_controller.g.dart';

@riverpod
class GameControllerNotifier extends _$GameControllerNotifier {
  @override
  GameState build() {
    return GameState.init();
  }

  void setNextNumber() => state = state.copyWith(currentNumber: Random().nextInt(1000));
}
