// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeNotifier)
const homeProvider = HomeNotifierProvider._();

final class HomeNotifierProvider
    extends $AsyncNotifierProvider<HomeNotifier, HomeUiState> {
  const HomeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeNotifierHash();

  @$internal
  @override
  HomeNotifier create() => HomeNotifier();
}

String _$homeNotifierHash() => r'f139e2c60f5868d55c584aa8caeb7db9d59f2ebb';

abstract class _$HomeNotifier extends $AsyncNotifier<HomeUiState> {
  FutureOr<HomeUiState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<HomeUiState>, HomeUiState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeUiState>, HomeUiState>,
              AsyncValue<HomeUiState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
