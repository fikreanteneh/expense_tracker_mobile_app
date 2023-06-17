import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String uri = 'http://localhost:3000';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 2),
    ),
  );
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}

final Map<String, dynamic> catagory = {
  "Food": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.amber,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.food_bank, color: Colors.white),
  ),
  "Clothing": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.green,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.tshirt, color: Colors.white),
  ),
  "Fruits": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.orange,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.apple, color: Colors.white),
  ),
  "Shopping": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.red,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.shoppingBag, color: Colors.white),
  ),
  "Transportation": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.purple,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.bus, color: Colors.white),
  ),
  "Home": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.teal,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.home, color: Colors.white),
  ),
  "Travel": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.brown,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.plane, color: Colors.white),
  ),
  "Entertainment": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.pink,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.gamepad, color: Colors.white),
  ),
  "Health": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.deepPurple,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.heartbeat, color: Colors.white),
  ),
  "Education": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.amber,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.graduationCap, color: Colors.white),
  ),
  "Gifts": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.indigo,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.gift, color: Colors.white),
  ),
  "Other": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.grey,
      shape: BoxShape.circle,
    ),
    child: const FaIcon(FontAwesomeIcons.question, color: Colors.white),
  ),
  "Salary": Container(
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.green,
      shape: BoxShape.circle,
    ),
    child: const Icon(Icons.money_off_csred_outlined, color: Colors.white),
  ),
};
