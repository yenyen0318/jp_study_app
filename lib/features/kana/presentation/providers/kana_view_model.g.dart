// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kana_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$kanaRepositoryHash() => r'fa7c6593aaf5527fdf7c89ca7786d9618a20746c';

/// See also [kanaRepository].
@ProviderFor(kanaRepository)
final kanaRepositoryProvider = AutoDisposeProvider<KanaRepository>.internal(
  kanaRepository,
  name: r'kanaRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$kanaRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef KanaRepositoryRef = AutoDisposeProviderRef<KanaRepository>;
String _$kanaListViewModelHash() => r'bc0c072d814ee9ac5baf0663a7b5df762188e28e';

/// See also [KanaListViewModel].
@ProviderFor(KanaListViewModel)
final kanaListViewModelProvider =
    AutoDisposeAsyncNotifierProvider<KanaListViewModel, List<Kana>>.internal(
      KanaListViewModel.new,
      name: r'kanaListViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$kanaListViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$KanaListViewModel = AutoDisposeAsyncNotifier<List<Kana>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
