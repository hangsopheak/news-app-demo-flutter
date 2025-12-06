// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmark_status_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isBookmarked)
const isBookmarkedProvider = IsBookmarkedFamily._();

final class IsBookmarkedProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, Stream<bool>>
    with $FutureModifier<bool>, $StreamProvider<bool> {
  const IsBookmarkedProvider._({
    required IsBookmarkedFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'isBookmarkedProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$isBookmarkedHash();

  @override
  String toString() {
    return r'isBookmarkedProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<bool> create(Ref ref) {
    final argument = this.argument as int;
    return isBookmarked(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is IsBookmarkedProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$isBookmarkedHash() => r'63643ba121e18d446d1457b76824ef1076419593';

final class IsBookmarkedFamily extends $Family
    with $FunctionalFamilyOverride<Stream<bool>, int> {
  const IsBookmarkedFamily._()
    : super(
        retry: null,
        name: r'isBookmarkedProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  IsBookmarkedProvider call(int articleId) =>
      IsBookmarkedProvider._(argument: articleId, from: this);

  @override
  String toString() => r'isBookmarkedProvider';
}
