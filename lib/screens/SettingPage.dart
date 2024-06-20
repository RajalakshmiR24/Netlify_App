import 'package:flutter/material.dart';
import 'package:nestify_app/MyApp.dart';
import 'package:nestify_app/screens/CheckoutPage.dart';
import 'package:nestify_app/screens/FavouritePage.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text(
              "Guest",
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(
              "guest123@gmail.com",
              style: TextStyle(color: Colors.black87),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/profile.jpg"), // Add your profile image in the assets folder
            ),
            decoration: BoxDecoration(color: Colors.white),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border, color: Colors.black),
            title: const Text('Wishlist', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FavouritePage()));
            },
          ),
          ListTile(
            
            leading: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
            title: const Text('My Orders', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: Colors.black),
            title: const Text('Payment Method', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(totalPrice: 0,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on_outlined, color: Colors.black),
            title: const Text('Delivery Address', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard, color: Colors.black),
            title: const Text('Gift cards & vouchers', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_phone_outlined, color: Colors.black),
            title: const Text('Contact preferences', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              // Handle tap
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.black),
            title: const Text('Logout', style: TextStyle(color: Colors.black)),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.black),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));

            },
          ),
        ],
      ),
    );
  }
}
