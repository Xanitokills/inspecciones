// ignore_for_file: prefer_const_constructors, unused_local_variable, must_call_super, use_build_context_synchronously, import_of_legacy_library_into_null_safe, unused_import

import 'package:appproyecto2/home/Menu_Navegacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import '../Login/login.dart';
/* import 'package:mi_pais/pages/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mi_pais/pages/widgets/MenuNavegacion/menu_navegacion.dart'; */

class SplashScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Splashscreen();
}

class _Splashscreen extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MenuNavegacion(),
        ),
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  // final route =
/*   final storage = const FlutterSecureStorage(); */
/*   checkLogin() async {
    String token = await storage.read(key: "token");
    // ignore: unnecessary_null_comparison
    if (token != null) {
      setState(() {});
    } else {}
  } */

  /*  @override
  void initState() {
    super.initState();
    startTimer(); */

/*   void initState() {
    var duration = const Duration(seconds: 4);
    Future.delayed(duration, () async {
      /* String token = await storage.read(key: "token"); */
      /*    if (token == null) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MenuNavegacion()),
        );
      } */
    });
  } */

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      LoginScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/splash.jpg'),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Image.asset(
            "assets/logo_app3.png",
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
