// // ignore_for_file: lines_longer_than_80_chars

// import 'package:flutter/material.dart';
// import 'package:mapbox_gl/mapbox_gl.dart';
// import 'package:mapduo/app/view/home/home_viewmodel.dart';
// import 'package:mapduo/app/view/search/search_view.dart';
// import 'package:mapduo/utils/constants.dart';
// import 'package:provider/provider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<HomeViewModel>(context, listen: false).askPermission();
//       Provider.of<HomeViewModel>(context, listen: false).animateToLocation();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Consumer<HomeViewModel>(
//         builder: (context, home, _) {
//           return FloatingActionButton(
//             onPressed: () => home.animateToLocation(),
//           );
//         },
//       ),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Consumer<HomeViewModel>(
//               builder: (context, home, _) {
//                 return MapboxMap(
//                   myLocationTrackingMode:
//                       MyLocationTrackingMode.TrackingCompass,
//                   myLocationEnabled: true,
//                   onStyleLoadedCallback: () {},
//                   onMapCreated: (controller) {
//                     home.mapController = controller;
//                   },
//                   accessToken: mapApi,
//                   initialCameraPosition: CameraPosition(
//                     target: LatLng(
//                       home.userLocation.latitude ?? 4.824332,
//                       home.userLocation.longitude ?? 6.9635055,
//                     ),
//                     zoom: 10,
//                   ),
//                 );
//               },
//             ),
//             Positioned(
//               top: 30,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: InkWell(
//                   onTap: () => Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => const SearchView(),
//                     ),
//                   ),
//                   child: Material(
//                     elevation: 5,
//                     child: Container(
//                       height: 50,
//                       width: MediaQuery.of(context).size.width * .8,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         border: const Border(),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       alignment: Alignment.center,
//                       child: const Text('Search Location'),
//                     ),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
