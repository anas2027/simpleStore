// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductDetailsViewModel on _ProductDetailsViewModel, Store {
  Computed<bool>? _$hasErrorComputed;

  @override
  bool get hasError => (_$hasErrorComputed ??= Computed<bool>(
    () => super.hasError,
    name: '_ProductDetailsViewModel.hasError',
  )).value;

  late final _$productAtom = Atom(
    name: '_ProductDetailsViewModel.product',
    context: context,
  );

  @override
  ProductDetails? get product {
    _$productAtom.reportRead();
    return super.product;
  }

  @override
  set product(ProductDetails? value) {
    _$productAtom.reportWrite(value, super.product, () {
      super.product = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_ProductDetailsViewModel.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_ProductDetailsViewModel.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$fetchProductDetailsAsyncAction = AsyncAction(
    '_ProductDetailsViewModel.fetchProductDetails',
    context: context,
  );

  @override
  Future<void> fetchProductDetails() {
    return _$fetchProductDetailsAsyncAction.run(
      () => super.fetchProductDetails(),
    );
  }

  @override
  String toString() {
    return '''
product: ${product},
isLoading: ${isLoading},
errorMessage: ${errorMessage},
hasError: ${hasError}
    ''';
  }
}
