import 'package:auto_route/annotations.dart';
import 'package:github_profiles/pages/home/home_page.dart';

@MaterialAutoRouter(replaceInRouteName: 'Page,Route', routes: [
  AutoRoute(page: HomePage, initial: true),
])
class $AppRouter {}
