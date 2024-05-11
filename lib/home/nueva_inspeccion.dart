import 'dart:async';
import 'dart:convert';

import 'package:appproyecto2/constants/inspections.dart';
import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/home/Listar_Estaciones.dart';
import 'package:appproyecto2/widgets/Index_imagen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NuevaInspeccion extends StatefulWidget {
  const NuevaInspeccion(
      {super.key, required this.id, required this.desLocalidad});
  final String id;
  final String desLocalidad;
  @override
  State<NuevaInspeccion> createState() => _NuevaInspeccionState();
}

class _NuevaInspeccionState extends State<NuevaInspeccion> {
  bool isLoading = false;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;

  late StreamSubscription<Position> positionStream;
  DateTime now = new DateTime.now();

  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  String ide_estacion = "";
  String nombre_estacion = "";
  String des_recomendacion = "";
  String des_conclusiones = "";
  DateTime fec_inspeccion = DateTime.now();
  String num_longitud = "";
  String num_latitud = "";

  @override
  void initState() {
    checkGps();
    super.initState();
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
  }

  //Limpiar todos los input
  void clearInputs() {
    textEditingController.clear();
    textEditingController2.clear();
    listValuesDropDown.forEach((element) {
      element['value'] = '';
    });
    listValueImages.forEach((element) {
      element['value'] = '';
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

      setState(() {
        num_longitud = position.longitude.toString();
        num_latitud = position.latitude.toString();
      });
    });
  }

  // ignore: unused_element
  Future<bool> _guardarDatos(
      ide_estacion,
      nombre_estacion,
      num_longitud,
      num_latitud,
      fec_inspeccion,
      des_recomendacion,
      des_conclusiones,
      inspecciones,
      images,
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
      'nombre_estacion': widget.desLocalidad,
      'num_longitud': position.longitude.toString(),
      'num_latitud': position.latitude.toString(),
      'fec_inspeccion': fec_inspeccion = DateTime.now().toIso8601String(),
      'des_recomendacion': des_recomendacion,
      'des_conclusiones': des_conclusiones,
      'id_usuario': id_usuario,
      'list_inspeciones': inspecciones,
      'list_images': images
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
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          /*   title: const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 20.0), // Ajusta el valor según sea necesario
            child: Text(
              'Título con margen',
              style: TextStyle(
                fontSize:
                    20.0, // Ajusta el tamaño del texto según sea necesario
              ),
              
            ),
          ), */
          centerTitle: true,

          title: Text(
            'INSPECCIÓN TÉCNICA \n${widget.desLocalidad}',
          ),
          toolbarHeight: 80.0, // Ajusta el valor según sea necesario
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
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
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: double.infinity,
                    // color: Colors.grey,
                    child: Text("Longitude: $num_longitud",
                        style: const TextStyle(fontSize: 14)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Son todos los widgets de los dorpdown
                  /*  ListView(
                    shrinkWrap: true,
                    children: [ */
                  Container(
                      height: 380,
                      child: ListView(
                        shrinkWrap: false,
                        children: listValuesDropDown
                            .map(
                              (e) => Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e['label'].toString(),
                                  ),
                                  //MyDropDowButton()
                                  DropdownButton(
                                    items: dropDownOptions,
                                    value: e['value'],
                                    hint: const Text("Seleccione"),
                                    onChanged: (value) {
                                      setState(() {
                                        e['value'] = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      )),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor ingrese un valor';
                              }
                              return null;
                            },
                            controller: textEditingController,
                            decoration: const InputDecoration(
                              labelText: 'Recomendaciones',
                            ),
                            onChanged: (value) {
                              setState(() {
                                des_recomendacion = value;
                              });
                            },
                          ),
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Por favor ingrese un valor';
                              }
                              return null;
                            },
                            controller: textEditingController2,
                            decoration: const InputDecoration(
                              labelText: 'Conclusiones',
                            ),
                            onChanged: (value) {
                              setState(() {
                                des_conclusiones = value;
                              });
                            },
                          ),
                        ],
                      )),
                  Container(
                    height: 20,
                  ),
                  Container(
                    height: 400,
                    width: double.infinity,
                    child: ListView(
                      children: listValueImages
                          .map(
                            (e) => ImageIndex(
                              index: e['label'],
                              image: e['value'],
                              camera: () async {
                                try {
                                  final picker = ImagePicker();
                                  final pickerFile = await picker.pickImage(
                                      source: ImageSource.camera);

                                  if (pickerFile != null) {
                                    final imageBytes =
                                        await pickerFile.readAsBytes();
                                    setState(() {
                                      e['value'] = base64Encode(imageBytes);
                                    });
                                  } else {
                                    // No hacer nada si el usuario presiona el botón de atrás
                                    return;
                                  }
                                } catch (e) {
                                  print('Error al cargar la imagen: $e');
                                }
                              },
                              upload: () async {
                                try {
                                  final picker = ImagePicker();
                                  final pickerFile = await picker.pickImage(
                                      source: ImageSource.gallery);

                                  if (pickerFile != null) {
                                    final imageBytes =
                                        await pickerFile.readAsBytes();

                                    setState(() {
                                      e['value'] = base64Encode(imageBytes);
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor:
                                            Color.fromARGB(255, 84, 18, 4),
                                        content: Text(
                                            'No se seleccionó ninguna imagen'),
                                        duration: Duration(
                                            seconds:
                                                3), // Opcional: Configura la duración del SnackBar
                                      ),
                                    );
                                    return;
                                  }
                                } catch (e) {
                                  //show snackbar error
                                }
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 42, 155, 11),
                    ),
                    child: const Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      bool foundEmptyValue = false;

                      listValuesDropDown.forEach((e) {
                        if (e['value'] == '') {
                          setState(() {
                            foundEmptyValue = true;
                          });
                        }
                      });
                      if (foundEmptyValue) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(255, 162, 37, 12),
                            content: Text(
                                'Debe seleccionar un valor para cada campo'),
                            duration: Duration(
                                seconds:
                                    3), // Opcional: Configura la duración del SnackBar
                          ),
                        );
                        return;
                      }

                      //Validar que almenos haya 6 images cargadas
                      int countImages = 0;
                      listValueImages.forEach((e) {
                        if (e['value'] != '') {
                          setState(() {
                            countImages++;
                          });
                        }
                      });

                      if (countImages < 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(255, 84, 18, 4),
                            content: Text('Debe cargar al menos 6 imágenes'),
                            duration: Duration(
                                seconds:
                                    3), // Opcional: Configura la duración del SnackBar
                          ),
                        );
                        setState(() {
                          countImages = 0;
                        });
                        return;
                      }

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final iduser = prefs.getString('id');
                      final res = await _guardarDatos(
                        ide_estacion,
                        nombre_estacion,
                        num_longitud,
                        num_latitud,
                        fec_inspeccion,
                        des_recomendacion,
                        des_conclusiones,
                        listValuesDropDown,
                        listValueImages,
                        iduser,
                      );

                      if (res == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(255, 26, 108, 3),

                            content: Text(' Registro Exitoso'),
                            duration: Duration(
                                seconds:
                                    3), // Opcional: Configura la duración del SnackBar
                          ),
                        );
                        clearInputs();
                        Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListarEstaciones()),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(255, 84, 18, 4),

                            content: Text('Error de Registro'),
                            duration: Duration(
                                seconds:
                                    3), // Opcional: Configura la duración del SnackBar
                          ),
                        );
                      }
                    },
                  ),
                  /*    ],
                  ), */
                ],
              ),
            ),
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
