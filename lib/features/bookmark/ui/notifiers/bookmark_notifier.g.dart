// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BookmarkNotifier)
const bookmarkProvider = BookmarkNotifierProvider._();

final class BookmarkNotifierProvider
    extends $AsyncNotifierProvider<BookmarkNotifier, List<Article>> {
  const BookmarkNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkNotifierHash();

  @$internal
  @override
  BookmarkNotifier create() => BookmarkNotifier();
}

String _$bookmarkNotifierHash() => r'f156be661e81b83bfad50f2250e09cd717b349bf';

abstract class _$BookmarkNotifier extends $AsyncNotifier<List<Article>> {
  FutureOr<List<Article>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
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
