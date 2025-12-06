// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bookmarkRepository)
const bookmarkRepositoryProvider = BookmarkRepositoryProvider._();

final class BookmarkRepositoryProvider
    extends
        $FunctionalProvider<
          BookmarkRepository,
          BookmarkRepository,
          BookmarkRepository
        >
    with $Provider<BookmarkRepository> {
  const BookmarkRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bookmarkRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bookmarkRepositoryHash();

  @$internal
  @override
  $ProviderElement<BookmarkRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BookmarkRepository create(Ref ref) {
    return bookmarkRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BookmarkRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BookmarkRepository>(value),
    );
  }
}

String _$bookmarkRepositoryHash() =>
    r'57c5a2c2197b7f62d4aba64306a677fdbaf73f2b';
