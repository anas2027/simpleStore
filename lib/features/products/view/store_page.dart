import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:store_project/features/products/view/widget/product_card.dart';

import '../../../core/app_widget/app_loading_widget.dart';
import '../../../core/extension/app_extension.dart';
import '../../../core/theme/app_sizes.dart';
import '../service/product_service.dart';
import '../viewmodel/product_list_view_model.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late final ProductListViewModel _viewModel = ProductListViewModel(
    ProductService(),
  );
  String _selectedCategory = 'all';

  @override
  void initState() {
    super.initState();
    _viewModel.fetchProducts(false);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        if (_viewModel.isLoading && _viewModel.products.isEmpty) {
          return const AppLoadingWidget();
        }

        if (_viewModel.hasError && _viewModel.products.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(AppSizes.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (_viewModel.errorMessage != null)
                        ? 'store.failedToLoadProducts'.locale
                        : 'store.unknownError'.locale,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppSizes.md),
                  FilledButton(
                    onPressed: () => _viewModel.fetchProducts(false),
                    child: Text('common.retry'.locale),
                  ),
                ],
              ),
            ),
          );
        }

        final categories =
            _viewModel.products.map((p) => p.category).toSet().toList()..sort();
        final filteredProducts = _selectedCategory == 'all'
            ? _viewModel.products.toList()
            : _viewModel.products
                  .where((p) => p.category == _selectedCategory)
                  .toList();

        return RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () => _viewModel.fetchProducts(true),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    AppSizes.sm,
                    AppSizes.sm,
                    AppSizes.sm,
                    AppSizes.xs,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ChoiceChip(
                          label: Text('store.allCategories'.locale),
                          selected: _selectedCategory == 'all',
                          onSelected: (_) {
                            setState(() => _selectedCategory = 'all');
                          },
                        ),
                        ...categories.map(
                          (category) => Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: AppSizes.xs,
                            ),
                            child: ChoiceChip(
                              label: Text(category),
                              selected: _selectedCategory == category,
                              onSelected: (_) {
                                setState(() => _selectedCategory = category);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(AppSizes.sm),
                sliver: SliverList.separated(
                  itemCount: filteredProducts.length,
                  separatorBuilder: (_, __) => SizedBox(height: AppSizes.xs),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(product: product);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
