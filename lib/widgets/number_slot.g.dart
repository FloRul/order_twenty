// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_slot.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$slotStateHash() => r'a216d1c83fcc7c11060059bdf8535edee9daeab4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [slotState].
@ProviderFor(slotState)
const slotStateProvider = SlotStateFamily();

/// See also [slotState].
class SlotStateFamily extends Family<SlotState> {
  /// See also [slotState].
  const SlotStateFamily();

  /// See also [slotState].
  SlotStateProvider call(
    int index,
  ) {
    return SlotStateProvider(
      index,
    );
  }

  @override
  SlotStateProvider getProviderOverride(
    covariant SlotStateProvider provider,
  ) {
    return call(
      provider.index,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'slotStateProvider';
}

/// See also [slotState].
class SlotStateProvider extends AutoDisposeProvider<SlotState> {
  /// See also [slotState].
  SlotStateProvider(
    int index,
  ) : this._internal(
          (ref) => slotState(
            ref as SlotStateRef,
            index,
          ),
          from: slotStateProvider,
          name: r'slotStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$slotStateHash,
          dependencies: SlotStateFamily._dependencies,
          allTransitiveDependencies: SlotStateFamily._allTransitiveDependencies,
          index: index,
        );

  SlotStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.index,
  }) : super.internal();

  final int index;

  @override
  Override overrideWith(
    SlotState Function(SlotStateRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SlotStateProvider._internal(
        (ref) => create(ref as SlotStateRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        index: index,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<SlotState> createElement() {
    return _SlotStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SlotStateProvider && other.index == index;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, index.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SlotStateRef on AutoDisposeProviderRef<SlotState> {
  /// The parameter `index` of this provider.
  int get index;
}

class _SlotStateProviderElement extends AutoDisposeProviderElement<SlotState>
    with SlotStateRef {
  _SlotStateProviderElement(super.provider);

  @override
  int get index => (origin as SlotStateProvider).index;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
