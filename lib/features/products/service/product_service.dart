import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../model/product.dart';
import '../model/product_details.dart';

class ProductService {
  static const String _productsUrl = 'https://fakestoreapi.com/products';
  static const Duration _requestTimeout = Duration(seconds: 15);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse(_productsUrl))
          .timeout(_requestTimeout);

      if (response.statusCode != 200) {
        throw Exception('Server error: ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body) as List<dynamic>;
      return decoded
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw Exception('No internet connection');
    } on HttpException {
      throw Exception('Network request failed');
    } on FormatException {
      throw Exception('Invalid server response');
    } on Exception catch (error) {
      if (error.toString().contains('TimeoutException')) {
        throw Exception('Request timeout');
      }
      rethrow;
    }
  }

  Future<ProductDetails> fetchProductDetails(int id) async {
    try {
      final response = await http
          .get(Uri.parse('$_productsUrl/$id'))
          .timeout(_requestTimeout);

      if (response.statusCode != 200) {
        throw Exception('Server error: ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      return ProductDetails.fromJson(decoded);
    } on SocketException {
      throw Exception('No internet connection');
    } on HttpException {
      throw Exception('Network request failed');
    } on FormatException {
      throw Exception('Invalid server response');
    } on Exception catch (error) {
      if (error.toString().contains('TimeoutException')) {
        throw Exception('Request timeout');
      }
      rethrow;
    }
  }

  Future<ProductDetails> addProduct({
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
  }) async {
    final payload = <String, dynamic>{
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
    };

    try {
      final response = await http
          .post(
            Uri.parse(_productsUrl),
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(_requestTimeout);

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw Exception('Server error: ${response.statusCode}');
      }

      final decoded = jsonDecode(response.body) as Map<String, dynamic>;
      return ProductDetails.fromJson(decoded);
    } on SocketException {
      throw Exception('No internet connection');
    } on HttpException {
      throw Exception('Network request failed');
    } on FormatException {
      throw Exception('Invalid server response');
    } on Exception catch (error) {
      if (error.toString().contains('TimeoutException')) {
        throw Exception('Request timeout');
      }
      rethrow;
    }
  }
}
