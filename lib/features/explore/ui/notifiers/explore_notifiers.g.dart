// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedCategoryNotifier)
const selectedCategoryProvider = SelectedCategoryNotifierProvider._();

final class SelectedCategoryNotifierProvider
    extends $NotifierProvider<SelectedCategoryNotifier, int?> {
  const SelectedCategoryNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedCategoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedCategoryNotifierHash();

  @$internal
  @override
  SelectedCategoryNotifier create() => SelectedCategoryNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int?>(value),
    );
  }
}

String _$selectedCategoryNotifierHash() =>
    r'5eb6acdffef438514854d06f828efa31ce0e129b';

abstract class _$SelectedCategoryNotifier extends $Notifier<int?> {
  int? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int?, int?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int?, int?>,
              int?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(exploreCategories)
const exploreCategoriesProvider = ExploreCategoriesProvider._();

final class ExploreCategoriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Category>>,
          List<Category>,
          FutureOr<List<Category>>
        >
    with $FutureModifier<List<Category>>, $FutureProvider<List<Category>> {
  const ExploreCategoriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exploreCategoriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exploreCategoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<Category>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Category>> create(Ref ref) {
    return exploreCategories(ref);
  }
}

String _$exploreCategoriesHash() => r'e898a710cf75257f414527509c56f5b5d2fc6468';

@ProviderFor(exploreArticles)
const exploreArticlesProvider = ExploreArticlesProvider._();

final class ExploreArticlesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          FutureOr<List<Article>>
        >
    with $FutureModifier<List<Article>>, $FutureProvider<List<Article>> {
  const ExploreArticlesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exploreArticlesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exploreArticlesHash();

  @$internal
  @override
  $FutureProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Article>> create(Ref ref) {
    return exploreArticles(ref);
  }
}

String _$exploreArticlesHash() => r'1d919477e476215b91c9792048db51207cb2f813';
