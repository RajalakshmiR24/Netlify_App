import 'package:flutter/material.dart';
import 'package:nestify_app/AppBar.dart';
import 'package:nestify_app/models/product_model.dart';
import 'package:nestify_app/screens/ShoppingCartPage.dart';
import 'package:nestify_app/services/api_products.dart';
import 'package:nestify_app/screens/FavouritePage.dart'; // Add this import

class ProductPage extends StatefulWidget {
  final int productId;
  ProductPage({required this.productId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<Product> _productFuture;
  late Future<List<Product>> _furnitureProductsFuture;
  String? _mainImageUrl;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _productFuture = fetchProduct(widget.productId);
    _furnitureProductsFuture = fetchFurnitureProducts();
    _isFavorite = favoriteProducts.any((product) => product.id == widget.productId);
  }

  void _addToCart(Product product) {
    ShoppingCart().addToCart(product); // Add product to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20.0),
      ),
    );
  }

  void _buyNow(Product product) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Buying ${product.title} now'),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20.0),
      ),
    );
  }

  void _toggleFavorite(Product product) {
    setState(() {
      _isFavorite = !_isFavorite;
      if (_isFavorite) {
        favoriteProducts.add(product);
      } else {
        favoriteProducts.removeWhere((item) => item.id == product.id);
      }
      FavouritePageState.updateFavorites(); // Notify FavouritePage to update
    });
  }

  Widget _buildColorOption(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSimilarItem(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(productId: product.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.network(
          product.thumbnail,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildImageGallery(List<String> images) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: images.map((image) => _buildImageItem(image)).toList(),
      ),
    );
  }

  Widget _buildImageItem(String imageUrl) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _mainImageUrl = imageUrl;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Image.network(
          imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder<Product>(
        future: _productFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          } else {
            Product product = snapshot.data!;
            _mainImageUrl ??= product.thumbnail; // Initialize main image URL
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Stack(
                        children: [
                          Image.network(
                            _mainImageUrl!,
                            height: screenWidth > 600 ? 500 : 400,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 8.0,
                            right: 8.0,
                            child: IconButton(
                              icon: Icon(
                                _isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: _isFavorite ? Colors.red : Colors.blueGrey,
                                size: 32,
                              ),
                              onPressed: () {
                                _toggleFavorite(product);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildImageGallery(product.images.where((image) => image != product.thumbnail).toList()),
                    const SizedBox(height: 20),
                    Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      product.description,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildColorOption(Colors.blue),
                        _buildColorOption(Colors.purple),
                        _buildColorOption(Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '\₹${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            _addToCart(product);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Add to cart',
                            style: TextStyle(
                              fontFamily: 'Baskerville',
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            _buyNow(product);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Buy now',
                            style: TextStyle(
                              fontFamily: 'Baskerville',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'You may also like',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<List<Product>>(
                      future: _furnitureProductsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(child: Text('No similar items found'));
                        } else {
                          List<Product> furnitureProducts = snapshot.data!;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: furnitureProducts.map((product) => _buildSimilarItem(product)).toList(),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
