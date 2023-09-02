import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required int currentNumber,
    required List<int?> slots,
    required Set<int> alreadyPickedNumbers,
    required int size,
  }) = _GameState;

  factory GameState.init([int size = 20]) {
    final first = Random().nextInt(1000);
    return GameState(
      size: size,
      slots: List.filled(size, null),
      currentNumber: first,
      alreadyPickedNumbers: {first},
    );
  }
}
