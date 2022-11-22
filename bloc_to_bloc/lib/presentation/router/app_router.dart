import 'package:flutter/material.dart';

import '../../logic/cubit/counter_cubit.dart';
import '../screens/home_screen.dart';
import '../screens/second_screen.dart';


class AppRouter {

  MaterialPageRoute? onGenerateRouter(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/' :
        return MaterialPageRoute(
            builder: (_) =>
                HomeScreen(
                  title: 'Home Screen',
                  color: Colors.green,
                )
        );
      case '/second' :
        return MaterialPageRoute(
            builder: (_) =>
                SecondScreen(
                  title: 'Second Screen',
                  color: Colors.redAccent,
                )
        );
      default :
        return null;
    }
  }

}