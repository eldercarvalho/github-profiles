import 'package:flutter/material.dart';
import 'package:github_profiles/core/core.dart';
import 'package:github_profiles/core/theme/app_theme.dart';
import 'package:github_profiles/routes/app_router.gr.dart';

class App extends StatelessWidget {
  final appRouter = AppRouter();

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'GitHub Profiles',
      theme: appTheme,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
