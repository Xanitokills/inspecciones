// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:appproyecto2/models/map_style.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:geolocator/geolocator.dart';
import 'dart:typed_data';

// ignore: depend_on_referenced_packages
import 'package:location/location.dart' as location;

class Estaciones_Maps extends StatefulWidget {
  const Estaciones_Maps({Key? key}) : super(key: key);

  @override
  _Estaciones_MapsState createState() => _Estaciones_MapsState();
}

class _Estaciones_MapsState extends State<Estaciones_Maps> {
  late bool servicestatus;
  late bool haspermission;
  late LocationPermission permission;
  late Position position;
  late StreamSubscription<Position> positionStream;
  late String num_longitud;
  late String num_latitud;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0.347596, 32.582520),
    zoom: 14.4746,
  );

  final Set<Marker> _markers = {};
  late GoogleMapController _controller;
  final List<Map<String, dynamic>> _contacts = [
    {
      "name": "Me",
      "position": const LatLng(-12.04318, -77.02824),
      "marker": 'assets/markers/marker-1.png',
      "image": 'assets/images/avatar-1.png',
    },
    {
      "name": "Samantha",
      "position": const LatLng(37.42484642575639, -122.08309359848501),
      "marker": 'assets/markers/marker-2.png',
      "image": 'assets/images/avatar-2.png',
    },
    {
      "name": "Malte",
      "position": const LatLng(37.42381625902441, -122.0928531512618),
      "marker": 'assets/markers/marker-3.png',
      "image": 'assets/images/avatar-3.png',
    },
    {
      "name": "Julia",
      "position": const LatLng(37.41994095849639, -122.08159055560827),
      "marker": 'assets/markers/marker-4.png',
      "image": 'assets/images/avatar-4.png',
    },
    {
      "name": "Tim",
      "position": const LatLng(37.413175077529935, -122.10101041942836),
      "marker": 'assets/markers/marker-5.png',
      "image": 'assets/images/avatar-5.png',
    },
    {
      "name": "Sara",
      "position": const LatLng(37.419013242401576, -122.11134664714336),
      "marker": 'assets/markers/marker-6.png',
      "image": 'assets/images/avatar-6.png',
    },
    {
      "name": "Ronaldo",
      "position": const LatLng(37.40260962243491, -122.0976958796382),
      "marker": 'assets/markers/marker-7.png',
      "image": 'assets/images/avatar-7.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    checkGps();
  }

  @override
  void dispose() {
    positionStream.cancel();
    super.dispose();
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
        getLocation();
      }
    } else {
      print("El servicio GPS no está habilitado, active la ubicación GPS");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    num_longitud = position.longitude.toString();
    num_latitud = position.latitude.toString();

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      num_longitud = position.longitude.toString();
      num_latitud = position.latitude.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    createMarkers(context);

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            markers: _markers,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(MapStyle().aubergine);
            },
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _controller.moveCamera(
                        CameraUpdate.newLatLng(
                          _contacts[index]["position"] as LatLng,
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            _contacts[index]['image'] as String,
                            width: 60,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            _contacts[index]["name"] as String,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void createMarkers(BuildContext context) async {
    _contacts.forEach((contact) async {
      Marker marker = Marker(
        markerId: MarkerId(contact['name'] as String),
        position: contact['position'] as LatLng,
        icon: await _getAssetIcon(context, contact['marker'] as String),
        infoWindow: InfoWindow(
          title: contact['name'] as String,
          snippet: 'Street 6 . 2min ago',
        ),
      );

      setState(() {
        _markers.add(marker);
      });
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(
    BuildContext context,
    String icon,
  ) async {
    final Completer<BitmapDescriptor> bitmapIcon =
        Completer<BitmapDescriptor>();
    final ImageConfiguration config =
        createLocalImageConfiguration(context, size: const Size(5, 5));

    AssetImage(icon)
        .resolve(config)
        .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
      final ByteData? bytes = await image.image.toByteData(
        format: ImageByteFormat.png,
      );
      final BitmapDescriptor bitmap =
          BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
      bitmapIcon.complete(bitmap);
    }));

    return await bitmapIcon.future;
  }
}
