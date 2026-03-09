// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AddProductViewModel on _AddProductViewModel, Store {
  late final _$isSubmittingAtom = Atom(
    name: '_AddProductViewModel.isSubmitting',
    context: context,
  );

  @override
  bool get isSubmitting {
    _$isSubmittingAtom.reportRead();
    return super.isSubmitting;
  }

  @override
  set isSubmitting(bool value) {
    _$isSubmittingAtom.reportWrite(value, super.isSubmitting, () {
      super.isSubmitting = value;
    });
  }

  late final _$submitProductAsyncAction = AsyncAction(
    '_AddProductViewModel.submitProduct',
    context: context,
  );

  @override
  Future<ProductDetails> submitProduct() {
    return _$submitProductAsyncAction.run(() => super.submitProduct());
  }

  @override
  String toString() {
    return '''
isSubmitting: ${isSubmitting}
    ''';
  }
}
