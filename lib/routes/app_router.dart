import 'package:auto_route/annotations.dart';
import 'package:github_profiles/pages/pages.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    AutoRoute(
      page: HomePage,
      initial: true,
    ),
    AutoRoute(
      path: '/profile/:userLogin',
      page: ProfilePage,
    ),
  ],
)
class $AppRouter {}
