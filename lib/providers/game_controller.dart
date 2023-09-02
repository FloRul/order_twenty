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

  void setNextNumber() {
    int nextInt = Random().nextInt(1000);
    if (state.alreadyPickedNumbers.contains(nextInt)) {
      do {
        nextInt = Random().nextInt(1000);
      } while (!state.alreadyPickedNumbers.contains(nextInt));
    }
    state = state.copyWith(
      currentNumber: nextInt,
      alreadyPickedNumbers: Set.from(state.alreadyPickedNumbers)..add(nextInt),
    );
  }

  void reset() => state = GameState.init();
}
