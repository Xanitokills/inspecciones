import 'dart:convert';

import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/models/Inspections.dart';
import 'package:appproyecto2/models/model_inspections.dart';
import 'package:appproyecto2/pages/Detalle_Inspeccion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class ListarInspecciones extends StatefulWidget {
  @override
  _ListarInspeccionesState createState() => _ListarInspeccionesState();
}

class _ListarInspeccionesState extends State<ListarInspecciones> {
  String _connectionStatus = 'Unknown';
  @override
  void initState() {
    super.initState();
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        _connectionStatus = 'Mobile data';
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        _connectionStatus = 'WiFi';
      });
    } else {
      setState(() {
        _connectionStatus = 'No connection';
      });
      _showNoConnectionSnackBar();
    }
  }

  void _showNoConnectionSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 228, 58, 24),
        content: Text('No Tienes conexión a internet'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  List<dynamic> data = [];

// Funcion asincrona, por eso asjajs, era esooooooooo
  Future getIdShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String idGuardado = prefs.getString('id') ?? "";
    return idGuardado;
  }

  Future<ModelInspections> getInspections() async {
    final id = await getIdShared();
    var url = '';
    url = isLocal ? UrlApiLocal : UrlApi;
/*  const url = 'http://181.176.161.129:8080/app/apiv1/project/getByUser'; */
    final response = await http.get(Uri.parse('$url/project/inspections/$id'));
    print(response.body);
    final decodeInspection = modelInspectionsFromJson(response.body);
    return decodeInspection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Inspecciones'),
      ),
      body: FutureBuilder<ModelInspections>(
        future: getInspections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras se obtienen los datos, puedes mostrar un indicador de carga.
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print(snapshot);
            // En caso de error, muestra un mensaje de error.
            return Text('Error: ${snapshot.error}');
          } else {
            final inspection = snapshot.data!.inspecciones;
            // Cuando los datos están disponibles, construye tu widget.
            return inspection.length < 1
                ? Center(child: Text('No tienes inspecciones  '))
                : ListView.builder(
                    itemCount: inspection.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Accede al elemento específico en tu lista usando tuLista[index]
                      final elemento = inspection[index];

                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.all(8),
                        child: ListTile(
                          title: Text(
                            /*   'ID: ${elemento.ideInspeccion.toString()}', */
                            'Estación : ${elemento.nombreEstacion.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          leading: Icon(
                            Icons.history,
                            color: Color.fromARGB(255, 6, 67, 133),
                          ),

                          /*      leading: Icon(Icons.house_siding_rounded), */
                          /*         leading: CircleAvatar(
                              child: Text(elemento.ideInspeccion.toString())), */

                          /*  child:   leading: Icon(Icons.web),  */
                          subtitle: Text(
                              'Fecha: ${elemento.fecInspeccion.year}-${elemento.fecInspeccion.month}-${elemento.fecInspeccion.day}'),
                          onTap: () {
                            // Manejar la acción cuando se toca el ListTile
                          },
                          trailing: IconButton(
                            onPressed: () {
                              // Manejar la acción cuando se toca el botón
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Detalle_Inspeccion(
                                            inspectionElement: elemento,
                                          )));
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
