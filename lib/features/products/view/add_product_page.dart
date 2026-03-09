import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/extension/app_extension.dart';
import '../../../core/theme/app_sizes.dart';
import '../viewmodel/add_product_view_model.dart';

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key, AddProductViewModel? viewModel})
    : _viewModel = viewModel ?? AddProductViewModel();

  final AddProductViewModel _viewModel;

  Future<void> _submitProduct(BuildContext context) async {
    if (!_viewModel.validate()) {
      return;
    }

    try {
      await _viewModel.submitProduct();
      if (!context.mounted) return;
      _viewModel.clearForm();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('addProduct.successWithId'.locale)),
      );
    } catch (error) {
      if (!context.mounted) return;
      final errorMessage = switch (error) {
        FormatException(message: final message)
            when message == 'Invalid image url' =>
          'addProduct.invalidImageUrl'.locale,
        FormatException() => 'addProduct.invalidPrice'.locale,
        _ => 'addProduct.failedToAdd'.locale,
      };
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(AppSizes.md),
      child: Form(
        key: _viewModel.formKey,
        child: Column(
          children: [
            _field(
              context: context,
              controller: _viewModel.titleController,
              label: 'addProduct.title'.locale,
            ),
            SizedBox(height: AppSizes.sm),
            _field(
              context: context,
              controller: _viewModel.priceController,
              label: 'addProduct.price'.locale,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            SizedBox(height: AppSizes.sm),
            _field(
              context: context,
              controller: _viewModel.categoryController,
              label: 'addProduct.category'.locale,
            ),
            SizedBox(height: AppSizes.sm),
            _field(
              context: context,
              controller: _viewModel.imageController,
              label: 'addProduct.imageUrl'.locale,
            ),
            SizedBox(height: AppSizes.sm),
            _field(
              context: context,
              controller: _viewModel.descriptionController,
              label: 'addProduct.description'.locale,
              maxLines: 4,
            ),
            SizedBox(height: AppSizes.lg),
            SizedBox(
              width: double.infinity,
              child: Observer(
                builder: (_) => FilledButton(
                  onPressed: _viewModel.isSubmitting
                      ? null
                      : () => _submitProduct(context),
                  child: Text(
                    _viewModel.isSubmitting
                        ? 'addProduct.submitting'.locale
                        : 'addProduct.submit'.locale,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if ((value ?? '').trim().isEmpty) {
          return 'addProduct.required'.locale;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        ),
      ),
    );
  }
}
