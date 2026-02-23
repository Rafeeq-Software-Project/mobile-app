import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rafeeq_app/core/routing/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoleNavigation {
  RoleNavigation._();

  static Future<void> goByRole(BuildContext context, int roleId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', true);
    await prefs.setInt('roleId', roleId);
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

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('loggedIn') ?? false;
  }

  static Future<int> getRoleId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('roleId') ?? 1;
  }
}
