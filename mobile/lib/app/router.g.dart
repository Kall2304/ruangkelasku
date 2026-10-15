// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Rute mengikuti Peta Layar di docs/design.md.

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// Rute mengikuti Peta Layar di docs/design.md.

final class RouterProvider extends $FunctionalProvider<GoRouter, GoRouter, GoRouter> with $Provider<GoRouter> {
  /// Rute mengikuti Peta Layar di docs/design.md.
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<GoRouter>(value));
  }
}

String _$routerHash() => r'a13a6f84f9b167cbe28a9070dcd4a5343a679b83';
