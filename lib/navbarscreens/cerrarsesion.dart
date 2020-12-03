import 'package:flutter/material.dart';
import 'package:flutterpsicologia/login/auth.dart';
import 'package:provider/provider.dart';

class CerrarSesion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Pantalla de prueba para cerrar sesion"),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
              child: Text("Cerrar sesion"),
            ),
          ],
        ),
      ),
    );
  }
}
