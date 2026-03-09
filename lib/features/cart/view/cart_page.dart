import 'package:flutter/material.dart';

import '../../../core/app_widget/app_image_widget.dart';
import '../../../core/extension/app_extension.dart';
import '../../../core/theme/app_sizes.dart';
import '../../../core/theme/app_styles.dart';
import '../service/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('cart.title'.locale)),
      body: ValueListenableBuilder(
        valueListenable: CartService.instance.listenable(),
        builder: (context, _, __) {
          final items = CartService.instance.getItems();

          if (items.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(AppSizes.md),
                child: Text(
                  'cart.empty'.locale,
                  style: AppStyles.large,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(AppSizes.sm),
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(height: AppSizes.xs),
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(AppSizes.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppImageWidget(
                        imageUrl: item.product.image,
                        width: AppSizes.imageCard,
                        height: AppSizes.imageCard,
                        fit: BoxFit.cover,
                        imageRadius: AppSizes.radiusSm,
                      ),
                      SizedBox(width: AppSizes.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.product.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.large,
                            ),
                            SizedBox(height: AppSizes.xxs),
                            Text(item.product.category, style: AppStyles.small),
                            SizedBox(height: AppSizes.xs),
                            Text(
                              item.product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppStyles.small,
                            ),
                            SizedBox(height: AppSizes.xs),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton.filledTonal(
                                  onPressed: () {
                                    CartService.instance.decrementQuantity(
                                      item.product.id,
                                    );
                                  },
                                  icon: const Icon(Icons.remove),
                                  tooltip: 'cart.decrease'.locale,
                                ),
                                SizedBox(width: AppSizes.xs),
                                Text(
                                  item.quantity.toString(),
                                  style: AppStyles.medium,
                                ),
                                SizedBox(width: AppSizes.xs),
                                IconButton.filledTonal(
                                  onPressed: () {
                                    CartService.instance.incrementQuantity(
                                      item.product.id,
                                    );
                                  },
                                  icon: const Icon(Icons.add),
                                  tooltip: 'cart.increase'.locale,
                                ),
                                const Spacer(),
                                Text(
                                  '\$${item.product.price.toStringAsFixed(2)}',
                                  style: AppStyles.large.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
