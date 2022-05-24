import 'package:flutter/cupertino.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigatorkey =
      new GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    return navigatorkey.currentState!.pushNamed(routeName);
  }
   static replaceTo(String routeName) {
    return navigatorkey.currentState!.pushReplacementNamed(routeName);
  }
}
