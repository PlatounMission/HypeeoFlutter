// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;

import '../screens/AdminPage.dart' as _i11;
import '../screens/home_page.dart' as _i2;
import '../screens/LoginPage.dart' as _i4;
import '../screens/RetryWidgetPage.dart' as _i12;
import '../screens/splash_screen.dart' as _i3;
import '../screens/StreamerDetailsPage.dart' as _i5;
import '../screens/StreamerDonatePage.dart' as _i6;
import '../screens/StreamerInfoEditPage.dart' as _i7;
import '../screens/StreamerInfoValidationPage.dart' as _i8;
import '../screens/StreamerListPage.dart' as _i9;
import '../screens/UserSummaryPage.dart' as _i10;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i2.HomePage(),
          transitionsBuilder: _i1.TransitionsBuilders.slideLeft,
          opaque: true,
          barrierDismissible: false);
    },
    SplashScreenRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i3.SplashScreenPage());
    },
    LoginRoute.name: (entry) {
      return _i1.CustomPage(
          entry: entry,
          child: _i4.LoginPage(),
          transitionsBuilder: _i1.TransitionsBuilders.slideBottom,
          opaque: true,
          barrierDismissible: false);
    },
    StreamerDetailsRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i5.StreamerDetailsPage());
    },
    StreamerDonateRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i6.StreamerDonatePage());
    },
    StreamerInfoEditRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i7.StreamerInfoEditPage());
    },
    StreamerInfoValidationRoute.name: (entry) {
      return _i1.MaterialPageX(
          entry: entry, child: _i8.StreamerInfoValidationPage());
    },
    StreamerListRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i9.StreamerListPage());
    },
    UserSummaryRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i10.UserSummaryPage());
    },
    AdminRoute.name: (entry) {
      return _i1.MaterialPageX(entry: entry, child: _i11.AdminPage());
    },
    RetryWidgetRoute.name: (entry) {
      var args = entry.routeData.argsAs<RetryWidgetRouteArgs>();
      return _i1.MaterialPageX(
          entry: entry, child: _i12.RetryWidgetPage(args.onRetry, args.mesage));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(SplashScreenRoute.name, path: '/'),
        _i1.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i1.RouteConfig(StreamerDetailsRoute.name, path: '/'),
        _i1.RouteConfig(StreamerDonateRoute.name, path: '/'),
        _i1.RouteConfig(StreamerInfoEditRoute.name, path: '/'),
        _i1.RouteConfig(StreamerInfoValidationRoute.name, path: '/'),
        _i1.RouteConfig(StreamerListRoute.name, path: '/'),
        _i1.RouteConfig(UserSummaryRoute.name, path: '/'),
        _i1.RouteConfig(AdminRoute.name, path: '/'),
        _i1.RouteConfig(RetryWidgetRoute.name, path: '/'),
        _i1.RouteConfig('*#redirect',
            path: '*', redirectTo: '/', fullMatch: true)
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class SplashScreenRoute extends _i1.PageRouteInfo {
  const SplashScreenRoute() : super(name, path: '/');

  static const String name = 'SplashScreenRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login-page');

  static const String name = 'LoginRoute';
}

class StreamerDetailsRoute extends _i1.PageRouteInfo {
  const StreamerDetailsRoute() : super(name, path: '/');

  static const String name = 'StreamerDetailsRoute';
}

class StreamerDonateRoute extends _i1.PageRouteInfo {
  const StreamerDonateRoute() : super(name, path: '/');

  static const String name = 'StreamerDonateRoute';
}

class StreamerInfoEditRoute extends _i1.PageRouteInfo {
  const StreamerInfoEditRoute() : super(name, path: '/');

  static const String name = 'StreamerInfoEditRoute';
}

class StreamerInfoValidationRoute extends _i1.PageRouteInfo {
  const StreamerInfoValidationRoute() : super(name, path: '/');

  static const String name = 'StreamerInfoValidationRoute';
}

class StreamerListRoute extends _i1.PageRouteInfo {
  const StreamerListRoute() : super(name, path: '/');

  static const String name = 'StreamerListRoute';
}

class UserSummaryRoute extends _i1.PageRouteInfo {
  const UserSummaryRoute() : super(name, path: '/');

  static const String name = 'UserSummaryRoute';
}

class AdminRoute extends _i1.PageRouteInfo {
  const AdminRoute() : super(name, path: '/');

  static const String name = 'AdminRoute';
}

class RetryWidgetRoute extends _i1.PageRouteInfo<RetryWidgetRouteArgs> {
  RetryWidgetRoute({required Function? onRetry, required String mesage})
      : super(name,
            path: '/',
            args: RetryWidgetRouteArgs(onRetry: onRetry, mesage: mesage));

  static const String name = 'RetryWidgetRoute';
}

class RetryWidgetRouteArgs {
  const RetryWidgetRouteArgs({required this.onRetry, required this.mesage});

  final Function? onRetry;

  final String mesage;
}
