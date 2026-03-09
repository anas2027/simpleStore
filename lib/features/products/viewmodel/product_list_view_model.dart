// ignore_for_file: library_private_types_in_public_api

import 'package:mobx/mobx.dart';

import '../model/product.dart';
import '../service/product_service.dart';

part 'product_list_view_model.g.dart';

class ProductListViewModel = _ProductListViewModel with _$ProductListViewModel;

abstract class _ProductListViewModel with Store {
  _ProductListViewModel(this._productService);

  final ProductService _productService;

  @observable
  ObservableList<Product> products = ObservableList<Product>();

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @computed
  bool get hasError => errorMessage != null;

  @action
  Future<void> fetchProducts(bool? refresh) async {
    isLoading = true;
    errorMessage = null;
    if (refresh == true) products.clear();
    try {
      final result = await _productService.fetchProducts();
      products = ObservableList<Product>.of(result);
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      isLoading = false;
    }
  }
}
