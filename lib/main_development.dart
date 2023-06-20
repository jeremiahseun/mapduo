import 'package:flutter/material.dart';
import 'package:mapduo/app/app.dart';
import 'package:mapduo/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
