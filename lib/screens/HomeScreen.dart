import 'package:flutter/material.dart';
import 'package:nestify_app/screens/SaleUpPage.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Change AppBar color to white
        iconTheme: const IconThemeData(color: Colors.black), // Change AppBar icon color to black
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white, // Set the drawer background color to white
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
                  color: Colors.white, // Change DrawerHeader background color to white
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home, color: Colors.black),
                title: const Text('Home', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.collections, color: Colors.black),
                title: const Text('New collections', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.star, color: Colors.black),
                title: const Text('Editor\'s Picks', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.local_offer, color: Colors.black),
                title: const Text('Top Deals', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.black),
                title: const Text('Notifications', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.black),
                title: const Text('Settings', style: TextStyle(color: Colors.black)),
                onTap: () {
                  Navigator.pop(context);
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
                      image: AssetImage('assets/sale_banner.jpg'), // Replace with your image asset
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  color: Colors.black.withOpacity(0.5), // Overlay with semi-transparent black color
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
                          backgroundColor: Colors.black, // background color
                          foregroundColor: Colors.white, // foreground color
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('New Arrivals', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  TextButton(onPressed: () {}, child: const Text('Show all', style: TextStyle(color: Colors.black),)),
                ],
              ),
              SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0), // Add padding here if needed
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _buildItemCard('Nancy Chair', '\$29.00', 'assets/nancy_chair.jpg'),
                      _buildItemCard('Table Wood Pine', '\$29.00', 'assets/table_wood_pine.jpg'),
                      _buildItemCard('Daisy Chair', '\$29.00', 'assets/daisy_chair.jpg'),
                      _buildItemCard('Table Wood Pine', '\$29.00', 'assets/table_wood_pine.jpg'),
                      _buildItemCard('Daisy Chair', '\$29.00', 'assets/daisy_chair.jpg'),
                    ],
                  ),
                ),
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
                  TextButton(onPressed: () {}, child: const Text('Show all', style: TextStyle(color: Colors.black))),
                ],
              ),
            ),
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildVerticalItemCard('Houndstooth Side Zipper', '\$29.00', 'assets/houndstooth_side_zipper.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildVerticalItemCard('Ovora Design Table Teak', '\$29.00', 'assets/ovora_design_table_teak.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildVerticalItemCard('Lamp Chair', '\$29.00', 'assets/lamp.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildVerticalItemCard('Houndstooth Side Zipper', '\$29.00', 'assets/houndstooth_side_zipper.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildVerticalItemCard('Ovora Design Table Teak', '\$29.00', 'assets/ovora_design_table_teak.jpg'),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildVerticalItemCard('Lamp Chair', '\$29.00', 'assets/lamp.jpg'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(String title, String price, String imagePath) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(price, style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildVerticalItemCard(String title, String price, String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(price, style: const TextStyle(fontSize: 16, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

