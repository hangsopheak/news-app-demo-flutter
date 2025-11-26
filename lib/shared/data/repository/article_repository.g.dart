// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(articleRepository)
const articleRepositoryProvider = ArticleRepositoryProvider._();

final class ArticleRepositoryProvider
    extends
        $FunctionalProvider<
          ArticleRepository,
          ArticleRepository,
          ArticleRepository
        >
    with $Provider<ArticleRepository> {
  const ArticleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'articleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$articleRepositoryHash();

  @$internal
  @override
  $ProviderElement<ArticleRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ArticleRepository create(Ref ref) {
    return articleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArticleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArticleRepository>(value),
    );
  }
}

String _$articleRepositoryHash() => r'ed32aa4573f849e9728b170119232dd39db4a48f';
