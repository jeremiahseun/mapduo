import 'dart:developer';

import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:mapduo/utils/constants.dart';

class SearchViewModel with ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  String selectedLocation = '';
  // late LatLng latLng;

  ///Reverse GeoCoding sample call
  Future<void> geoCoding() async {
    final geoCodingService = ReverseGeoCoding(
      apiKey: mapApi,
      country: 'NG',
      limit: 5,
    );

    final addresses = await geoCodingService.getAddress(
      const Location(
        lat: -19.984846,
        lng: -43.946852,
      ),
    );

    log(addresses!.toList().toString());
  }

  void onSearchTextChanged(String value) {}

  ///Places search sample call
  Future<void> placesSearch(String value) async {
    final placesService = PlacesSearch(
      apiKey: mapApi,
      country: 'NG',
      limit: 5,
    );

    final places = await placesService.getPlaces(
      value,
    );

    log(places!.toList().toString());
  }

  void onLocationSelected(String location) {
    selectedLocation = location;
    searchController.text = location;
    notifyListeners();
  }

  void searchForLocation(String value) {
    placesSearch(value);
  }
}
