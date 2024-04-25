// ignore_for_file: use_build_context_synchronously, avoid_print, depend_on_referenced_packages
import 'dart:convert';
import 'package:appproyecto2/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
// Librerias para alerta
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const SignUp();

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  bool vis1 = true;
  bool vis2 = true;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _apellidoMController = TextEditingController();
  TextEditingController _cargoController = TextEditingController();
  TextEditingController _dniController = TextEditingController();
/*   TextEditingController _passwordController = TextEditingController(); */
  TextEditingController _passwordconfirmController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#\$&*~]).{8,}$',
  );
  String _passwordErrorText = '';

  void _validatePassword(String password) {
    setState(() {
      if (_passwordRegex.hasMatch(password)) {
        _passwordErrorText = '';
      } else {
        _passwordErrorText =
            'La contraseña debe contener al menos una mayúscula, un número y un carácter especial.';
      }
    });
  }

  /* TextEditingController _Controller = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController(); */
  String errorText = "";
  bool validate = false;
  bool circular = false;

  get networkHandler => null;

  get storage => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initWidget(),
    );
  }
/* 
  Future<AutModel> login() async {
    final String usuario = _dniController.text;
    final String password = _passwordController.text;
    final response = await http.post(
      Uri.parse('http://10.0.2.2:3001/apiv1/auth/login'),
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
  } */

  Future signup() async {
    final String nombre = _nombreController.text;
    final String apellido = _apellidoController.text;
    final String apellidoM = _apellidoMController.text;
    final String cargo = _cargoController.text;
    final String usuario = _dniController.text;
    final String password = _passwordController.text;
    if (nombre.isEmpty ||
        apellido.isEmpty ||
        apellidoM.isEmpty ||
        cargo.isEmpty ||
        usuario.isEmpty ||
        password.isEmpty) {
      print(
          'Los controladores de los TextFormField hay uno o mas que estan vacios');
      return 'Los controladores de los TextFormField hay uno o mas que estan vacios';
    }
    final response = await http.post(
      Uri.parse('http://181.176.161.129:8080/app/apiv1/auth/register'),
/*       Uri.parse('http://10.0.2.2:3001/apiv1/auth/register'), */
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "user": usuario,
        "name": nombre,
        "lastName": apellido,
        "lastnameM": apellidoM,
        "workPosition": cargo,
        "password": password
      }),
    );
    print(response.statusCode);
    return true;
  }

  Widget initWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _globalkey,
          child: Column(
            children: [
              /*    Container(
                height: 350,

                // ignore: prefer_const_constructors
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 2, 17, 101),
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(90)),
                  image: const DecorationImage(
                    image: AssetImage('assets/login_app2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ), */
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(bottom: 20),
                    alignment: Alignment.centerRight,
                    /*    child: const Text(
                      "CREE SU CUENTA",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 12, 23, 92)),
                    ), */
                  )
                ],
              )),
              Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      (Color.fromARGB(255, 197, 91, 52)),
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
                  ),
                  /*      color: Color.fromARGB(255, 22, 41, 146), */

                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(
                      left: 5, right: 5, top: 10, bottom: 10),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 30),
                  child: Column(
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Container(padding: EdgeInsets.all(10)),
                          NombreTextfield(),
                          Container(padding: EdgeInsets.all(10)),
                          ApellidoPTextfield(),
                          Container(padding: EdgeInsets.all(10)),
                          ApellidoMTextfield(),
                          Container(padding: EdgeInsets.all(10)),
                          CargoTextfield(),
                          Container(padding: EdgeInsets.all(10)),
                          DNITextfield(),
                          Container(padding: EdgeInsets.all(0)),
                          PasswordTextfield(),
                          PasswordconfirmTextfield(),
                        ],
                      ))
                    ],
                  )),
              InkWell(
                onTap: () async {
                  final nombre = _nombreController.text;
                  final apellido = _apellidoController.text;
                  final apellidom = _apellidoMController.text;
                  final cargo = _cargoController.text;
                  final dni = _dniController.text;
                  final password = _passwordController.text;
                  final confirma_password = _passwordconfirmController.text;

                  try {
                    if (nombre.isEmpty) {
                      Fluttertoast.showToast(msg: 'Nombre vacio');
                      return print('Nombre Vacio');
                    }
                    if (apellido.isEmpty) {
                      Fluttertoast.showToast(msg: 'Apellido materno vacio');
                      return print('Apellido Vacio');
                    }
                    if (apellidom.isEmpty) {
                      Fluttertoast.showToast(msg: 'Apellido materno vacio');
                      return print('Apellido Vacio');
                    }
                    if (cargo.isEmpty) {
                      Fluttertoast.showToast(msg: 'Cargo vacio');
                      return print('Cargo Vacio');
                    }
                    if (dni.isEmpty) {
                      Fluttertoast.showToast(msg: 'DNI vacio');
                      return print('DNI Vacio');
                    }
                    if (password.isEmpty) {
                      Fluttertoast.showToast(msg: 'Contraseña vacio');
                      return print('Contraseña Vacio');
                    }
                    if (password != confirma_password) {
                      Fluttertoast.showToast(
                          msg: 'Contraseña Incorrecta o Vacia');
                      return print('Las Contraseñas no coinciden  Vacio');
                    }
                    if (password.length < 8) {
                      Fluttertoast.showToast(
                          msg:
                              'Ingrese una Constraseña de Minimo 8 caracteres');
                      return print(
                          'Ingrese una Constraseña de Minimo 8 caracteres');
                    }
                    if (dni.length != 8) {
                      Fluttertoast.showToast(msg: 'Ingrese un DNI Valido');
                      return print('Ingrese un DNI Valido');
                    }
                  } catch (e) {
                    print(e);
                  }

                  final res = await signup();

                  if (res == true) {
                    print('user created');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Color.fromARGB(255, 26, 108, 3),

                        content: Text('Usuario Registrado Exitosamente'),
                        duration: Duration(
                            seconds:
                                3), // Opcional: Configura la duración del SnackBar
                      ),
                    );
                    /*  showTemporaryDialog(
                        context, 'Usuario Creado Correctamente'); */
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                    isLoading == true
                        ? Container(
                            color: const Color.fromARGB(26, 0, 0, 0),
                            height: double.maxFinite,
                            width: double.maxFinite,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Text('');
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
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                    "CREAR CUENTA",
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
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      /*   onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      }, */
                      /*  child: const Text(
                        "Tiene una Cuenta? Ingrese Aqui",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ), */
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Tiene una cuenta?',
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
                                      builder: (context) => LoginScreen()));
                            },
                            child: const Text(
                              'Ingrese',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget NombreTextfield() {
    return Column(
      children: [
        TextFormField(
          /*  controller: _usernameController, */
          controller: _nombreController,
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
            hintText: "Nombre",
            hintStyle:
                const TextStyle(color: const Color.fromARGB(255, 42, 73, 119)),
            filled: true,
            fillColor: const Color.fromARGB(255, 224, 224, 224),
          ),
        )
      ],
    );
  }

  Widget ApellidoPTextfield() {
    return Column(
      children: [
        TextFormField(
          /*  controller: _usernameController, */
          controller: _apellidoController,
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
            hintText: "Apellido Paterno",
            hintStyle:
                const TextStyle(color: const Color.fromARGB(255, 42, 73, 119)),
            filled: true,
            fillColor: const Color.fromARGB(255, 224, 224, 224),
          ),
        )
      ],
    );
  }

  Widget ApellidoMTextfield() {
    return Column(
      children: [
        TextFormField(
          /*  controller: _usernameController, */
          controller: _apellidoMController,
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
            hintText: "Apellido materno",
            hintStyle:
                const TextStyle(color: const Color.fromARGB(255, 42, 73, 119)),
            filled: true,
            fillColor: const Color.fromARGB(255, 224, 224, 224),
          ),
        )
      ],
    );
  }

  Widget CargoTextfield() {
    return Column(
      children: [
        TextFormField(
          /*  controller: _usernameController, */
          controller: _cargoController,
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
            hintText: "Cargo",
            hintStyle:
                const TextStyle(color: const Color.fromARGB(255, 42, 73, 119)),
            filled: true,
            fillColor: const Color.fromARGB(255, 224, 224, 224),
          ),
        )
      ],
    );
  }

  Widget DNITextfield() {
    return Column(
      children: [
        TextFormField(
          /*  controller: _usernameController, */
          controller: _dniController,
          keyboardType: TextInputType.number,
          maxLength: 8,
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
            hintText: "DNI",
            hintStyle:
                const TextStyle(color: const Color.fromARGB(255, 42, 73, 119)),
            filled: true,
            fillColor: const Color.fromARGB(255, 224, 224, 224),
          ),
        )
      ],
    );
  }

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
            hintText: "Contraseña",
            hintStyle: const TextStyle(color: Color.fromARGB(255, 42, 73, 119)),
            filled: true,
            fillColor: const Color.fromARGB(255, 224, 224, 224),
            /* errorText: validate ? null : errorText, */
            suffixIcon: IconButton(
              icon: Icon(vis1 ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis1 = !vis1;
                });
              },
            ),
            helperStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          controller: _passwordController,
          cursorColor: const Color.fromARGB(255, 4, 107, 191),
          obscureText: vis1,
          onChanged: _validatePassword,
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget PasswordconfirmTextfield() {
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
            hintText: "Confime su Contraseña",
            hintStyle: const TextStyle(color: Color.fromARGB(255, 42, 73, 119)),
            filled: true,
            fillColor: const Color.fromARGB(255, 224, 224, 224),
            /* errorText: validate ? null : errorText, */
            suffixIcon: IconButton(
              icon: Icon(vis2 ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  vis2 = !vis2;
                });
              },
            ),
            helperStyle: const TextStyle(
              fontSize: 14,
            ),
          ),
          controller: _passwordconfirmController,
          cursorColor: const Color.fromARGB(255, 4, 107, 191),
          obscureText: vis2,
        ),
      ],
    );
  }
}

/* void showTemporaryDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Respuesta'),
        content: Text(message),
      );
    },
  );

  // Programa el cierre del diálogo después de 2 segundos
  Future.delayed(Duration(seconds: 2), () {
    Navigator.of(context).pop();
  });
} */

class GetStorage {
  void write(String s, codigousuario) {}
}
