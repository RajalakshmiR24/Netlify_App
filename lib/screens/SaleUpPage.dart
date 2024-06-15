import 'package:flutter/material.dart';
import 'package:nestify_app/AppBar.dart';
import 'package:nestify_app/models/product_model.dart';
import 'package:nestify_app/screens/product_details.dart';
import 'package:nestify_app/services/api_products.dart';

class SaleUpPage extends StatefulWidget {
  @override
  _SaleUpPageState createState() => _SaleUpPageState();
}

class _SaleUpPageState extends State<SaleUpPage> {
  late Future<List<Product>> futureFurnitureProducts = fetchFurnitureProducts();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
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
                  FutureBuilder<List<Product>>(
                    future: futureFurnitureProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No furniture products found.'));
                      } else {
                        final furnitureProducts = snapshot.data!;
                        return CategorySection(
                          title: 'Furniture',
                          items: furnitureProducts,
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
              child: Text(showAll ? 'Show less' : 'Show all >', style: const TextStyle(color: Colors.black)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          children: itemsToShow.map((item) => buildProductTile(context, item)).toList(),
        ),
        const SizedBox(height: 20), // Add spacing between categories
      ],
    );
  }

  Widget buildProductTile(BuildContext context, Product item) {
    return ListTile(
      leading: Image.network(
        item.thumbnail,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(item.title),
      subtitle: Text('\$${item.price}'),
      trailing: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(productId: item.id), // Navigate to ProductPage with productId
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: const Text('Shop'),
      ),
    );
  }
}



