import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/routing/routes.dart';

class RoleNavigation {
  RoleNavigation._(); // prevent instance

  static void goByRole(BuildContext context, int roleId) {
    final route = _getRoute(roleId);
    GoRouter.of(context).go(route);
  }

  static String _getRoute(int roleId) {
    switch (roleId) {
      case 1:
        return Routes.login;
      case 2:
        return Routes.navbarFounder;
      case 3:
        return Routes.navbarInvestor;
      default:
        return Routes.login;
    }
  }
}
