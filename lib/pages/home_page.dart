import 'package:flutter/material.dart';
import 'package:reto_flutter_redom8/services/products.dart';
import 'dart:developer' as developer;

import '../services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool loading = true;
  List<Item> itemsToShow = List.empty(growable: true);
  // Animation stuff
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 350), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    loadItems();
  }

  Future<void> loadItems() async {
    List<Item> fetchedItems = await Products().getHomeProducts();

    setState(() {
      itemsToShow = fetchedItems;
      loading = false;
    });
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void onLogoutTapped() {
    Auth().signOut();
  }

  Widget _mainContainer() {
    if (loading) {
      return _loadingScreen();
    } else {
      controller.forward();

      return _productListing();
    }
  }

  Widget _loadingScreen() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text('Cargando productos...'),
            )
          ],
        ));
  }

  Widget _productListing() {
    return Opacity(opacity: animation.value, child: const Text('Products xd'));
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
      body: _mainContainer(),
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
