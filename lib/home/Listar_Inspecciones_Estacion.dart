import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/home/Listar_Inspeccion_Estaciones_List.dart';
import 'package:appproyecto2/models/Inspections_estacion.dart';
import 'package:appproyecto2/home/Listar_Estaciones_List.dart';
import 'package:appproyecto2/models/Inspections_inspeccion_%20estacion.dart';
import 'package:appproyecto2/widgets/Listar_Estaciones_Search.dart';
import 'package:appproyecto2/widgets/Listar_Inspeccion_Estaciones_Search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Listar_Ispeccion_Estaciones extends StatelessWidget {
  Listar_Ispeccion_Estaciones({super.key});

  Future<List<Datum3>> getStations2() async {
    var url = '';
    url = isLocal ? UrlApiLocal : UrlApi;
    final response = await http.get(
        Uri.parse('$url/project/get_estaciones_insp'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        });
    final decodeResponse = stationsFromJson2(response.body);
    print(decodeResponse.data);
    return decodeResponse.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Inspecciones por Estacion'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Listar_Inspeccion_EstacionesSearch(),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Datum3>>(
        future: getStations2(),
        builder: (BuildContext context, AsyncSnapshot snapshot2) {
          return snapshot2.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Listar_Inspeccion_Estaciones_List(stations2: snapshot2.data);
        },
      ),
    );
  }
}
