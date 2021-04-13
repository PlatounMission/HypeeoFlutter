import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hypeeo_app/screens/AdminPage.dart';
import 'package:hypeeo_app/screens/LoginPage.dart';
import 'package:hypeeo_app/screens/RetryWidgetPage.dart';
import 'package:hypeeo_app/screens/StreamerDetailsPage.dart';
import 'package:hypeeo_app/screens/StreamerDonatePage.dart';
import 'package:hypeeo_app/screens/StreamerInfoEditPage.dart';
import 'package:hypeeo_app/screens/StreamerInfoValidationPage.dart';
import 'package:hypeeo_app/screens/StreamerListPage.dart';
import 'package:hypeeo_app/screens/UserSummaryPage.dart';
import 'package:hypeeo_app/screens/forget_password_page.dart';
import 'package:hypeeo_app/screens/home_page.dart';
import 'package:hypeeo_app/screens/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    CustomRoute(
      path: '/',
      page: HomePage,
      transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    AutoRoute(page: SplashScreenPage, initial: true),
    CustomRoute(
      page: LoginPage,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: ForgetPasswordPage,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    AutoRoute(page: StreamerDetailsPage),
    AutoRoute(page: StreamerDonatePage),
    AutoRoute(page: StreamerInfoEditPage),
    AutoRoute(page: StreamerInfoValidationPage),
    AutoRoute(page: StreamerListPage),
    AutoRoute(page: UserSummaryPage),
    AutoRoute(page: AdminPage),
    AutoRoute(page: RetryWidgetPage),

    RedirectRoute(path: '*', redirectTo: '/'),
  ],
)

class $AppRouter {

}