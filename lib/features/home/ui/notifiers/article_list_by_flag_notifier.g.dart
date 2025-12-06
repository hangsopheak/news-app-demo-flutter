// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_list_by_flag_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ArticleListByFlagNotifier)
const articleListByFlagProvider = ArticleListByFlagNotifierFamily._();

final class ArticleListByFlagNotifierProvider
    extends $AsyncNotifierProvider<ArticleListByFlagNotifier, List<Article>> {
  const ArticleListByFlagNotifierProvider._({
    required ArticleListByFlagNotifierFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'articleListByFlagProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$articleListByFlagNotifierHash();

  @override
  String toString() {
    return r'articleListByFlagProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ArticleListByFlagNotifier create() => ArticleListByFlagNotifier();

  @override
  bool operator ==(Object other) {
    return other is ArticleListByFlagNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$articleListByFlagNotifierHash() =>
    r'e2c638d4b66029d144c59e39ad8a48cc98169c33';

final class ArticleListByFlagNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ArticleListByFlagNotifier,
          AsyncValue<List<Article>>,
          List<Article>,
          FutureOr<List<Article>>,
          int
        > {
  const ArticleListByFlagNotifierFamily._()
    : super(
        retry: null,
        name: r'articleListByFlagProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ArticleListByFlagNotifierProvider call(int flagId) =>
      ArticleListByFlagNotifierProvider._(argument: flagId, from: this);

  @override
  String toString() => r'articleListByFlagProvider';
}

abstract class _$ArticleListByFlagNotifier
    extends $AsyncNotifier<List<Article>> {
  late final _$args = ref.$arg as int;
  int get flagId => _$args;

  FutureOr<List<Article>> build(int flagId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<List<Article>>, List<Article>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Article>>, List<Article>>,
              AsyncValue<List<Article>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
