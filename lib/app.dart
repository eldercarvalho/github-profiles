import 'package:flutter/material.dart';
import 'package:github_profiles/pages/home/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Profiles',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
