import 'package:flutter/material.dart';
import 'package:nestify_app/AppBar.dart';
import 'package:nestify_app/models/product_model.dart';
import 'package:nestify_app/screens/FavouritePage.dart';
import 'package:nestify_app/screens/SaleUpPage.dart';
import 'package:nestify_app/screens/SettingPage.dart';
import 'package:nestify_app/screens/ShoppingCartPage.dart';
import 'package:nestify_app/screens/product_details.dart';
import 'package:nestify_app/services/api_products.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const UserAccountsDrawerHeader(
                accountName: Text("Guest", style: TextStyle(color: Colors.black)),
                accountEmail: Text("guest123@gmail.com", style: TextStyle(color: Colors.black)),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.black),
                title: const Text('Home', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag, color: Colors.black),
                title: const Text('My Cart', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ShoppingCartPage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite, color: Colors.black),
                title: const Text('My Favorite', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FavouritePage()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.black),
                title: const Text('Settings', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                },
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Sale Banner with Image Background
            Stack(
              children: <Widget>[
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/sale_banner.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  color: Colors.black.withOpacity(0.5),
                ),
                Positioned(
                  left: 16,
                  top: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Black Fridays', style: TextStyle(fontSize: 20, color: Colors.grey[300])),
                      const SizedBox(height: 8),
                      const Text('Sale Up To 70% Off', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SaleUpPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Shop now'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // New Arrivals
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('New Arrivals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SaleUpPage()),
                          );
                        },
                        child: const Text('Show all', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                  FutureBuilder<List<Product>>(
                    future: fetchFurnitureProducts(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No products found'));
                      }

                      List<Product> newArrivals = snapshot.data!;

                      return SizedBox(
                        height: 220,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: newArrivals.length,
                          itemBuilder: (context, index) {
                            return _buildItemCard(context, newArrivals[index]);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Best Sellers
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Best Sellers', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SaleUpPage()),
                      );
                    },
                    child: const Text('Show all', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
            FutureBuilder<List<Product>>(
              future: fetchBestSellers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                List<Product> bestSellers = snapshot.data!;

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: bestSellers.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildVerticalItemCard(context, bestSellers[index]),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, Product product) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 16.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(product.thumbnail),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 8),
          Flexible(
            child: Text(
              product.title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text('\₹${product.price}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductPage(productId: product.id), // Navigate to ProductPage with productId
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            ),
            child: const Text('Show'),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalItemCard(BuildContext context, Product product) {
    return Row(
      children: <Widget>[
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(product.thumbnail),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '\₹${product.price}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(productId: product.id),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    ),
                    child: const Text('Show'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


