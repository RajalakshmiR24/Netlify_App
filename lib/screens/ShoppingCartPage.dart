import 'package:flutter/material.dart';
import 'package:nestify_app/AppBar.dart'; // Replace with correct path
import 'package:nestify_app/models/product_model.dart'; // Replace with correct path
import 'package:nestify_app/screens/CheckoutPage.dart'; // Replace with correct path

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  final ShoppingCart _shoppingCart = ShoppingCart();

  void _onCartChanged() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _shoppingCart.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _shoppingCart.removeListener(_onCartChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(), // Replace with your CustomAppBar
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_shoppingCart.items.isNotEmpty)
                Center(
                  child: Column(
                    children: _shoppingCart.items.values
                        .map((item) => CartItemWidget(
                      item: item,
                      onCartChanged: _onCartChanged,
                    ))
                        .toList(),
                  ),
                ),
              const SizedBox(height: 16),
              OrderSummary(),
              const SizedBox(height: 16),
              if (_shoppingCart.items.isNotEmpty)
                CheckoutButton(totalPrice: _shoppingCart.totalPrice),
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingCart extends ChangeNotifier {
  static final ShoppingCart _instance = ShoppingCart._internal();

  factory ShoppingCart() => _instance;

  ShoppingCart._internal();

  final Map<int, CartItem> _items = {};

  Map<int, CartItem> get items => _items;

  double get totalPrice {
    return _items.values
        .map((item) => item.price * item.quantity)
        .reduce((value, element) => value + element);
  }

  void addToCart(Product product) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity++;
    } else {
      _items[product.id] = CartItem(
        id: product.id,
        title: product.title,
        price: product.price,
        quantity: 1,
        imageUrl: product.thumbnail,
      );
    }
    notifyListeners();
  }

  void removeFromCart(int productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items[productId]!.quantity--;
      } else {
        _items.remove(productId);
      }
      notifyListeners();
    }
  }

  void clearCart(int productId) {
    _items.remove(productId);
    notifyListeners();
  }
}

class CartItem {
  final int id;
  final String title;
  final double price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onCartChanged;

  const CartItemWidget({Key? key, required this.item, required this.onCartChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffffffff),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(item.imageUrl, width: 50, height: 50),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\₹${item.price}',
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      const SizedBox(width: 40),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              ShoppingCart().addToCart(Product(
                                id: item.id,
                                title: item.title,
                                price: item.price,
                                thumbnail: item.imageUrl,
                                images: [], // Replace with correct value
                                category: '', // Replace with correct value
                                description: '', // Replace with correct value
                              ));
                              onCartChanged();
                            },
                          ),
                          Text(
                            '${item.quantity}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              ShoppingCart().removeFromCart(item.id);
                              onCartChanged();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.grey),
              onPressed: () {
                ShoppingCart().clearCart(item.id);
                onCartChanged();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummary extends StatefulWidget {
  const OrderSummary({Key? key}) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  int _itemCount = 0;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    ShoppingCart().addListener(_calculateSummary);
    _calculateSummary();
  }

  @override
  void dispose() {
    ShoppingCart().removeListener(_calculateSummary);
    super.dispose();
  }

  void _calculateSummary() {
    final cart = ShoppingCart();
    int itemCount = 0;
    double totalPrice = 0.0;

    if (cart.items.isNotEmpty) {
      cart.items.values.forEach((item) {
        itemCount += item.quantity;
        totalPrice += item.price * item.quantity;
      });
    }

    setState(() {
      _itemCount = itemCount;
      _totalPrice = totalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const Center(
          child: Text(
            'Order Summary',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$_itemCount items',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            Text(
              '\₹$_totalPrice',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class CheckoutButton extends StatelessWidget {
  final double totalPrice;

  const CheckoutButton({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          backgroundColor: const Color(0xff000000),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutPage(totalPrice: totalPrice),
            ),
          );
        },
        child: const Text('CHECKOUT', style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}
