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
  bool loading = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    String email = _controllerEmail.text.trim();
    String password = _controllerPassword.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Por favor, llene todos los campos';
      });

      return;
    }

    if (errorMessage != null) {
      setState(() {
        errorMessage = '';
      });
    }

    setState(() {
      loading = true;
    });

    try {
      await Auth().signInWithEmailAndPassword(email: email, password: password);
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

    setState(() {
      loading = false;
    });
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration:
                    const InputDecoration(hintText: 'Correo electrónico'),
                controller: _controllerEmail,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Contraseña'),
                controller: _controllerPassword,
                obscureText: true,
                textInputAction: TextInputAction.done,
              ),
              ElevatedButton(
                  onPressed: loading ? null : signInWithEmailAndPassword,
                  child: const Text('Entrar')),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    errorMessage ?? '',
                    style: TextStyle(color: Colors.red[800], fontSize: 15),
                    textAlign: TextAlign.center,
                  ))
            ],
          )),
    );
  }
}
