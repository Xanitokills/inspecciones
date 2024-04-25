import 'package:appproyecto2/constants/urls.dart';
import 'package:appproyecto2/models/Inspections_estacion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class List_Search2 extends StatelessWidget {
  List_Search2({super.key, required this.stations});
  late final List<Datum> stations;
  final String idsstacionseleccionado = '';
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
                  delegate: FruitSearchDelegate2(),
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

class FruitSearchDelegate2 extends SearchDelegate<String> {
  late final List<Datum> stations;

  Future<List<Datum>> getStations() async {
    var url = '';
    if (isLocal) {
      url = '$UrlApiLocal/project/get_estaciones';
    } else {
      url = '$UrlApi/project/get_estaciones';
    }

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json',
    });
    final decodeResponse = stationsFromJson(response.body);
    print(decodeResponse.data);
    return decodeResponse.data;
  }
/*   final List<String> allFruits = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Pineapple',
    'Grapes',
    'Watermelon',
    'Strawberry',
    'Blueberry',
  ]; */

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
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
    // Filtra la lista de frutas basándose en la consulta del usuario
    Future<List<Datum>> filteredFruits = getStations();

    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        return ListTile(
          title: Text(station.des_localidad.toString()),
          onTap: () {
            // Puedes hacer algo cuando se selecciona un elemento de la lista
            close(context, station.cod_ubigeo.toString());
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Muestra sugerencias mientras el usuario escribe
    List<Datum> suggestionList = stations;
/* .where((fruit) => fruit.toLowerCase().contains(query.toLowerCase()))
        .toList(); */

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        return ListTile(
          title: Text(station.des_localidad.toString()),
          onTap: () {
            // Puedes hacer algo cuando se selecciona una sugerencia
            query = station.ide_estacion.toString();
            close(context, query);
          },
        );
      },
    );
  }
}
