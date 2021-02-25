import 'package:auto_route/auto_route_annotations.dart';
import 'package:health_app/presentation/home/home.dart';
import 'package:health_app/presentation/sign_in/sign_in_page.dart';
import 'package:health_app/presentation/splash/splash_page.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: HomePage),
    MaterialRoute(page: SignInPage),
    MaterialRoute(page: SplashPage, initial: true)
  ],
  generateNavigationHelperExtension: true,
)
class $MyRouter {}
