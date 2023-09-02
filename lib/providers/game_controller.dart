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

  List<int> get availableSlots {
    List<int> res = [];

    final lastMinor = state.slots.lastIndexWhere((element) => element != null && element < state.currentNumber);
    final firstMajor = state.slots.indexWhere((element) => element != null && element > state.currentNumber);

    res = switch ((lastMinor, firstMajor)) {
      (-1, -1) => List.generate(state.size, (index) => index),
      (-1, _) => List.generate(
          firstMajor,
          (index) => index,
        ),
      (_, -1) => List.generate(
          state.size - lastMinor,
          (index) => lastMinor + index,
        ),
      (_, _) => List.generate(
          firstMajor - lastMinor - 1,
          (index) => lastMinor + index + 1,
        ),
    };

    return res;
  }

  void putNumber(int index) {
    state = state.copyWith(
      slots: [
        for (int i = 0; i < state.slots.length; i++)
          if (index == i) state.currentNumber else state.slots[i]
      ],
    );
    setNextNumber();
  }

  set dragging(bool value) => state = state.copyWith(dragging: value);
}
