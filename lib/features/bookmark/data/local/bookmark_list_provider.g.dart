// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookmarkList)
const bookmarkListProvider = BookmarkListProvider._();

final class BookmarkListProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Article>>,
          List<Article>,
          FutureOr<List<Article>>
        >
    with $FutureModifier<List<Article>>, $FutureProvider<List<Article>> {
  const BookmarkListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkListHash();

  @$internal
  @override
  $FutureProviderElement<List<Article>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Article>> create(Ref ref) {
    return bookmarkList(ref);
  }
}

String _$bookmarkListHash() => r'd0b50b0a2a304a3f83e2d2a120d58134cd1c3657';
