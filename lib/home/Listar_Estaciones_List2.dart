// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:appproyecto2/home/Registro_Inspeccion.dart';
import 'package:appproyecto2/home/nueva_inspeccion.dart';
import 'package:appproyecto2/models/Inspections_estacion.dart';
import 'package:appproyecto2/models/Inspections_estacion2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Listar_Estaciones_List2 extends StatelessWidget {
  Listar_Estaciones_List2({super.key, required this.stations2});
  final List<Datum2> stations2;
  final String idsstacionseleccionado = '';

  @override
  Widget build(BuildContext context) {
    print(stations2);
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        itemCount: stations2.length,
        itemBuilder: (BuildContext context, int index) {
          final station2 = stations2[index];
          return Card(
              elevation: 5,
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(station2.nombre_estacion.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
                leading: Icon(Icons.house_siding_rounded),
                subtitle: Text(station2.esta_estacion,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NuevaInspeccion(
                                /*  id: station.ide_estacion, */
                                id: station2.ide_estacion,
                                desLocalidad: station2.nombre_estacion,
                              )))
                },
              ));
        },
      ),
    );
  }
}
