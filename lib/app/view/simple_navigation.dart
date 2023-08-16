import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';

class SampleNavigationApp extends StatefulWidget {
  const SampleNavigationApp({super.key});

  @override
  State<SampleNavigationApp> createState() => _SampleNavigationAppState();
}

class _SampleNavigationAppState extends State<SampleNavigationApp> {
  String? _platformVersion;
  String? _instruction;
  final _origin = WayPoint(
    name: 'Way Point 1',
    latitude: 38.9111117447887,
    longitude: -77.04012393951416,
    isSilent: true,
  );
  final _stop1 = WayPoint(
    name: 'Way Point 2',
    latitude: 38.91113678979344,
    longitude: -77.03847169876099,
    isSilent: true,
  );
  final _stop2 = WayPoint(
    name: 'Way Point 3',
    latitude: 38.91040213277608,
    longitude: -77.03848242759705,
    isSilent: false,
  );
  final _stop3 = WayPoint(
    name: 'Way Point 4',
    latitude: 38.909650771013034,
    longitude: -77.03850388526917,
    isSilent: true,
  );
  final _destination = WayPoint(
    name: 'Way Point 5',
    latitude: 38.90894949285854,
    longitude: -77.03651905059814,
    isSilent: false,
  );

  final _work = WayPoint(
    name: 'Work',
    latitude: 4.8245953,
    longitude: 6.9849564,
    isSilent: false,
  );

  final _home = WayPoint(
    name: 'Home',
    latitude: 4.8237162, // 4.7988718,
    longitude: 6.991901, // 7.0349139,
    isSilent: false,
  );

  final bool _isMultipleStop = false;
  double? _distanceRemaining, _durationRemaining;
  MapBoxNavigationViewController? _controller;
  bool _routeBuilt = false;
  bool _isNavigating = false;
  final bool _inFreeDrive = false;
  late MapBoxOptions _navigationOption;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initialize() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    _navigationOption = MapBoxNavigation.instance.getDefaultOptions();
    _navigationOption.simulateRoute = true;
    await MapBoxNavigation.instance
        .registerRouteEventListener(_onEmbeddedRouteEvent);
    MapBoxNavigation.instance.setDefaultOptions(_navigationOption);

    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await MapBoxNavigation.instance.getPlatformVersion();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox.expand(
                child: MapBoxNavigationView(
                  options: _navigationOption,
                  onRouteEvent: _onEmbeddedRouteEvent,
                  onCreated: (MapBoxNavigationViewController controller) async {
                    _controller = controller;
                    await controller.initialize();
                  },
                ),
              ),
              Positioned(
                top: 140,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _isNavigating
                          ? null
                          : () {
                              if (_routeBuilt) {
                                _controller?.clearRoute();
                              } else {
                                final wayPoints = <WayPoint>[];
                                wayPoints
                                  ..add(_work)
                                  ..add(_home);

                                _controller?.buildRoute(
                                  wayPoints: wayPoints,
                                  options: _navigationOption,
                                );
                              }
                            },
                      child: Text(
                        _routeBuilt && !_isNavigating
                            ? 'Clear Route'
                            : 'Build Route',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: _routeBuilt && !_isNavigating
                          ? () {
                              _controller?.startNavigation();
                            }
                          : null,
                      child: const Text('Start Ride'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onEmbeddedRouteEvent(RouteEvent e) async {
    _distanceRemaining = await MapBoxNavigation.instance.getDistanceRemaining();
    _durationRemaining = await MapBoxNavigation.instance.getDurationRemaining();

    switch (e.eventType) {
      case MapBoxEvent.progress_change:
        final progressEvent = e.data as RouteProgressEvent;
        if (progressEvent.currentStepInstruction != null) {
          _instruction = progressEvent.currentStepInstruction;
        }
        break;
      case MapBoxEvent.route_building:
      case MapBoxEvent.route_built:
        setState(() {
          _routeBuilt = true;
        });
        break;
      case MapBoxEvent.route_build_failed:
        setState(() {
          _routeBuilt = false;
        });
        break;
      case MapBoxEvent.navigation_running:
        setState(() {
          _isNavigating = true;
        });
        break;
      case MapBoxEvent.on_arrival:
        if (!_isMultipleStop) {
          await Future.delayed(const Duration(seconds: 3));
          await _controller?.finishNavigation();
        } else {}
        break;
      case MapBoxEvent.navigation_finished:
      case MapBoxEvent.navigation_cancelled:
        setState(() {
          _routeBuilt = false;
          _isNavigating = false;
        });
        break;
      default:
        break;
    }
    setState(() {});
  }
}
