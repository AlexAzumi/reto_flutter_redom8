import 'package:flutter/material.dart';
import 'package:reto_flutter_redom8/pages/product_page.dart';
import 'package:reto_flutter_redom8/services/products.dart';
import 'dart:developer' as developer;

import '../services/auth.dart';
import '../widgets/product_card.dart';

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

    // Fetch items from API
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

  Widget _mainContainer(BuildContext context) {
    if (loading) {
      return _loadingScreen();
    } else {
      controller.forward();

      return _productListing(context);
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

  Widget _productListing(BuildContext context) {
    return Opacity(
        opacity: animation.value,
        child: GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          children: itemsToShow
              .map((item) => ProductCard(
                    id: item.id,
                    name: item.title,
                    price: item.price,
                    image: item.image,
                    onTapItem: () => onTapItem(context, item),
                  ))
              .toList(),
        ));
  }

  void onTapItem(BuildContext context, Item item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductPage(
                  itemData: item,
                )));
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
      body: _mainContainer(context),
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
