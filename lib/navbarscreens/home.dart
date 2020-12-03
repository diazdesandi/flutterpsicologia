import 'package:flutter/material.dart';
import 'package:flutterpsicologia/login/auth.dart';
import 'package:flutterpsicologia/pages/submenus/calendar.dart';
import 'package:flutterpsicologia/pages/submenus/profile.dart';
import 'package:flutterpsicologia/pages/submenus/notifications.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:provider/provider.dart';

// Clase de pantalla de principal
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: UserPage(),
        ));
  }
}

// Clase userpage donde se crea el widget con la informacion del perfil que ha iniciado sesion
class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Padding para el contenedor de la informacion
    final page = ({Widget child}) => Styled.widget(child: child)
        .padding(vertical: 30, horizontal: 20)
        .constrained(minHeight: 50)
        .scrollable();

    return <Widget>[
      Text(
        'Menú',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
      ).alignment(Alignment.topLeft).padding(top: 20, bottom: 20),
      UserCard(),
      Dashpage(),
    ].toColumn().parent(page);
  }
}

class UserCard extends StatelessWidget {
  Widget _buildUserRow() {
    return <Widget>[
      // Icono que reemplaza la imagen de perfil, para establecer dicha imagen seria necesario
      // establecer el backend en Firebase
      Icon(Icons.account_circle)
          .decorated(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          )
          .constrained(height: 50, width: 50)
          .padding(right: 10),
      <Widget>[
        // Nombre del usuario que inicio sesion
        Text(
          'Nombre de usuario',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ).padding(bottom: 5),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    ].toRow();
  }

// Widget donde se establece el color y la forma de los bordes donde se muestra la informacion de usuario
  @override
  Widget build(BuildContext context) {
    return <Widget>[_buildUserRow()]
        .toColumn(mainAxisAlignment: MainAxisAlignment.spaceAround)
        .padding(horizontal: 10, vertical: 10)
        .decorated(
            color: Colors.redAccent, borderRadius: BorderRadius.circular(10))
        .elevation(
          1,
          shadowColor: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        )
        .height(80)
        .alignment(Alignment.center);
  }
}

// Clase de menu principal donde se establecen todas las opciones disponibles en la aplicacion
class Dashpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 410,
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 350.0,
              width: 200,
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 80.0, right: 10.0, left: 10.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0.0, 3.0),
                        blurRadius: 15.0)
                  ]),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Cada columna dentro de este Widget es una opcion disponible en el menu
                        Column(
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.purple.withOpacity(0.1),
                              child: IconButton(
                                padding: EdgeInsets.all(15.0),
                                icon: Icon(Icons.message),
                                color: Colors.purple,
                                iconSize: 30.0,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text('Mensajes\n',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.blue.withOpacity(0.1),
                              child: IconButton(
                                padding: EdgeInsets.all(15.0),
                                icon: Icon(Icons.monetization_on),
                                color: Colors.blue,
                                iconSize: 30.0,
                                onPressed: () {},
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text('Métodos\nde pago',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.orange.withOpacity(0.1),
                              child: IconButton(
                                padding: EdgeInsets.all(15.0),
                                icon: Icon(Icons.build),
                                color: Colors.orange,
                                iconSize: 30.0,
                                onPressed: () {
                                  context
                                      .read<AuthenticationService>()
                                      .signOut();
                                },
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text('Cerrar\n',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.pink.withOpacity(0.1),
                              child: IconButton(
                                  padding: EdgeInsets.all(15.0),
                                  icon: Icon(Icons.contacts),
                                  color: Colors.pink,
                                  iconSize: 30.0,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileClass()));
                                  }),
                            ),
                            SizedBox(height: 8.0),
                            Text('Perfil',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.purpleAccent.withOpacity(0.1),
                              child: IconButton(
                                padding: EdgeInsets.all(15.0),
                                icon: Icon(Icons.calendar_today),
                                color: Colors.purpleAccent,
                                iconSize: 30.0,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Agendar()));
                                },
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text('Citas',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.circular(100.0),
                              color: Colors.deepPurple.withOpacity(0.1),
                              child: IconButton(
                                padding: EdgeInsets.all(15.0),
                                icon: Icon(Icons.notifications),
                                color: Colors.deepPurple,
                                iconSize: 30.0,
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Notifications()));
                                },
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text('Ajustes',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Divider(),
                  SizedBox(height: 15.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 390.0 - 200);
    path.quadraticBezierTo(size.width / 2, 280, size.width, 390.0 - 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
