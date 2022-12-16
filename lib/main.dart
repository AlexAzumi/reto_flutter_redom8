import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reto_flutter_redom8/widget_tree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reto Flutter Redom8 - Alejandro Suárez',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const WidgetTree(),
    );
  }
}
