// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameState {
  int get currentNumber => throw _privateConstructorUsedError;
  List<int?> get slots => throw _privateConstructorUsedError;
  Set<int> get alreadyPickedNumbers => throw _privateConstructorUsedError;
  int get size => throw _privateConstructorUsedError;
  bool get dragging => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {int currentNumber,
      List<int?> slots,
      Set<int> alreadyPickedNumbers,
      int size,
      bool dragging});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentNumber = null,
    Object? slots = null,
    Object? alreadyPickedNumbers = null,
    Object? size = null,
    Object? dragging = null,
  }) {
    return _then(_value.copyWith(
      currentNumber: null == currentNumber
          ? _value.currentNumber
          : currentNumber // ignore: cast_nullable_to_non_nullable
              as int,
      slots: null == slots
          ? _value.slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<int?>,
      alreadyPickedNumbers: null == alreadyPickedNumbers
          ? _value.alreadyPickedNumbers
          : alreadyPickedNumbers // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      dragging: null == dragging
          ? _value.dragging
          : dragging // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GameStateCopyWith<$Res> implements $GameStateCopyWith<$Res> {
  factory _$$_GameStateCopyWith(
          _$_GameState value, $Res Function(_$_GameState) then) =
      __$$_GameStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int currentNumber,
      List<int?> slots,
      Set<int> alreadyPickedNumbers,
      int size,
      bool dragging});
}

/// @nodoc
class __$$_GameStateCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$_GameState>
    implements _$$_GameStateCopyWith<$Res> {
  __$$_GameStateCopyWithImpl(
      _$_GameState _value, $Res Function(_$_GameState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentNumber = null,
    Object? slots = null,
    Object? alreadyPickedNumbers = null,
    Object? size = null,
    Object? dragging = null,
  }) {
    return _then(_$_GameState(
      currentNumber: null == currentNumber
          ? _value.currentNumber
          : currentNumber // ignore: cast_nullable_to_non_nullable
              as int,
      slots: null == slots
          ? _value._slots
          : slots // ignore: cast_nullable_to_non_nullable
              as List<int?>,
      alreadyPickedNumbers: null == alreadyPickedNumbers
          ? _value._alreadyPickedNumbers
          : alreadyPickedNumbers // ignore: cast_nullable_to_non_nullable
              as Set<int>,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as int,
      dragging: null == dragging
          ? _value.dragging
          : dragging // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_GameState implements _GameState {
  const _$_GameState(
      {required this.currentNumber,
      required final List<int?> slots,
      required final Set<int> alreadyPickedNumbers,
      required this.size,
      required this.dragging})
      : _slots = slots,
        _alreadyPickedNumbers = alreadyPickedNumbers;

  @override
  final int currentNumber;
  final List<int?> _slots;
  @override
  List<int?> get slots {
    if (_slots is EqualUnmodifiableListView) return _slots;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_slots);
  }

  final Set<int> _alreadyPickedNumbers;
  @override
  Set<int> get alreadyPickedNumbers {
    if (_alreadyPickedNumbers is EqualUnmodifiableSetView)
      return _alreadyPickedNumbers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_alreadyPickedNumbers);
  }

  @override
  final int size;
  @override
  final bool dragging;

  @override
  String toString() {
    return 'GameState(currentNumber: $currentNumber, slots: $slots, alreadyPickedNumbers: $alreadyPickedNumbers, size: $size, dragging: $dragging)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GameState &&
            (identical(other.currentNumber, currentNumber) ||
                other.currentNumber == currentNumber) &&
            const DeepCollectionEquality().equals(other._slots, _slots) &&
            const DeepCollectionEquality()
                .equals(other._alreadyPickedNumbers, _alreadyPickedNumbers) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.dragging, dragging) ||
                other.dragging == dragging));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      currentNumber,
      const DeepCollectionEquality().hash(_slots),
      const DeepCollectionEquality().hash(_alreadyPickedNumbers),
      size,
      dragging);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      __$$_GameStateCopyWithImpl<_$_GameState>(this, _$identity);
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {required final int currentNumber,
      required final List<int?> slots,
      required final Set<int> alreadyPickedNumbers,
      required final int size,
      required final bool dragging}) = _$_GameState;

  @override
  int get currentNumber;
  @override
  List<int?> get slots;
  @override
  Set<int> get alreadyPickedNumbers;
  @override
  int get size;
  @override
  bool get dragging;
  @override
  @JsonKey(ignore: true)
  _$$_GameStateCopyWith<_$_GameState> get copyWith =>
      throw _privateConstructorUsedError;
}
