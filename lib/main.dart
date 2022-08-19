import 'package:flutter/material.dart';
import 'package:github_profiles/core/injections.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(App());
}
