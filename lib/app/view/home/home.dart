import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(4.824332, 6.9635055)),
      ),
    );
  }
}
