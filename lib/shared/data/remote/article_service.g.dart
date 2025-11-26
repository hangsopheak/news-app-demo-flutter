// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(articleService)
const articleServiceProvider = ArticleServiceProvider._();

final class ArticleServiceProvider
    extends $FunctionalProvider<ArticleService, ArticleService, ArticleService>
    with $Provider<ArticleService> {
  const ArticleServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'articleServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$articleServiceHash();

  @$internal
  @override
  $ProviderElement<ArticleService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ArticleService create(Ref ref) {
    return articleService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ArticleService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ArticleService>(value),
    );
  }
}

String _$articleServiceHash() => r'd992f24de08d3c28da6423cd90c28302ce8a87ea';
