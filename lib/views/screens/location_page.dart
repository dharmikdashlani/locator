import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  double lat = 0.0;
  double long = 0.0;

  Completer<GoogleMapController> mapcontroller = Completer();

  void onMapCreated(GoogleMapController controller) {
    mapcontroller.complete(controller);
  }

  MapType currentMapType = MapType.normal;

  late CameraPosition aposition;

  liveCoordinates() async {
    Geolocator.getPositionStream().listen((Position position) {
      setState(() {
        lat = position.latitude;
        long = position.longitude;
        aposition = CameraPosition(
          target: LatLng(lat, long),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Permission.location.request();
    liveCoordinates();
    aposition = CameraPosition(
      target: LatLng(lat, long),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> location =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _onMapTypeButtonPressed,
            icon: const Icon(Icons.map_outlined),
          ),
        ],
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "${location['companyname']}",
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          liveCoordinates();
          setState(() {
            aposition = CameraPosition(
              target: LatLng(location['latitude'], location['longitude']),
              zoom: 20,
            );
          });
          final GoogleMapController controller = await mapcontroller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(aposition));
        },
        label: const Text('Location'),
        icon: const Icon(Icons.gps_fixed_outlined),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "${location['latitude']}, ${location['longitude']}  ",
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 12,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapcontroller.complete(controller);
              },
              initialCameraPosition: aposition,
              mapType: currentMapType,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
        ],
      ),
    );
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      currentMapType =
          currentMapType == MapType.normal ? MapType.hybrid : MapType.normal;
    });
  }
}
