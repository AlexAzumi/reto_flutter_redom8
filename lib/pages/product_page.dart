import 'package:flutter/material.dart';

import '../services/products.dart';

class ProductPage extends StatelessWidget {
  static const routeName = '/product';

  const ProductPage({super.key, required this.itemData});

  final Item itemData;

  Widget _spacer(String size) {
    switch (size) {
      case 'small':
        return const SizedBox(height: 4.0);
      case 'medium':
        return const SizedBox(height: 16.0);
      default:
        return const SizedBox(height: 4.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalles del producto')),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Image.network(
                        itemData.image,
                        height: 200,
                        fit: BoxFit.contain,
                        loadingBuilder: ((context, child, loadingProgress) =>
                            loadingProgress == null
                                ? child
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: const [
                                      CircularProgressIndicator()
                                    ],
                                  )),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        itemData.title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              _spacer('medium'),
              const Text(
                'Descripción',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _spacer('small'),
              Text(
                itemData.description,
                textAlign: TextAlign.justify,
              ),
              _spacer('medium'),
              const Text(
                'Categoría',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              _spacer('small'),
              Text(itemData.category),
              _spacer('medium'),
              Text(
                '\$${itemData.price.toString()} USD',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
