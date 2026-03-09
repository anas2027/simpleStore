import '../../products/model/product_details.dart';

class CartItem {
  const CartItem({required this.product, required this.quantity});

  final ProductDetails product;
  final int quantity;

  Map<String, dynamic> toJson() => {
    'id': product.id,
    'title': product.title,
    'price': product.price,
    'description': product.description,
    'category': product.category,
    'image': product.image,
    'quantity': quantity,
  };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductDetails.fromJson({
        'id': json['id'] as int,
        'title': json['title'] as String,
        'price': (json['price'] as num).toDouble(),
        'description': json['description'] as String,
        'category': json['category'] as String,
        'image': json['image'] as String,
      }),
      quantity: (json['quantity'] as int?) ?? 1,
    );
  }
}
