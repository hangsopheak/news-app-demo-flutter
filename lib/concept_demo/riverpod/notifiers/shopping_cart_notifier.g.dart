// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShoppingCartNotifier)
const shoppingCartProvider = ShoppingCartNotifierProvider._();

final class ShoppingCartNotifierProvider
    extends $NotifierProvider<ShoppingCartNotifier, List<CartItem>> {
  const ShoppingCartNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shoppingCartProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shoppingCartNotifierHash();

  @$internal
  @override
  ShoppingCartNotifier create() => ShoppingCartNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CartItem> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CartItem>>(value),
    );
  }
}

String _$shoppingCartNotifierHash() =>
    r'd6a6ca0fc39e7f5e0453aff60a2389b7867be84b';

abstract class _$ShoppingCartNotifier extends $Notifier<List<CartItem>> {
  List<CartItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<CartItem>, List<CartItem>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CartItem>, List<CartItem>>,
              List<CartItem>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
