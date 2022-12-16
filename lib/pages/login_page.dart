import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginForm();
}

class _LoginForm extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    if (errorMessage != null) {
      setState(() {
        errorMessage = '';
      });
    }

    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text.trim(),
          password: _controllerPassword.text.trim());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          errorMessage = 'El usuario no existe';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          errorMessage = 'Las credenciales introducidas no son válidas';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar sesión')),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration:
                    const InputDecoration(hintText: 'Correo electrónico'),
                controller: _controllerEmail,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Contraseña'),
                controller: _controllerPassword,
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: ElevatedButton(
                    onPressed: signInWithEmailAndPassword,
                    child: const Text('Entrar')),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(errorMessage ?? ''))
            ],
          )),
    );
  }
}
