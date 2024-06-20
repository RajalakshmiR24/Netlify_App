import 'package:flutter/material.dart';
import 'package:nestify_app/AppBar.dart';
import 'package:nestify_app/models/product_model.dart';
import 'package:nestify_app/screens/product_details.dart';

List<Product> favoriteProducts = [];

class FavouritePage extends StatefulWidget {
  @override
  FavouritePageState createState() => FavouritePageState();
}

class FavouritePageState extends State<FavouritePage> {
  static FavouritePageState? _instance;

  FavouritePageState() {
    _instance = this;
  }

  static void updateFavorites() {
    _instance?.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(),
      body: favoriteProducts.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/empty_fav.png',
                width: screenWidth * 0.7,
                height: screenWidth * 0.7,
              ),
              const Text(
                'Your Favorite Items',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  child: Text(
                    'CONTINUE EXPLORING',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 0.75,
          ),
          itemCount: favoriteProducts.length,
          itemBuilder: (context, index) {
            final product = favoriteProducts[index];
            return _buildFavoriteItem(context, product);
          },
        ),
      ),
    );
  }

  Widget _buildFavoriteItem(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(productId: product.id),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                product.thumbnail,
                width: double.infinity,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\₹${product.price.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    favoriteProducts.remove(product);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
