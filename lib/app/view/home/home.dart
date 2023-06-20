// ignore_for_file: lines_longer_than_80_chars

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapduo/utils/constants.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapboxMapController? mapController;
  final locationPackage = Location();
  LocationData userLocation = LocationData.fromMap({});

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      askPermission();
    });
    super.initState();
  }

  Future<void> askPermission() async {
    final status = await Permission.location.isGranted;
    if (!status) {
      final location = await Permission.location.request();
      if (location.isGranted) {
        log('Location is granted');
        userLocation = await locationPackage.getLocation();
        log('Location is gotten');
        setState(() {});
      } else if (location.isLimited) {
        log('Location is limited');
      } else {
        log('Location is not granted');
      }
    }
  }

  Future<void> getLocation() async {
    await Location().getLocation().then((value) {
      setState(() {
        userLocation = value;
      });
      log('Latitude : ${value.latitude}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getLocation();
          await mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                zoom: 17,
                target: LatLng(userLocation.latitude!, userLocation.longitude!),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: MapboxMap(
          myLocationTrackingMode: MyLocationTrackingMode.TrackingGPS,
          myLocationEnabled: true,
          myLocationRenderMode: MyLocationRenderMode.NORMAL,
          onStyleLoadedCallback: () {},
          onMapCreated: (controller) {
            mapController = controller;
          },
          accessToken: mapApi,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              userLocation.latitude ?? 4.824332,
              userLocation.longitude ?? 6.9635055,
            ),
            zoom: 15,
          ),
        ),
      ),
    );
  }
}
