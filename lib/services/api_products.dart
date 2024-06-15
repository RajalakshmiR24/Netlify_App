import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nestify_app/models/product_model.dart';

Future<List<Product>> fetchFurnitureProducts() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['products'];
    return jsonResponse
        .map((product) => Product.fromJson(product))
        .where((product) => product.category == 'furniture')
        .toList();
  } else {
    throw Exception('Failed to load products');
  }
}

// Method to fetch best seller products from furniturestore.com
Future<List<Product>> fetchBestSellers() async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body)['products'];
    return jsonResponse
        .map((product) => Product.fromJson(product))
        .where((product) => product.category == 'furniture')
        .toList();
  } else {
    throw Exception('Failed to load best sellers');
  }
}

Future<Product> fetchProduct(int productId) async {
  final response = await http.get(Uri.parse('https://dummyjson.com/products/$productId'));

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    return Product.fromJson(jsonResponse);
  } else {
    throw Exception('Failed to load product');
  }
}


