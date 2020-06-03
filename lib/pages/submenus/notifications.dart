import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Clase de interfaz donde modifican los ajustes de notificacion.
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool _dark;

  @override
  void initState() {
    super.initState();
    _dark = false;
  }

  Brightness _getBrightness() {
    return _dark ? Brightness.dark : Brightness.light;
  }
// Se realiza un override con la interfaz de la pantalla, la cual incluye los titulos asi como
// los botones para manipular los ajutes de interfaz
  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: true,
      data: ThemeData(
        brightness: _getBrightness(),
      ),
      child: Scaffold(
        backgroundColor: _dark ? null : Colors.grey.shade200,
        appBar: AppBar(
          elevation: 0,
          brightness: _getBrightness(),
          iconTheme: IconThemeData(color: _dark ? Colors.white : Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            'Notificaciones',
            style: TextStyle(color: _dark ? Colors.white : Colors.black),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  Text(
                    "Notificaciones",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  // Lista de switches para prender/apagar cada opcion de notificacion.
                  SwitchListTile(
                    activeColor: Colors.redAccent,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Notificación nueva"),
                    onChanged: (val) {},
                  ),
                  SwitchListTile(
                    activeColor: Colors.redAccent,
                    contentPadding: const EdgeInsets.all(0),
                    value: false,
                    title: Text("Articulo nuevo"),
                    onChanged: null,
                  ),
                  SwitchListTile(
                    activeColor: Colors.redAccent,
                    contentPadding: const EdgeInsets.all(0),
                    value: true,
                    title: Text("Video nuevo"),
                    onChanged: null,
                  ),
                  const SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}