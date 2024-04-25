// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:appproyecto2/home/Registro_Inspeccion.dart';
import 'package:appproyecto2/models/Inspections_estacion.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Listar_Estaciones_List extends StatelessWidget {
  Listar_Estaciones_List({super.key, required this.stations});
  final List<Datum> stations;
  final String idsstacionseleccionado = '';

  @override
  Widget build(BuildContext context) {
    print(stations);
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
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
      ),
    );
  }
}
