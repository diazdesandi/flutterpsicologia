import 'package:flutter/material.dart';
import 'package:flutterpsicologia/login/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Clase para mostrar el perfil.
class ProfileClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new MyProfile(),
    );
  }
}

class MyProfile extends StatefulWidget {
  @override
  _MyProfilePageState createState() => new _MyProfilePageState();
}

// Basado en el estado de la clase se establece un widget para mostrar la interfaz
// del perfil con la informacion y las opciones deseadas.
class _MyProfilePageState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
      children: <Widget>[
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                    )),
                SizedBox(height: 90.0),
                Text('Nombre de usuario',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff515c6f)))),
                SizedBox(height: 15.0),
                SizedBox(height: 25.0),
                Container(
                    height: 40.0,
                    width: 150.0,
                    child: Material(
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                            child: FlatButton(
                                textColor: Colors.white,
                                color: Colors.redAccent,
                                child: Text('Editar información'),
                                onPressed: () {})),
                      ),
                    )),
                SizedBox(height: 25.0),
                Container(
                    height: 40.0,
                    width: 150.0,
                    child: Material(
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                            child: FlatButton(
                                textColor: Colors.black87,
                                color: Colors.transparent,
                                child: Text('Cerrar sesión'),
                                onPressed: () {
                                  context
                                      .read<AuthenticationService>()
                                      .signOut();
                                })),
                      ),
                    ))
              ],
            ))
      ],
    ));
  }
}
