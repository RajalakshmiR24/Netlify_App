import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nestify_app/models/product_model.dart';
import 'dart:convert';

class SaleUpPage extends StatefulWidget {
  @override
  _SaleUpPageState createState() => _SaleUpPageState();
}

class _SaleUpPageState extends State<SaleUpPage> {
  late Future<Map<String, List<Product>>> futureProductsByCategory;

  Future<Map<String, List<Product>>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final List<dynamic> productJson = json.decode(response.body)['products'];
      List<Product> products = productJson.map((json) => Product.fromJson(json)).toList();

      Map<String, List<Product>> productsByCategory = {};
      for (var product in products) {
        if (!productsByCategory.containsKey(product.category)) {
          productsByCategory[product.category] = [];
        }
        productsByCategory[product.category]!.add(product);
      }
      return productsByCategory;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    futureProductsByCategory = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                'assets/top.jpg', // Ensure this file is in your assets folder and specified in pubspec.yaml
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sale Up To \n 70% Off',
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'SHOP NOW >',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<Map<String, List<Product>>>(
                    future: futureProductsByCategory,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No products found.'));
                      } else {
                        final productsByCategory = snapshot.data!;
                        return Column(
                          children: productsByCategory.entries.map((entry) {
                            return CategorySection(
                              title: entry.key,
                              items: entry.value,
                            );
                          }).toList(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatefulWidget {
  final String title;
  final List<Product> items;

  CategorySection({required this.title, required this.items});

  @override
  _CategorySectionState createState() => _CategorySectionState();
}

class _CategorySectionState extends State<CategorySection> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final itemsToShow = showAll ? widget.items : widget.items.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.title} (${widget.items.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  showAll = !showAll;
                });
              },
              child: Text(showAll ? 'Show less' : 'Show all >', style: const TextStyle(color: Colors.black),),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: itemsToShow
              .map((item) => ListTile(
            leading: Image.network(
              item.thumbnail,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            title: Text(item.title),
            subtitle: Text('\$${item.price}'),
            trailing: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('Shop'),
            ),
          ))
              .toList(),
        ),
        const SizedBox(height: 20), // Add spacing between categories
      ],
    );
  }
}
