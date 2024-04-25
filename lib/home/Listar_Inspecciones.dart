import 'dart:convert';
import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/models/Inspections.dart';

import 'package:appproyecto2/pages/Detalle_Inspeccion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ListarInspecciones extends StatefulWidget {
  @override
  _ListarInspeccionesState createState() => _ListarInspeccionesState();
}

class _ListarInspeccionesState extends State<ListarInspecciones> {
  List<dynamic> data = [];

// Funcion asincrona, por eso asjajs, era esooooooooo
  Future getIdShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String idGuardado = prefs.getString('id') ?? "";
    return idGuardado;
  }

  Future<Inspection> getInspections() async {
    final id = await getIdShared();
    var url = '';
    url = isLocal ? UrlApiLocal : UrlApi;
    // const url = 'http://181.176.161.129:8080/app/apiv1/project/getByUser';
    final response = await http.post(Uri.parse('$url/project/getByUser'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({"id": id}));
    print(id);
    print(response.body);
    print(response.statusCode);
    final decodeInspection = inspectionFromJson(response.body);
    return decodeInspection;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Inspecciones'),
      ),
      body: FutureBuilder<Inspection>(
        future: getInspections(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Mientras se obtienen los datos, puedes mostrar un indicador de carga.
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // En caso de error, muestra un mensaje de error.
            return Text('Error: ${snapshot.error}');
          } else {
            final inspection = snapshot.data!.inspection;
            // Cuando los datos están disponibles, construye tu widget.
            return inspection.length < 1
                ? Center(child: Text('No tienes inspecciones'))
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
                              'Estación : ${elemento.nombreestacion.toString()}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            leading: CircleAvatar(
                                child: Text(elemento.ideInspeccion.toString())),
                            /*    leading: Icon(Icons.web), */
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
                                        builder: (context) =>
                                            Detalle_Inspeccion(
                                              inspectionElement: elemento,
                                            )));
                              },
                              icon: const Icon(Icons.arrow_forward_ios),
                            )),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}
