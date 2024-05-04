// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages
import 'dart:convert';
import 'dart:math';
import 'package:appproyecto2/Login/Sign_Up.dart';
import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/models/authmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../home/Menu_Navegacion.dart';
// Librerias para alerta
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginScreen();

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> backgrounds = [
    'assets/lago.png',
    'assets/lago2.png',
    'assets/campo.png',
    'assets/nevado.png',
    // Agrega otras imágenes según
    //sea necesario
  ];
  bool vis = true;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorText = "";
  bool validate = false;
  bool circular = false;

  get networkHandler => null;

  get storage => null;
  @override
  Widget build(BuildContext context) {
    String randomBackground = getRandomBackground();
    return Scaffold(
      body: initWidget(),
    );
  }

  Future<AutModel> login() async {
    final String usuario = _emailController.text;
    final String password = _passwordController.text;
    var url = isLocal ? UrlApiLocal : UrlApi;
    print(url);
    try {
      final response = await http.post(
        Uri.parse('$url/auth/login'),
        /*     Uri.parse('http://10.0.2.2:3001/apiv1/auth/login'), */
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'usuario': usuario,
          'password': password,
        }),
      );
      AutModel res = authFromJson(response.body);

      return res;
    } catch (e) {
      print(e);

      return AutModel(message: 'Error', status: false, user: null);
    }
  }

  Widget initWidget() {
    String randomBackground = getRandomBackground();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _globalkey,
          child: Column(
            children: [
              Container(
                height: 450,
                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(90)),
                  image: DecorationImage(
                    image: AssetImage(randomBackground),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: const Text(
                          "INICIAR SESIÓN",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 23, 92),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )),
              Container(
                  /*      decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (const Color(0xffF5591F)),
                      new Color(0xffF2861E)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(90),
                        bottomRight: Radius.circular(90)),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 20,
                          color: Color.fromARGB(255, 241, 161, 161)),
                    ],
                  ), */
                  /*      color: Color.fromARGB(255, 22, 41, 146), */

                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  child: Column(
                    children: [
                      Container(
                          child: Column(
                        children: [
                          /*  Container(padding: EdgeInsets.all(10)), */
                          CorreoTextfield(),
                          PasswordTextfield(),
                        ],
                      ))
                    ],
                  )),

              /*     Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(


                    
                    children: [
                      CorreoTextfield(),
                      PasswordTextfield(),
                    ],
                  )), */
              InkWell(
                onTap: () async {
                  Future getIdShared() async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    final String idGuardado = prefs.getString('id') ?? "";
                    return idGuardado;
                  }

                  final idu = await getIdShared();
                  print(idu);

                  final password = _passwordController.text;
                  final usuario = _emailController.text;
                  try {
                    if (usuario.isEmpty) {
                      Fluttertoast.showToast(msg: 'Dni vacio');
                      return print('Dni Vacio');
                    }
                    if (password.isEmpty) {
                      Fluttertoast.showToast(msg: 'Paswword vacio');
                      return print('Contraseña Vacio');
                    }
                  } catch (e) {
                    print(e);
                  }

                  final res = await login();

                  if (res.status == true) {
                    // Si todo esta bien guardar en shared y navegar ala otra pantalla
                    // Elimnando esta de login
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('id', res.user!.id.toString());
                    /*  prefs.setString('name', res.user!.usuario.toString()); */
                    prefs.setString('user', res.user!.usuario.toString());
                    prefs.setString('nombre', res.user!.nombre.toString());
                    prefs.setString('cargo', res.user!.cargo.toString());

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MenuNavegacion()),
                    );
                  } else {
                    /*     print('wenas xd'); */
                    Fluttertoast.showToast(
                        msg: '${res.message}',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                    // Fluttertoast.cancel();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (const Color(0xffF5591F)),
                      new Color(0xffF2861E)
                    ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 20,
                          color: Color.fromARGB(255, 241, 161, 161)),
                    ],
                  ),
                  child: const Text(
                    "INGRESAR",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /*  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerRight,
                    child: const Text(
                      "No tiene cuenta Cuenta? crear cuenta",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ) */
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      /*  onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SignUp()));
                      }, */
                      /*  child: const Text(
                        "No tiene cuenta Cuenta? crear cuenta",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No tiene una Cuenta?',
                            style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                            child: const Text(
                              'Regístrese',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  /*   Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ), */
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CorreoTextfield() => TextFormField(
        /*  controller: _usernameController, */
        controller: _emailController,
        decoration: InputDecoration(
          /*   errorText: validate ? null : errorText, */
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(50),
          ),
          prefixIcon: const Icon(
            Icons.person,
            color: const Color.fromARGB(255, 4, 107, 191),
          ),
          hintText: "Ingrese su DNI",
          hintStyle:
              const TextStyle(color: const Color.fromARGB(255, 42, 73, 119)),
          filled: true,
          fillColor: const Color.fromARGB(255, 224, 224, 224),
        ),
      );

  // ignore: non_constant_identifier_names
  Widget PasswordTextfield() {
    return Column(
      children: [
        const Text(""),
        TextFormField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(50),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(50),
            ),
            prefixIcon: const Icon(
              Icons.key,
              color: const Color.fromARGB(255, 4, 107, 191),
            ),
            hintText: "Ingrese Contraseña",
            hintStyle: const TextStyle(color: Color.fromARGB(255, 42, 73, 119)),
            filled: true,
            fillColor: const Color.fromARGB(255, 224, 224, 224),
            /* errorText: validate ? null : errorText, */
            suffixIcon: IconButton(
              icon: Icon(vis ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis = !vis;
                });
              },
            ),
            helperStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          controller: _passwordController,
          cursorColor: const Color.fromARGB(255, 4, 107, 191),
          obscureText: vis,
        ),
      ],
    );
  }

  String getRandomBackground() {
    Random random = Random();
    int index = random.nextInt(backgrounds.length);
    return backgrounds[index];
  }
}

class GetStorage {
  void write(String s, codigousuario) {}
}
