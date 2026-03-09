import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/app_widget/app_image_widget.dart';
import '../../../core/app_widget/app_loading_widget.dart';
import '../../../core/extension/app_extension.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_styles.dart';
import '../../cart/service/cart_service.dart';
import '../service/product_service.dart';
import '../viewmodel/product_details_view_model.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
    this.withScaffold = true,
  });

  final int productId;
  final bool withScaffold;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late final ProductDetailsViewModel _viewModel = ProductDetailsViewModel(
    ProductService(),
    widget.productId,
  );

  Future<void> _addToCart() async {
    final product = _viewModel.product;
    if (product == null) return;
    await CartService.instance.addProduct(product);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('details.addedToCart'.locale)));
  }

  @override
  void initState() {
    super.initState();
    _viewModel.fetchProductDetails();
  }

  @override
  Widget build(BuildContext context) {
    final body = Observer(
      builder: (context) {
        if (_viewModel.isLoading && _viewModel.product == null) {
          return const AppLoadingWidget();
        }

        if (_viewModel.hasError && _viewModel.product == null) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'details.failedToLoad'.locale,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.md),
                  FilledButton(
                    onPressed: _viewModel.fetchProductDetails,
                    child: Text('common.retry'.locale),
                  ),
                ],
              ),
            ),
          );
        }

        final product = _viewModel.product;
        if (product == null) {
          return Center(child: Text('details.notFound'.locale));
        }

        return ListView(
          padding: EdgeInsets.all(AppSizes.md),
          children: [
            Center(
              child: AppImageWidget(
                imageUrl: product.image,
                width: AppSizes.imageLarge,
                height: AppSizes.imageLarge,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: AppSizes.lg),
            Text(product.title, style: AppStyles.xLarge),
            SizedBox(height: AppSizes.xs),
            Text(product.category, style: AppStyles.medium),
            SizedBox(height: AppSizes.md),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: AppStyles.xLarge.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppSizes.md),
            Text(product.description, style: AppStyles.medium),
          ],
        );
      },
    );

    if (!widget.withScaffold) {
      return body;
    }

    return Scaffold(
      appBar: AppBar(title: Text('details.title'.locale)),
      body: body,
      floatingActionButton: FloatingActionButton(
        onPressed: _addToCart,
        child: const Icon(Icons.add_shopping_cart),
      ),
    );
  }
}
