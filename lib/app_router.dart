import 'package:flutter/material.dart';
import 'package:flutter_flavors/screens/dashboard_screen.dart';
import 'package:flutter_flavors/screens/sign_in_screen.dart';
import 'package:flutter_flavors/screens/sign_up_screen.dart';
import 'package:flutter_flavors/utils/route_util.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(routes: <RouteBase>[
    GoRoute(
      name: RouteNames.signInRoute,
      path: RoutePaths.signInPath,
      builder: (context, _) => const SignInScreen(),
      routes: <RouteBase>[
        GoRoute(
          name: RouteNames.signUpRoute,
          path: RoutePaths.signUpPath,
          pageBuilder: (context, _) => pageBuilderAnimate(
            context,
            child: const SignUpScreen(),
          ),
        ),
        GoRoute(
          name: RouteNames.dashboardRoute,
          path: RoutePaths.dashboardPath,
          pageBuilder: (context, _) => pageBuilderAnimate(
            context,
            child: const DashboardScreen(),
          ),
        ),
      ],
    ),
  ]);

  static CustomTransitionPage pageBuilderAnimate(
    BuildContext context, {
    required Widget child,
  }) =>
      CustomTransitionPage(
          child: child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          });
}
