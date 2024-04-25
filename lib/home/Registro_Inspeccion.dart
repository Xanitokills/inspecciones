// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:ui';

import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/home/Listar_Estaciones.dart';
import 'package:appproyecto2/widgets/Alert.dart';
// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: implementation_imports

List<DropdownMenuItem<String>> get dropdownTXTelevision {
  List<DropdownMenuItem<String>> txTVItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return txTVItems;
}

List<DropdownMenuItem<String>> get dropdownModuladorTV {
  List<DropdownMenuItem<String>> moduladorTVItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return moduladorTVItems;
}

List<DropdownMenuItem<String>> get dropdownRadioFM {
  List<DropdownMenuItem<String>> radioFMItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return radioFMItems;
}

List<DropdownMenuItem<String>> get dropdownTransmisorHF {
  List<DropdownMenuItem<String>> transmisorHFItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return transmisorHFItems;
}

List<DropdownMenuItem<String>> get dropdownAntenaTV {
  List<DropdownMenuItem<String>> antenaTVItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return antenaTVItems;
}

List<DropdownMenuItem<String>> get dropdownAntenaFM {
  List<DropdownMenuItem<String>> antenaFMItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return antenaFMItems;
}

List<DropdownMenuItem<String>> get dropdownreceptorSatelital {
  List<DropdownMenuItem<String>> receptorsatelitalItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return receptorsatelitalItems;
}

List<DropdownMenuItem<String>> get dropdownAntenaParabolica {
  List<DropdownMenuItem<String>> antenaprabolicaItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return antenaprabolicaItems;
}

List<DropdownMenuItem<String>> get dropdownPozoTierra {
  List<DropdownMenuItem<String>> pozotierraItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return pozotierraItems;
}

List<DropdownMenuItem<String>> get dropdownParaRayos {
  List<DropdownMenuItem<String>> pararayosItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return pararayosItems;
}

List<DropdownMenuItem<String>> get dropdownTorredeSoporte {
  List<DropdownMenuItem<String>> torredeSopoerteItems = const [
    DropdownMenuItem(child: Text("Seleccione"), value: ""),
    DropdownMenuItem(child: Text("Averiado"), value: "Averiado"),
    DropdownMenuItem(child: Text("Operativo"), value: "Operativo"),
    DropdownMenuItem(child: Text("Inexistente"), value: "Inexistente"),
    DropdownMenuItem(child: Text("Inoperativo"), value: "Inoperativo"),
    DropdownMenuItem(child: Text("Retirado"), value: "Retirado"),
    DropdownMenuItem(child: Text("Regular"), value: "Regular"),
    DropdownMenuItem(child: Text("Por Registrar"), value: "Por Registrar"),
  ];
  return torredeSopoerteItems;
}

class Registro_Isnpeccion extends StatefulWidget {
  final String id;
  final String deslocalidad2;
  Registro_Isnpeccion(
      {super.key, required this.id, required this.deslocalidad2});
  @override
  _Registro_IsnpeccionState createState() => _Registro_IsnpeccionState();
}

class _Registro_IsnpeccionState extends State<Registro_Isnpeccion> {
// Loading para ver el tiempo de carga y validar si tuvo exito la peticion o no
  bool isLoading = false;
  int conutImagesWData = 0;

  //Donde se guarda la imagen que se tome
  late String base64image1 = "";
  late String base64image2 = "";
  late String base64image3 = "";
  late String base64image4 = "";
  late String base64image5 = "";
  late String base64image6 = "";
  late String base64image7 = "";
  late String base64image8 = "";
  late String base64image9 = "";
  late String base64image10 = "";
  late String base64image11 = "";
  late String base64image12 = "";
  late String base64image13 = "";
  late String base64image14 = "";
  late String base64image15 = "";
  late String base64image16 = "";
  late String base64image17 = "";
  late String base64image18 = "";
  late String base64image19 = "";
  late String base64image20 = "";

//Coordenadas
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;

/*   String long = "", lat = ""; */
  late StreamSubscription<Position> positionStream;
  DateTime now = new DateTime.now();

  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String ide_estacion = "";
  String nombre_estacion = "";
  String des_recomendacion = "";
  String des_conclusiones = "";
  DateTime fec_inspeccion = DateTime.now();
  String num_longitud = "";
  String num_latitud = "";
  String selectedValueTV = '';
  String selectedValueModuladorTV = '';
  String selectedValueRadioFM = '';
  String selectedValueTransmisorHF = '';
  String selectedValueAntenaTV = '';
  String selectedValueAntenaFM = '';
  String selectedValueReceptorSatelital = '';
  String selectedValueAntenaParabolica = '';
  String selectedValuePozoTierra = '';
  String selectedValueParaRayos = '';
  String selectedValueTorreSoporte = '';
  @override
  String handleChangeComents(String value) {
    setState(() {
      des_recomendacion = value;
    });

    return des_recomendacion;
  }

  String handleChangeComents2(String value) {
    setState(() {
      des_conclusiones = value;
    });

    return des_conclusiones;
  }

  void clearForm() {
    setState(() {
      selectedValueTV = '';
      ide_estacion = '';
      des_recomendacion = "";
      des_conclusiones = "";
      textEditingController.clear();
      textEditingController2.clear();
      fec_inspeccion = DateTime.now();
      num_longitud = "";
      num_latitud = "";
      selectedValueModuladorTV = '';
      selectedValueRadioFM = '';
      selectedValueTransmisorHF = '';
      selectedValueAntenaTV = '';
      selectedValueAntenaFM = '';
      selectedValueReceptorSatelital = '';
      selectedValueAntenaParabolica = '';
      selectedValuePozoTierra = '';
      selectedValueParaRayos = '';
      selectedValueTorreSoporte = '';
      base64image1 = "";
      base64image2 = "";
      base64image3 = "";
      base64image4 = "";
      base64image5 = "";
      base64image6 = "";
      base64image7 = "";
      base64image8 = "";
      base64image9 = "";
      base64image10 = "";
      base64image11 = "";
      base64image12 = "";
      base64image13 = "";
      base64image14 = "";
      base64image15 = "";
      base64image16 = "";
      base64image17 = "";
      base64image18 = "";
      base64image19 = "";
      base64image20 = "";
      nombre_estacion = "";
    });
  }

/*   @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  } */

  void initState() {
    checkGps();
    super.initState();
  }

//Esto es para que podamos acceder ala camara y cuando tome la foto
// convertirla en base64

  Future<void> camera01() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image1 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload01() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image1 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera02() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image2 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload02() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image2 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera03() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image3 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload03() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image3 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera04() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image4 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload04() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image4 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera05() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image5 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload05() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image5 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera06() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image6 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload06() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image6 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera07() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image7 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload07() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image7 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera08() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image8 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload08() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image8 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera09() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image9 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload09() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image9 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera10() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image10 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload10() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image10 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera11() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image11 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload11() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image11 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera12() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image12 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload012() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image12 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera13() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image13 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload13() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image13 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera14() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image14 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload14() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image14 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera15() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image15 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload15() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image15 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera16() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image16 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload16() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image16 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera17() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image17 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload17() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image17 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera18() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image18 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload18() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image18 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera19() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image19 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload19() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image19 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }

  Future<void> camera20() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.camera);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image20 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen: $e');
    }
  }

  Future<void> upload20() async {
    try {
      final picker = ImagePicker();
      final pickerFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickerFile != null) {
        final imageBytes = await pickerFile.readAsBytes();
        setState(() {
          base64image20 = base64Encode(
              imageBytes); // Convertir los datos de la imagen en base64
        });
      } else {
        // No hacer nada si el usuario presiona el botón de atrás
        return;
      }
    } catch (e) {
      print('Error al cargar la imagen desde la galería: $e');
    }
  }
/*   void uploadImage() async {
    //se hace una instancia de la liberia para poder usar todas sus funciones
    ImagePicker picker = ImagePicker();
    //donde dice ImageSource podemos colocar .camera o .gallery, para acceder a galeria o a ala camara
    final pickerFile = await picker.pickImage(source: ImageSource.camera);

    //aca solo es validacion, de que si tomo imagen o no
    if (pickerFile != null) {
      final imageBytes = await pickerFile.readAsBytes();
      setState(() {
        //El base64Encode es para convertir los datos de la imagen en base 64 nada mas
        //se ponde dentro del setState para que la variable base64image sea lo de   base64Encode(imageBytes);
        base64image = base64Encode(imageBytes);
      });
    } else {
      //No hacer nada en dado caso el usuario le de al boton de atras
      return;
    }
  } */

/*   void uploadImage() async {
    //se hace una instancia de la liberia para poder usar todas sus funciones
    ImagePicker picker = ImagePicker();
    //donde dice ImageSource podemos colocar .camera o .gallery, para acceder a galeria o a ala camara
    /*    final pickerFile = await picker.pickImage(source: ImageSource.camera); */

    final pickerFile = await picker.getImage;

    //aca solo es validacion, de que si tomo imagen o no
    if (pickerFile != null) {
      final imageBytes = await pickerFile.readAsBytes();
      setState(() {
        //El base64Encode es para convertir los datos de la imagen en base 64 nada mas
        //se ponde dentro del setState para que la variable base64image sea lo de   base64Encode(imageBytes);
        base64image = base64Encode(imageBytes);
      });
    } else {
      //No hacer nada en dado caso el usuario le de al boton de atras
      return;
    }
  } */

  /* void uploadImage() async {
     late File _image;
  final picker = ImagePicker();
    //se hace una instancia de la liberia para poder usar todas sus funciones
    Future getImage(ImageSource source) async {
      final pickedFile = await picker.getImage(source: source);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }
  } */
/* 
  void uploadImage2() async {
    //se hace una instancia de la liberia para poder usar todas sus funciones
    ImagePicker picker2 = ImagePicker();
    //donde dice ImageSource podemos colocar .camera o .gallery, para acceder a galeria o a ala camara
    final pickerFile2 = await picker2.pickImage(source: ImageSource.camera);

    //aca solo es validacion, de que si tomo imagen o no
    if (pickerFile2 != null) {
      final imageBytes2 = await pickerFile2.readAsBytes();
      setState(() {
        //El base64Encode es para convertir los datos de la imagen en base 64 nada mas
        //se ponde dentro del setState para que la variable base64image sea lo de   base64Encode(imageBytes);
        base64image2 = base64Encode(imageBytes2);
      });
    } else {
      //No hacer nada en dado caso el usuario le de al boton de atras
      return;
    }
  } */

/*   void uploadImage3() async {
    //se hace una instancia de la liberia para poder usar todas sus funciones
    ImagePicker picker3 = ImagePicker();
    //donde dice ImageSource podemos colocar .camera o .gallery, para acceder a galeria o a ala camara
    final pickerFile3 = await picker3.pickImage(source: ImageSource.gallery);

    //aca solo es validacion, de que si tomo imagen o no
    if (pickerFile3 != null) {
      final imageBytes3 = await pickerFile3.readAsBytes();
      setState(() {
        //El base64Encode es para convertir los datos de la imagen en base 64 nada mas
        //se ponde dentro del setState para que la variable base64image sea lo de   base64Encode(imageBytes);
        base64image3 = base64Encode(imageBytes3);
      });
    } else {
      //No hacer nada en dado caso el usuario le de al boton de atras
      return;
    }
  } */

// TODO: Request permission
  checkGPS<bool>() async {
    final isActive = await Geolocator.isLocationServiceEnabled();
    /*   print('permission----------------------$isActive'); */
    return isActive;
  }

  Future _getPositions() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // return Future.error('Location services are disabled.');
      return 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // return Future.error('Location permissions are denied');
        return 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }

    return await checkGps();
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Se deniegan los permisos de ubicación');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Los permisos de ubicación se deniegan permanentemente");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      // Geolocator();
      print("El servicio GPS no está habilitado, active la ubicación GPS");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
/*     print(position.longitude); //Output: 80.24599079
    print(position.latitude);  */ //Output: 29.6593457

    num_longitud = position.longitude.toString();
    num_latitud = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      num_longitud = position.longitude.toString();
      num_latitud = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
    });
  }

  Future<bool> _guardarDatos(
      ide_estacion,
      nombre_estacion,
      est_tx_television,
      est_modulador_tv,
      est_radio_fm,
      est_transmisor_hf,
      est_antena_tv,
      est_antena_fm,
      est_receptor_satelital,
      est_antena_parabolica,
      est_pozo_tierra,
      est_pararrayos,
      est_torre_soporte,
      img_foto1,
      num_longitud,
      num_latitud,
      fec_inspeccion,
      des_recomendacion,
      des_conclusiones,
      img_foto2,
      img_foto3,
      img_foto4,
      img_foto5,
      img_foto6,
      img_foto7,
      img_foto8,
      img_foto9,
      img_foto10,
      img_foto11,
      img_foto12,
      img_foto13,
      img_foto14,
      img_foto15,
      img_foto16,
      img_foto17,
      img_foto18,
      img_foto19,
      img_foto20,
      id_usuario) async {
    var url = '';
    if (isLocal) {
      // url = 'http://181.176.161.129:8080/app/apiv1/project/add';
      //url = 'http://181.176.161.129:8080/apiv1/project/add';
      url = '$UrlApiLocal/project/add';
    } else {
      url = 'http://181.176.161.129:8080/app/apiv1/project/add';
    }
    var body = {
      'ide_estacion': widget.id,
      'nombre_estacion': widget.deslocalidad2,
      'est_tx_television': est_tx_television,
      'est_modulador_tv': est_modulador_tv,
      'est_radio_fm': est_radio_fm,
      'est_transmisor_hf': est_transmisor_hf,
      'est_antena_tv': est_antena_tv,
      'est_antena_fm': est_antena_fm,
      'est_receptor_satelital': est_receptor_satelital,
      'est_antena_parabolica': est_antena_parabolica,
      'est_pozo_tierra': est_pozo_tierra,
      'est_pararrayos': est_pararrayos,
      'est_torre_soporte': est_torre_soporte,
      'img_foto1': img_foto1,
      'num_longitud': position.longitude.toString(),
      'num_latitud': position.latitude.toString(),
      'fec_inspeccion': fec_inspeccion = DateTime.now().toIso8601String(),
      'des_recomendacion': des_recomendacion,
      'des_conclusiones': des_conclusiones,
      'img_foto2': img_foto2,
      'img_foto3': img_foto3,
      'img_foto4': img_foto4,
      'img_foto5': img_foto5,
      'img_foto6': img_foto6,
      'img_foto7': img_foto7,
      'img_foto8': img_foto8,
      'img_foto9': img_foto9,
      'img_foto10': img_foto10,
      'img_foto11': img_foto11,
      'img_foto12': img_foto12,
      'img_foto13': img_foto13,
      'img_foto14': img_foto14,
      'img_foto15': img_foto15,
      'img_foto16': img_foto16,
      'img_foto17': img_foto17,
      'img_foto18': img_foto18,
      'img_foto19': img_foto19,
      'img_foto20': img_foto20,
      'id_usuario': id_usuario
    };
    final bodyDecode = json.encode(body);
    setState(() {
      isLoading = true;
    });
    var response = await http.post(
      /*      Uri.parse('http://10.0.2.2:3001/apiv1/project/add'), */
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: bodyDecode,
    );

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      return true;
    } else {
      setState(() {
        isLoading = false;
      });
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
/*     DateTime now = DateTime.now();
    final formattedDate = "${now.day}-${now.month}-${now.year}"; */
    /*     String formattedDate = DateFormat('yyyy-MM-dd').format(now);  */
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'INSPECCIÓN TÉCNICA \n${widget.deslocalidad2}',
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: Text(
                        'Fecha de Inspección:${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}',
                        /*   String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now) 

                         "${now.day}-${now.month}-${now.year}",  */
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: Text(
                        "Latitude: $num_latitud",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: Text("Longitude: $num_longitud",
                          style: TextStyle(fontSize: 14)),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      height: 20,
                      // color: Colors.grey,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: Text('1. Seleccione un estado:',
                          style: TextStyle(fontSize: 16)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'TX TELEVISIÓN',
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            items: dropdownTXTelevision,
                            value: selectedValueTV,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueTV = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'MODULADOR TV',
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            items: dropdownModuladorTV,
                            value: selectedValueModuladorTV,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueModuladorTV = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'TX RADIO FM',
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            items: dropdownRadioFM,
                            value: selectedValueRadioFM,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueRadioFM = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'TRANSMISOR HF',
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            items: dropdownTransmisorHF,
                            value: selectedValueTransmisorHF,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueTransmisorHF = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'ANTENA TV',
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            items: dropdownAntenaTV,
                            value: selectedValueAntenaTV,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueAntenaTV = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'ANTENA FM',
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            items: dropdownAntenaFM,
                            value: selectedValueAntenaFM,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueAntenaFM = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'RECEPTOR SATELITAL',
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            items: dropdownreceptorSatelital,
                            value: selectedValueReceptorSatelital,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueReceptorSatelital =
                                    value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'ANTENA PARABÓLICA',
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            items: dropdownAntenaParabolica,
                            value: selectedValueAntenaParabolica,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueAntenaParabolica =
                                    value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'POZO A TIERRA',
                          textAlign: TextAlign.left,
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            alignment: Alignment.centerRight,
                            items: dropdownPozoTierra,
                            value: selectedValuePozoTierra,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValuePozoTierra = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'PARA RRAYOS',
                          textAlign: TextAlign.left,
                        ),

                        //MyDropDowButton()
                        DropdownButton(
                            alignment: Alignment.centerRight,
                            items: dropdownParaRayos,
                            value: selectedValueParaRayos,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueParaRayos = value.toString();
                              });
                            })
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'TORRE DE SOPORTE',
                          textAlign: TextAlign.left,
                        ),
                        //MyDropDowButton()
                        DropdownButton(
                            alignment: Alignment.centerRight,
                            items: dropdownTorredeSoporte,
                            value: selectedValueTorreSoporte,
                            hint: const Text("Seleccione"),
                            onChanged: (value) {
                              setState(() {
                                selectedValueTorreSoporte = value.toString();
                              });
                            })
                      ],
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: TextField(
                        maxLength: 240,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          labelText: '2. Ingrese Recomendación',
                        ),
                        onChanged: (value) => handleChangeComents(value),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: TextField(
                        maxLength: 240,
                        controller: textEditingController2,
                        decoration: InputDecoration(
                          labelText: '3. Ingrese Conclusiones',
                        ),
                        onChanged: (value) => handleChangeComents2(value),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 10,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      // color: Colors.grey,
                      child: Text('4. Evidencias Fotográficas:',
                          style: TextStyle(fontSize: 16)),
                    ),
                    /*    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 80,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ), */

                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 20,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Foto Frontal\n de Estación'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera01();
                                  },
                                  child: base64image1.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image1),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload01();
                                  },
                                  child: base64image1.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image1),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Acta de\n Inspección\n de Ficha'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera02();
                                  },
                                  child: base64image2.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image2),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload02();
                                  },
                                  child: base64image2.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image2),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),

/*

2

*/
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Toma de Torre'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera03();
                                  },
                                  child: base64image3.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image3),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload03();
                                  },
                                  child: base64image3.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image3),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 16,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),

                    /*3*/

                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Rack Completo'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera04();
                                  },
                                  child: base64image4.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image4),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload04();
                                  },
                                  child: base64image4.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image4),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),

                    /*4*/

                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Transmisor'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera05();
                                  },
                                  child: base64image5.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image5),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload05();
                                  },
                                  child: base64image5.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image5),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),

                    /*5*/

                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Modulador'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera06();
                                  },
                                  child: base64image6.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image6),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload06();
                                  },
                                  child: base64image6.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image6),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 16,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 7'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera07();
                                  },
                                  child: base64image7.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image7),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload07();
                                  },
                                  child: base64image7.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image7),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 8'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera08();
                                  },
                                  child: base64image8.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image8),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload08();
                                  },
                                  child: base64image8.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image8),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 9'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera09();
                                  },
                                  child: base64image9.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image9),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload09();
                                  },
                                  child: base64image9.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image9),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 10'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera10();
                                  },
                                  child: base64image10.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image10),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload10();
                                  },
                                  child: base64image10.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image10),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 11'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera11();
                                  },
                                  child: base64image11.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image11),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload11();
                                  },
                                  child: base64image11.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image11),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 12'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera12();
                                  },
                                  child: base64image12.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image12),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload012();
                                  },
                                  child: base64image12.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image12),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 13'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera13();
                                  },
                                  child: base64image13.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image13),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload13();
                                  },
                                  child: base64image13.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image13),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 14'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera14();
                                  },
                                  child: base64image14.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image14),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload14();
                                  },
                                  child: base64image14.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image14),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 15'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera15();
                                  },
                                  child: base64image15.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image15),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload15();
                                  },
                                  child: base64image15.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image15),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 16'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera16();
                                  },
                                  child: base64image16.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image16),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload16();
                                  },
                                  child: base64image16.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image16),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 17'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera17();
                                  },
                                  child: base64image17.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image17),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload17();
                                  },
                                  child: base64image17.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image17),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 18'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera18();
                                  },
                                  child: base64image18.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image18),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload18();
                                  },
                                  child: base64image18.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image18),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 19'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera19();
                                  },
                                  child: base64image19.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image19),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload19();
                                  },
                                  child: base64image19.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image19),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Imagen 20'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    camera20();
                                  },
                                  child: base64image20.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image20),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Cámara'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    upload20();
                                  },
                                  child: base64image20.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image20),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Galeria'),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),

                    /*  Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Tomar Foto'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    uploadImage();
                                  },
                                  child: base64image.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Foto'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    uploadImage2();
                                  },
                                  child: base64image2.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image2),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Foto'),
                                ),
                              ),
                            ),
                          ],
                        )), */
                    /*   Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 8,
                      // color: Colors.grey,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        // color: Colors.grey,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Subir Foto'),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: TextButton(
                                  onPressed: () {
                                    uploadImage3();
                                  },
                                  child: base64image3.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Image.memory(
                                            base64Decode(base64image3),
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Text('Foto'),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 100,
                            ),
                          ],
                        )),
 */
                    const SizedBox(height: 40.0, width: 30),
                    ElevatedButton(
                      onPressed: () async {
                        if (selectedValueTV.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text(
                                  'Seleccione Estado de TX Televisión'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueModuladorTV.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text(
                                  'Seleccione Estado de Modulador TV'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueRadioFM.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text('Seleccione Estado de Radio'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueTransmisorHF.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text(
                                  'Seleccione Estado de Transmisor HF'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueAntenaTV.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content:
                                  const Text('Seleccione Estado de Antena TV'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueAntenaFM.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content:
                                  const Text('Seleccione Estado de Antena FM'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueReceptorSatelital.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text(
                                  'Seleccione Estado de Receptor Satelital'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueAntenaParabolica.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text(
                                  'Seleccione Estado de Receptor Antena Parabólica'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValuePozoTierra.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text(
                                  'Seleccione Estado de Pozo a Tierra'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueParaRayos.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content:
                                  const Text('Seleccione Estado de Pararrayos'),
                              actions: <Widget>[
                                /* TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ), */
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (selectedValueTorreSoporte.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text(
                                  'Seleccione Estado de Torre de Soporte'),
                              actions: <Widget>[
                                /* TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ), */
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (des_recomendacion.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text('Ingrese una recomendación'),
                              actions: <Widget>[
                                /*  TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ), */
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else if (des_conclusiones.isEmpty) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Alerta'),
                              content: const Text('Ingrese una conclusión'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          if (base64image1.isEmpty) {
                            //Aca se puede mostrar un alerta
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Alerta'),
                                content:
                                    const Text('Toma evidencias, fotografia'),
                                actions: <Widget>[
                                  /* TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ), */
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'OK'),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final iduser = prefs.getString('id');
                            final res = await _guardarDatos(
                                ide_estacion,
                                nombre_estacion,
                                selectedValueTV,
                                selectedValueModuladorTV,
                                selectedValueRadioFM,
                                selectedValueTransmisorHF,
                                selectedValueAntenaTV,
                                selectedValueAntenaFM,
                                selectedValueReceptorSatelital,
                                selectedValueAntenaParabolica,
                                selectedValuePozoTierra,
                                selectedValueParaRayos,
                                selectedValueTorreSoporte,
                                base64image1,
                                num_longitud,
                                num_latitud,
                                fec_inspeccion,
                                des_recomendacion,
                                des_conclusiones,
                                base64image2,
                                base64image3,
                                base64image4,
                                base64image5,
                                base64image6,
                                base64image7,
                                base64image8,
                                base64image9,
                                base64image10,
                                base64image11,
                                base64image12,
                                base64image13,
                                base64image14,
                                base64image15,
                                base64image16,
                                base64image17,
                                base64image18,
                                base64image19,
                                base64image20,
                                /* base64image2,
                                base64image3, */
                                iduser);

                            if (res == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 26, 108, 3),

                                  content: Text(' Registro Exitoso'),
                                  duration: Duration(
                                      seconds:
                                          3), // Opcional: Configura la duración del SnackBar
                                ),
                              );

                              clearForm();
                              // ignore: use_build_context_synchronously
                              Navigator.pop(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ListarEstaciones()),
                              );
                            } else {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor:
                                      Color.fromARGB(255, 84, 18, 4),

                                  content: Text('Error de Registro'),
                                  duration: Duration(
                                      seconds:
                                          3), // Opcional: Configura la duración del SnackBar
                                ),
                              );
                            }
                          }
                        }
                      },
                      child: const Text('Guardar'),
                    ),
                  ],
                ),
              ),
            ),
            isLoading == true
                ? Container(
                    color: const Color.fromARGB(26, 0, 0, 0),
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : const Text('')
          ],
        ),
      ),
    );
  }

  /*  void showTemporaryDialog(BuildContext context, String message) {
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
}
