import 'package:flutter/material.dart';
import 'package:store_project/core/app_widget/app_image_widget.dart';
import 'package:store_project/core/navigation/app_routes.dart';
import 'package:store_project/core/theme/app_sizes.dart';
import 'package:store_project/core/theme/app_styles.dart';
import 'package:store_project/features/products/model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        onTap: () {
          Navigator.of(
            context,
          ).pushNamed(AppRoutes.productDetails, arguments: product.id);
        },
        child: Padding(
          padding: EdgeInsets.all(AppSizes.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImageWidget(
                imageUrl: product.image,
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
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.large,
                    ),
                    SizedBox(height: AppSizes.xxs),
                    Text(product.category, style: AppStyles.small),
                    SizedBox(height: AppSizes.xs),
                    Text(
                      product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyles.small,
                    ),
                    SizedBox(height: AppSizes.xs),
                    Row(
                      children: [
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: AppStyles.large.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.star,
                          size: AppSizes.iconSm,
                          color: Colors.amber,
                        ),
                        SizedBox(width: AppSizes.xxs),
                        Text(
                          '${product.rating?.rate ?? 0} (${product.rating?.count ?? 0})',
                          style: AppStyles.small,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
