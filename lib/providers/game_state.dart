import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required int currentNumber,
    required Set<int> alreadyPickedNumbers,
  }) = _GameState;

  factory GameState.init() => GameState(
        alreadyPickedNumbers: {},
        currentNumber: Random().nextInt(1000),
      );
}
