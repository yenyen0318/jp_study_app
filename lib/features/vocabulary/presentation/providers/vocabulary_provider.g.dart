// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vocabulary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$vocabularyRepositoryHash() =>
    r'38627afe88835502aa3c3359b3f41bf96272c537';

/// See also [vocabularyRepository].
@ProviderFor(vocabularyRepository)
final vocabularyRepositoryProvider =
    AutoDisposeProvider<VocabularyRepository>.internal(
      vocabularyRepository,
      name: r'vocabularyRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$vocabularyRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VocabularyRepositoryRef = AutoDisposeProviderRef<VocabularyRepository>;
String _$vocabularyAvailableTagsHash() =>
    r'7f1a9e12d4ba0a1fe2696046929822fdf2aef4c0';

/// 動態提取目前單字庫中除了 'N5' 以外的所有標籤
///
/// Copied from [vocabularyAvailableTags].
@ProviderFor(vocabularyAvailableTags)
final vocabularyAvailableTagsProvider =
    AutoDisposeProvider<List<String>>.internal(
      vocabularyAvailableTags,
      name: r'vocabularyAvailableTagsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$vocabularyAvailableTagsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VocabularyAvailableTagsRef = AutoDisposeProviderRef<List<String>>;
String _$vocabularySearchQueryHash() =>
    r'11960d6cd2c29037f469d61e87b7a15c5a5c9c6f';

/// See also [VocabularySearchQuery].
@ProviderFor(VocabularySearchQuery)
final vocabularySearchQueryProvider =
    AutoDisposeNotifierProvider<VocabularySearchQuery, String>.internal(
      VocabularySearchQuery.new,
      name: r'vocabularySearchQueryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$vocabularySearchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VocabularySearchQuery = AutoDisposeNotifier<String>;
String _$vocabularyFilterHash() => r'31949d3b6ccfce0d52c5c5ceec4261de332065b6';

/// See also [VocabularyFilter].
@ProviderFor(VocabularyFilter)
final vocabularyFilterProvider =
    AutoDisposeNotifierProvider<VocabularyFilter, String?>.internal(
      VocabularyFilter.new,
      name: r'vocabularyFilterProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$vocabularyFilterHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VocabularyFilter = AutoDisposeNotifier<String?>;
String _$vocabularyNotifierHash() =>
    r'080f3ac7c04f49df0c126759a894f23bbd9ae9a4';

/// See also [VocabularyNotifier].
@ProviderFor(VocabularyNotifier)
final vocabularyNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      VocabularyNotifier,
      List<Vocabulary>
    >.internal(
      VocabularyNotifier.new,
      name: r'vocabularyNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$vocabularyNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$VocabularyNotifier = AutoDisposeAsyncNotifier<List<Vocabulary>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
