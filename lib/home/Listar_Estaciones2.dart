import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/home/Listar_Estaciones_List2.dart';
import 'package:appproyecto2/models/Inspections_estacion.dart';
import 'package:appproyecto2/home/Listar_Estaciones_List.dart';
import 'package:appproyecto2/models/Inspections_estacion2.dart';
import 'package:appproyecto2/widgets/Listar_Estaciones_Search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListarEstaciones2 extends StatelessWidget {
  ListarEstaciones2({super.key});

  Future<List<Datum2>> getStations2() async {
    var url = '';
    url = isLocal ? UrlApiLocal : UrlApi;
    /*   if (isLocal) {
      url = '$UrlApiLocal/project/get_estaciones';
    } else {
/*       url = '$UrlApi/project/get_estaciones'; */
      url = '$UrlApi/project/get_estaciones';
    }  */
    /*  url = '$UrlApi/project/get_estaciones'; */
    final response = await http.get(Uri.parse('$url/project/get_estaciones2'),
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
        title: Text('Inspecciones'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ListarEstacionesSearch(),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Datum2>>(
        future: getStations2(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Listar_Estaciones_List2(stations2: snapshot.data);
        },
      ),
    );
  }
}
