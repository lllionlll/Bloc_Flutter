import 'package:counter_bloc/logic/cubit/counter_cubit.dart';
import 'package:counter_bloc/presentation/screens/home_screen.dart';
import 'package:counter_bloc/presentation/screens/second_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class AppRouter {
  final CounterCubit _counterCubit = CounterCubit();

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