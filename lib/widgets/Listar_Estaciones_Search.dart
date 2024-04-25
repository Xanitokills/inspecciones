import 'package:flutter/material.dart';
import 'package:appproyecto2/home/Registro_Inspeccion.dart';
import 'package:appproyecto2/models/Inspections_estacion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../constants/urls.dart';

class ListarEstacionesSearch extends SearchDelegate<String> {
  final String idsstacionseleccionado = '';
  Future<Stations> getStations(String param) async {
    var url = '';
    if (isLocal) {
      url = '$UrlApiLocal/project/get_estacionesByParam/$param';
    } else {
      url = '$UrlApi/project/get_estacionesByParam/$param';
    }

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
    });
    final decodeResponse = stationsFromJson(response.body);
    print('decode data');
    return decodeResponse;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    print('cargando');
    return FutureBuilder(
        future: getStations(query.toLowerCase()),
        builder: (BuildContext context, AsyncSnapshot<Stations> snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: const CircularProgressIndicator())
              : BuildStationsReults(stations: snapshot.data!.data);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // // Muestra sugerencias mientras el usuario escribe
    // List<Datum> suggestionList = stations;
    // /*      .where((fruit) => fruit.toLowerCase().contains(query.toLowerCase()))
    //     .toList(); */
    return Container();
    // return ListView.builder(
    //   itemCount: suggestionList.length,
    //   itemBuilder: (context, index) {
    //     final station = stations[index];
    //     return ListTile(
    //       title: Text(station.des_localidad.toString()),
    //       onTap: () {
    //         // Puedes hacer algo cuando se selecciona una sugerencia
    //         query = station.cod_ubigeo.toString();
    //         close(context, query);
    //       },
    //     );
    //   },
    //   );
    // }
  }
}

class List_Search extends StatelessWidget {
  late final List<Datum> stations;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fruit Search'),
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
        body: Center(
          child: Text('Search for fruits using the search icon.'),
        ),
      ),
    );
  }
}

class BuildStationsReults extends StatelessWidget {
  const BuildStationsReults({super.key, required this.stations});
  final List<Datum> stations;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (BuildContext context, int index) {
        final station = stations[index];
        return Card(
            elevation: 5,
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text(
                  station.des_localidad.toString() +
                      " " +
                      station.cod_ubigeo.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
              leading: Icon(Icons.house_siding_rounded),
              subtitle: Text(station.est_estacion,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Registro_Isnpeccion(
                              /*  id: station.ide_estacion, */
                              id: station.ide_estacion,
                              deslocalidad2: station.des_localidad,
                            )))
              },
            ));
      },
    );
  }
}
