// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i2;
import 'package:flutter/material.dart' as _i3;

import '../pages/pages.dart' as _i1;

class AppRouter extends _i2.RootStackRouter {
  AppRouter([_i3.GlobalKey<_i3.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i2.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    ProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ProfileRouteArgs>(
          orElse: () =>
              ProfileRouteArgs(userLogin: pathParams.getString('userLogin')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.ProfilePage(key: args.key, userLogin: args.userLogin));
    },
    ReposRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ReposRouteArgs>(
          orElse: () =>
              ReposRouteArgs(userLogin: pathParams.getString('userLogin')));
      return _i2.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i1.ReposPage(key: args.key, userLogin: args.userLogin));
    }
  };

  @override
  List<_i2.RouteConfig> get routes => [
        _i2.RouteConfig(HomeRoute.name, path: '/'),
        _i2.RouteConfig(ProfileRoute.name, path: '/profile/:userLogin'),
        _i2.RouteConfig(ReposRoute.name, path: '/repos/:userLogin')
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i2.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i1.ProfilePage]
class ProfileRoute extends _i2.PageRouteInfo<ProfileRouteArgs> {
  ProfileRoute({_i3.Key? key, required String userLogin})
      : super(ProfileRoute.name,
            path: '/profile/:userLogin',
            args: ProfileRouteArgs(key: key, userLogin: userLogin),
            rawPathParams: {'userLogin': userLogin});

  static const String name = 'ProfileRoute';
}

class ProfileRouteArgs {
  const ProfileRouteArgs({this.key, required this.userLogin});

  final _i3.Key? key;

  final String userLogin;

  @override
  String toString() {
    return 'ProfileRouteArgs{key: $key, userLogin: $userLogin}';
  }
}

/// generated route for
/// [_i1.ReposPage]
class ReposRoute extends _i2.PageRouteInfo<ReposRouteArgs> {
  ReposRoute({_i3.Key? key, required String userLogin})
      : super(ReposRoute.name,
            path: '/repos/:userLogin',
            args: ReposRouteArgs(key: key, userLogin: userLogin),
            rawPathParams: {'userLogin': userLogin});

  static const String name = 'ReposRoute';
}

class ReposRouteArgs {
  const ReposRouteArgs({this.key, required this.userLogin});

  final _i3.Key? key;

  final String userLogin;

  @override
  String toString() {
    return 'ReposRouteArgs{key: $key, userLogin: $userLogin}';
  }
}
