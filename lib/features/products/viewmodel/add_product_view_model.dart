// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../model/product_details.dart';
import '../service/product_service.dart';

part 'add_product_view_model.g.dart';

class AddProductViewModel = _AddProductViewModel with _$AddProductViewModel;

abstract class _AddProductViewModel with Store {
  final ProductService _productService = ProductService();
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final imageController = TextEditingController();
  final descriptionController = TextEditingController();

  @observable
  bool isSubmitting = false;

  void dispose() {
    titleController.dispose();
    priceController.dispose();
    categoryController.dispose();
    imageController.dispose();
    descriptionController.dispose();
  }

  bool validate() => formKey.currentState?.validate() ?? false;

  @action
  Future<ProductDetails> submitProduct() async {
    isSubmitting = true;
    try {
      final title = titleController.text.trim();
      final price = double.tryParse(priceController.text.trim());
      final description = descriptionController.text.trim();
      final category = categoryController.text.trim();
      final image = imageController.text.trim();

      if (price == null || !price.isFinite || price <= 0) {
        throw const FormatException('Invalid price');
      }
      final imageUri = Uri.tryParse(image);
      if (imageUri == null || !imageUri.hasScheme || !imageUri.hasAuthority) {
        throw const FormatException('Invalid image url');
      }

      return _productService.addProduct(
        title: title,
        price: price,
        description: description,
        category: category,
        image: image,
      );
    } finally {
      isSubmitting = false;
    }
  }

  void clearForm() {
    titleController.clear();
    priceController.clear();
    categoryController.clear();
    imageController.clear();
    descriptionController.clear();
  }
}
