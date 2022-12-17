import 'package:flutter/material.dart';
import 'package:reto_flutter_redom8/services/products.dart';

import '../services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    Products().getHomeProducts();
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onLogoutTapped() {
    Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: <Widget>[
          IconButton(onPressed: onLogoutTapped, icon: const Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Carrito')
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey[700],
        onTap: onItemTapped,
      ),
    );
  }
}
