// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../model/product_details.dart';
import '../service/product_service.dart';

part 'product_details_view_model.g.dart';

class ProductDetailsViewModel = _ProductDetailsViewModel
    with _$ProductDetailsViewModel;

abstract class _ProductDetailsViewModel with Store {
  _ProductDetailsViewModel(this._productService, this.productId);

  final ProductService _productService;
  final int productId;

  @observable
  ProductDetails? product;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get hasError => errorMessage != null;

  @action
  Future<void> fetchProductDetails() async {
    isLoading = true;
    errorMessage = null;

    try {
      product = await _productService.fetchProductDetails(productId);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
    }
  }
}
