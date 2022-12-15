import 'package:flutter/material.dart';
import 'package:reto_flutter_redom8/home.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginForm();
}

class _LoginForm extends State<LoginForm> {
  void _onTapEnter(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(hintText: 'Correo electrónico'),
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Contraseña'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: ElevatedButton(
                onPressed: () => _onTapEnter(context),
                child: const Text('Entrar')),
          )
        ],
      ),
    );
  }
}
