import 'dart:async';
import 'package:flutter/widgets.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  // FlutterError.onError = (details) {
  //   log(details.exceptionAsString(), stackTrace: details.stack);
  // };
  // await dotenv.load(fileName: 'assets/config/.env');

  // await runZonedGuarded(
  //   () async => runApp(await builder()),
  //   (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  // );
  runApp(await builder());
}
