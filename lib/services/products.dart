import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;

class Products {
  Future<List<Item>> getHomeProducts() async {
    List<Item> allProducts = List.empty(growable: true);
    final response =
        await http.get(Uri.parse('https://fakestoreapi.com/products?limit=20'));

    if (response.statusCode == 200) {
      List<dynamic> items = jsonDecode(response.body);

      for (dynamic item in items) {
        allProducts.add(Item.fromJson(item));
      }

      return allProducts;
    } else {
      return List.empty();
    }
  }
}

class Item {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;

  const Item(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.category,
      required this.image});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        description: json['description'],
        category: json['category'],
        image: json['image']);
  }
}
