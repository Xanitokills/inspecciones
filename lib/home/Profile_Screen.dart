// ignore_for_file: unused_import, use_build_context_synchronously, prefer_const_constructors
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/home/Registro_Inspeccion.dart';
import 'package:appproyecto2/home/Listar_Inspecciones.dart';
import 'package:appproyecto2/home/Listar_Estaciones.dart';
import 'package:appproyecto2/models/authmodel.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../Login/Login.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String cargo = '';
  String name = '';
  final String urlToOpen = 'https://wa.link/u5ar0p';
  // Reemplaza con tu URL
  @override
  void initState() {
    getnombreShared();
    getcargoShared();
    super.initState();
  }

  getnombreShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String nombreguardado = prefs.getString('nombre') ?? "";
    setState(() {
      name = nombreguardado;
    });
  }

  Future getcargoShared() async {
    SharedPreferences prefs2 = await SharedPreferences.getInstance();
    final String cargoguardado = prefs2.getString('cargo') ?? "";
    cargo = cargoguardado;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
            color: Colors.white54,
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const ListTile(
                    /*    leading: Icon(Icons.arrow_back),
                   trailing: Icon(Icons.menu), */
                    ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      maxRadius: 65,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    /*  CircleAvatar(
                      backgroundImage: AssetImage("assets/actualizar.png"),
                    ), */
                    /*  SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/GooglePlus-logo-red.png"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/1_Twitter-new-icon-mobile-app.jpg"),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/600px-LinkedIn_logo_initials.png"),
                    ) */
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*  Text(elemento.ideInspeccion.toString())), */
                    /* print(res.user!.cargo); */
                    Text(
                      cargo,
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 26),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(name)],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    /*  Text(
                      "Master manipulator, deal-maker and\n                   entrepreneur",
                      style: TextStyle(fontSize: 20),
                    ) */
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  child: Expanded(
                      child: ListView(
                    children: [
                      Card(
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        color: Colors.white70,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: const ListTile(
                          leading: Icon(
                            Icons.privacy_tip_sharp,
                            color: Colors.black54,
                          ),
                          title: Text(
                            'Privacidad',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      /*  Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: const ListTile(
                          leading: Icon(
                            Icons.history,
                            color: Colors.black54,
                          ),
                          title: Text(
                            'Purchase History',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios_outlined,
                            color: Colors.black54,
                          ),
                        ),
                      ), */
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                _launchURL(urlToOpen);
                              },
                              child: ListTile(
                                leading: Icon(Icons.help_outline,
                                    color: Colors.black54),
                                title: Text(
                                  'Ayuda y Soporte',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing:
                                    Icon(Icons.arrow_forward_ios_outlined),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      /*  const SizedBox(
                    height: 10,
                  ), */
                      Card(
                        color: Colors.white70,
                        margin: const EdgeInsets.only(
                            left: 35, right: 35, bottom: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: const ListTile(
                          leading: Icon(
                            Icons.privacy_tip_sharp,
                            color: Colors.black54,
                          ),
                          title: Text(
                            'Ajustes',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                          color: Colors.white70,
                          margin: const EdgeInsets.only(
                              left: 35, right: 35, bottom: 10),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.remove('id');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()),
                                  );
                                },
                                child: ListTile(
                                  leading: Icon(
                                    Icons.logout,
                                    color: Colors.black54,
                                  ),
                                  title: Text(
                                    'Cerrar Sesión',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing:
                                      Icon(Icons.arrow_forward_ios_outlined),
                                ),
                              ),
                            ],
                          )

                          /*   const ListTile(
                          leading: Icon(
                            Icons.logout,
                            color: Colors.black54,
                            
                          ),
                          title: Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),  
                          ),
                          trailing: Icon(Icons.arrow_forward_ios_outlined),
                        ), */

                          )
                    ],
                  )),
                )
              ],
            )),
      ),
    );
  }

  _launchURL(String url) async {
    if (await launchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'No se pudo abrir la URL: $url';
    }
  }
}
