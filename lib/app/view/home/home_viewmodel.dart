// // ignore_for_file: inference_failure_on_instance_creation, unused_field

// import 'dart:developer';

// import 'package:flutter/material.dart';
// // import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
// import 'package:location/location.dart' as location;
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:mapbox_search/mapbox_search.dart';
// import 'package:permission_handler/permission_handler.dart';

// class HomeViewModel with ChangeNotifier {
//   MapboxMapController? mapController;
//   final locationPackage = location.Location();
//   location.LocationData userLocation = location.LocationData.fromMap({});

//   ///?
//   // String? _instruction;
//   // final bool _isMultipleStop = false;
//   // // ignore: avoid_multiple_declarations_per_line
//   // double? _distanceRemaining, _durationRemaining;
//   // MapBoxNavigationViewController? _controller;
//   // bool _routeBuilt = false;
//   // bool _isNavigating = false;
//   // final bool _inFreeDrive = false;
//   // late MapBoxOptions _navigationOption;
//   // String? _platformVersion;

//   ///?

//   Future<void> animateToLocation() async {
//     await getLocation();
//     await mapController?.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           zoom: 17,
//           target: LatLng(
//             userLocation.latitude!,
//             userLocation.longitude!,
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> askPermission() async {
//     final status = await Permission.location.isGranted;
//     if (!status) {
//       final location = await Permission.location.request();
//       if (location.isGranted) {
//         log('Location is granted');
//         userLocation = await locationPackage.getLocation();
//         log('Location is gotten');
//         notifyListeners();
//       } else if (location.isLimited) {
//         log('Location is limited');
//       } else {
//         log('Location is not granted');
//       }
//     }
//   }

//   ///Reverse GeoCoding sample call
//   Future<void> geoCoding(String apiKey) async {
//     final geoCodingService = ReverseGeoCoding(
//       apiKey: apiKey,
//       country: 'NG',
//       limit: 5,
//     );

//     final addresses = await geoCodingService.getAddress(
//       const Location(
//         lat: -19.984846,
//         lng: -43.946852,
//       ),
//     );

//     log(addresses!.toList().toString());
//   }

//   ///Places search sample call
//   Future<void> placesSearch(String apiKey) async {
//     final placesService = PlacesSearch(
//       apiKey: apiKey,
//       country: 'BR',
//       limit: 5,
//     );

//     final places = await placesService.getPlaces(
//       'patio',
//       proximity: const Location(
//         lat: -19.984634,
//         lng: -43.9502958,
//       ),
//     );

//     log(places!.toList().toString());
//   }

//   Future<void> getLocation() async {
//     await location.Location().getLocation().then((value) {
//       userLocation = value;
//       notifyListeners();
//       log('Latitude : ${value.latitude}');
//     });
//   }

//   ///? NAVIGATION SET
//   ///
//   ///
//   // Future<void> _onEmbeddedRouteEvent(e) async {
//   //   _distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
//   //   _durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();

//   //   switch (e.eventType) {
//   //     case MapBoxEvent.progress_change:
//   //       final progressEvent = e.data as RouteProgressEvent;
//   //       if (progressEvent.currentStepInstruction != null) {
//   //         _instruction = progressEvent.currentStepInstruction;
//   //       }
//   //       break;
//   //     case MapBoxEvent.route_building:
//   //     case MapBoxEvent.route_built:
//   //       _routeBuilt = true;
//   //       notifyListeners();
//   //       break;
//   //     case MapBoxEvent.route_build_failed:
//   //       _routeBuilt = false;
//   //       notifyListeners();
//   //       break;
//   //     case MapBoxEvent.navigation_running:
//   //       _isNavigating = true;
//   //       notifyListeners();
//   //       break;
//   //     case MapBoxEvent.on_arrival:
//   //       if (!_isMultipleStop) {
//   //         await Future.delayed(const Duration(seconds: 3));
//   //         await _controller?.finishNavigation();
//   //       } else {}
//   //       break;
//   //     case MapBoxEvent.navigation_finished:
//   //     case MapBoxEvent.navigation_cancelled:
//   //       _routeBuilt = false;
//   //       _isNavigating = false;
//   //       notifyListeners();
//   //       break;
//   //     default:
//   //       break;
//   //   }
//   //   notifyListeners();
//   // }

//   // // Platform messages are asynchronous, so we initialize in an async method.
//   // Future<void> initialize(BuildContext context) async {
//   //   // If the widget was removed from the tree while the asynchronous platform
//   //   // message was in flight, we want to discard the reply rather than calling
//   //   // setState to update our non-existent appearance.
//   //   if (!context.mounted) return;

//   //   _navigationOption = MapBoxNavigation.instance.getDefaultOptions();
//   //   _navigationOption.simulateRoute = true;
//   //   //_navigationOption.initialLatitude = 36.1175275;
//   //   //_navigationOption.initialLongitude = -115.1839524;
//   //   await MapBoxNavigation.instance
//   //       .registerRouteEventListener(_onEmbeddedRouteEvent);
//   //   MapBoxNavigation.instance.setDefaultOptions(_navigationOption);

//   //   String? platformVersion;
//   //   // Platform messages may fail, so we use a try/catch PlatformException.
//   //   try {
//   //     platformVersion = await MapBoxNavigation.instance.getPlatformVersion();
//   //   } on PlatformException {
//   //     platformVersion = 'Failed to get platform version.';
//   //   }
//   //   _platformVersion = platformVersion;
//   //   notifyListeners();
//   // }
// }
