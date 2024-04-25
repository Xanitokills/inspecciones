// To parse this JSON data, do
//
//     final inspection = inspectionFromJson(jsonString);

import 'dart:convert';

Inspection inspectionFromJson(String str) =>
    Inspection.fromJson(json.decode(str));

String inspectionToJson(Inspection data) => json.encode(data.toJson());

class Inspection {
  bool status;
  String message;
  List<InspectionElement> inspection;

  Inspection({
    required this.status,
    required this.message,
    required this.inspection,
  });

  /* factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
        status: json["status"],
        message: json["message"],
        inspection: List<InspectionElement>.from(
            json["inspection"].map((x) => InspectionElement.fromJson(x))),
      ); */
  factory Inspection.fromJson(Map<String, dynamic> json) => Inspection(
        message: json["message"],
        status: json["status"],
        inspection: json["inspection"] != null
            ? List<InspectionElement>.from(
                json["inspection"].map((x) => InspectionElement.fromJson(x)),
              )
            : [],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "inspection": List<dynamic>.from(inspection.map((x) => x.toJson())),
      };
}

class InspectionElement {
  int ideInspeccion;
  dynamic nombreestacion;
  dynamic ideEstacion;
  DateTime fecInspeccion;
  double numLatitud;
  double numLongitud;
  dynamic numAltitud;
  String estTxTelevision;
  String estModuladorTv;
  String estRadioFm;
  String estTransmisorHf;
  String estAntenaTv;
  String estAntenaFm;
  String estReceptorSatelital;
  String estAntenaParabolica;
  String estPozoTierra;
  String estPararrayos;
  String estTorreSoporte;
  String desRecomendacion;
  String desConclusiones;
  String imgFoto1;
  String imgFoto2;
  String imgFoto3;
  dynamic estEstacion;
  int idUsuario;

  InspectionElement({
    required this.ideInspeccion,
    required this.nombreestacion,
    required this.ideEstacion,
    required this.fecInspeccion,
    required this.numLatitud,
    required this.numLongitud,
    required this.numAltitud,
    required this.estTxTelevision,
    required this.estModuladorTv,
    required this.estRadioFm,
    required this.estTransmisorHf,
    required this.estAntenaTv,
    required this.estAntenaFm,
    required this.estReceptorSatelital,
    required this.estAntenaParabolica,
    required this.estPozoTierra,
    required this.estPararrayos,
    required this.estTorreSoporte,
    required this.desRecomendacion,
    required this.desConclusiones,
    required this.imgFoto1,
    required this.imgFoto2,
    required this.imgFoto3,
    required this.estEstacion,
    required this.idUsuario,
  });

  factory InspectionElement.fromJson(Map<String, dynamic> json) =>
      InspectionElement(
        ideInspeccion: json["IDE_INSPECCION"],
        nombreestacion: json["NOMBRE_ESTACION"],
        ideEstacion: json["IDE_ESTACION"],
        fecInspeccion: DateTime.parse(json["FEC_INSPECCION"]),
        numLatitud: json["NUM_LATITUD"]?.toDouble(),
        numLongitud: json["NUM_LONGITUD"]?.toDouble(),
        numAltitud: json["NUM_ALTITUD"],
        estTxTelevision: json["EST_TX_TELEVISION"],
        estModuladorTv: json["EST_MODULADOR_TV"],
        estRadioFm: json["EST_RADIO_FM"],
        estTransmisorHf: json["EST_TRANSMISOR_HF"],
        estAntenaTv: json["EST_ANTENA_TV"],
        estAntenaFm: json["EST_ANTENA_FM"],
        estReceptorSatelital: json["EST_RECEPTOR_SATELITAL"],
        estAntenaParabolica: json["EST_ANTENA_PARABOLICA"],
        estPozoTierra: json["EST_POZO_TIERRA"],
        estPararrayos: json["EST_PARARRAYOS"],
        estTorreSoporte: json["EST_TORRE_SOPORTE"],
        desRecomendacion: json["DES_RECOMENDACION"],
        desConclusiones: json["DES_CONCLUSIONES"],
        imgFoto1: json["IMG_FOTO1"],
        imgFoto2: json["IMG_FOTO2"],
        imgFoto3: json["IMG_FOTO3"],
        estEstacion: json["EST_ESTACION"],
        idUsuario: json["ID_USUARIO"],
      );

  Map<String, dynamic> toJson() => {
        "IDE_INSPECCION": ideInspeccion,
        "NOMBRE_ESTACION": nombreestacion,
        "IDE_ESTACION": ideEstacion,
        "FEC_INSPECCION": fecInspeccion.toIso8601String(),
        "NUM_LATITUD": numLatitud,
        "NUM_LONGITUD": numLongitud,
        "NUM_ALTITUD": numAltitud,
        "EST_TX_TELEVISION": estTxTelevision,
        "EST_MODULADOR_TV": estModuladorTv,
        "EST_RADIO_FM": estRadioFm,
        "EST_TRANSMISOR_HF": estTransmisorHf,
        "EST_ANTENA_TV": estAntenaTv,
        "EST_ANTENA_FM": estAntenaFm,
        "EST_RECEPTOR_SATELITAL": estReceptorSatelital,
        "EST_ANTENA_PARABOLICA": estAntenaParabolica,
        "EST_POZO_TIERRA": estPozoTierra,
        "EST_PARARRAYOS": estPararrayos,
        "EST_TORRE_SOPORTE": estTorreSoporte,
        "DES_RECOMENDACION": desRecomendacion,
        "DES_CONCLUSIONES": desConclusiones,
        "IMG_FOTO1": imgFoto1,
        "IMG_FOTO2": imgFoto2,
        "IMG_FOTO3": imgFoto3,
        "EST_ESTACION": estEstacion,
        "ID_USUARIO": idUsuario,
      };
}
