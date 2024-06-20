import 'package:flutter/material.dart';
import 'package:nestify_app/screens/FavouritePage.dart';
import 'package:nestify_app/screens/ShoppingCartPage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ShoppingCartPage()));
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite, color: Colors.red),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FavouritePage()));
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

