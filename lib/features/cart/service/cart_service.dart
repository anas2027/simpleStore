import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../products/model/product_details.dart';
import '../model/cart_item.dart';

class CartService {
  CartService._();

  static final CartService instance = CartService._();
  static const String _boxName = 'cart_items';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>(_boxName);
  }

  Box<Map> get _box => Hive.box<Map>(_boxName);

  ValueListenable<Box<Map>> listenable() => _box.listenable();

  List<CartItem> getItems() {
    return _box.values
        .map((item) => CartItem.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<void> addProduct(ProductDetails product) async {
    final key = product.id.toString();
    final existing = _box.get(key);

    if (existing != null) {
      final existingMap = Map<String, dynamic>.from(existing);
      final updated = CartItem.fromJson(existingMap);
      await _box.put(
        key,
        CartItem(
          product: updated.product,
          quantity: updated.quantity + 1,
        ).toJson(),
      );
      return;
    }

    await _box.put(key, CartItem(product: product, quantity: 1).toJson());
  }

  Future<void> incrementQuantity(int productId) async {
    final key = productId.toString();
    final existing = _box.get(key);
    if (existing == null) return;

    final item = CartItem.fromJson(Map<String, dynamic>.from(existing));
    await _box.put(
      key,
      CartItem(product: item.product, quantity: item.quantity + 1).toJson(),
    );
  }

  Future<void> decrementQuantity(int productId) async {
    final key = productId.toString();
    final existing = _box.get(key);
    if (existing == null) return;

    final item = CartItem.fromJson(Map<String, dynamic>.from(existing));
    if (item.quantity <= 1) {
      await _box.delete(key);
      return;
    }

    await _box.put(
      key,
      CartItem(product: item.product, quantity: item.quantity - 1).toJson(),
    );
  }
}
