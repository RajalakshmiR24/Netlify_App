import 'package:flutter/material.dart';
import 'package:nestify_app/screens/ThankYouPage.dart';

class CheckoutPage extends StatefulWidget {
  final double totalPrice;

  CheckoutPage({super.key, required this.totalPrice});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // Add any state variables here, if needed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping to',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Icon(Icons.home, color: Colors.blue),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      '3rd Floor, New No. 75, 77 & 79, \n Lohmanradhri Towers, ',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Payment method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const PaymentMethodTile(
              icon: Icons.credit_card,
              text: '**** **** **** 3765',
              method: 'VISA',
            ),
            const PaymentMethodTile(
              icon: Icons.payment,
              text: 'whytap@ybl',
              method: 'Phonepe',
            ),
            const PaymentMethodTile(
              icon: Icons.credit_card,
              text: '**** **** **** 8562',
              method: 'Master Card',
            ),
            const Spacer(),
            const Divider(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping fee',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '\₹20.99',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sub total',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  '\₹${widget.totalPrice}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\₹${widget.totalPrice + 20.99}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 150.0), // Adjust padding for button size
                  backgroundColor: const Color(0xff000000), // Black background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThankYouPage(),
                    ),
                  );
                },
                child: const Text(
                  'PAYMENT',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold, // Use bold font weight
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final String method;

  const PaymentMethodTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.method,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(text),
      subtitle: Text(method),
      trailing: const Icon(Icons.check_circle, color: Colors.blue),
      contentPadding: const EdgeInsets.all(0),
    );
  }
}
