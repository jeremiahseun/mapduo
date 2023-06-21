import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:mapduo/app/view/home/home_viewmodel.dart';
import 'package:mapduo/app/view/search/search_viewmodel.dart';
import 'package:provider/provider.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  runApp(
    MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => SearchViewModel())
      ],
      child: await builder(),
    ),
  );
}
