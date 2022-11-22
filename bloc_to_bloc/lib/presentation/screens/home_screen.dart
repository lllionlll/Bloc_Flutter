import 'package:bloc_to_bloc/constants/enums.dart';
import 'package:bloc_to_bloc/logic/cubit/internet_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
        body: Column(
          children: [
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
                  return Text('Wifi');
                } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
                  return Text('Mobile');
                } else if (state is InternetDisconnected) {
                  return Text('Disconnected');
                }
                return CircularProgressIndicator();
              },
            ),
            BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncremented == true) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Increment'),
                      duration: Duration(microseconds: 300),));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Decrement'),
                        duration: Duration(microseconds: 300)));
                  }
                },
                builder: (context, state) {
                  return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You have pushed the button this many times:'),
                          Text(state.counterValue.toString(), style: Theme
                              .of(context)
                              .textTheme
                              .headline4,),
                          SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FloatingActionButton(
                                onPressed: () {
                                  BlocProvider.of<CounterCubit>(context)
                                      .decrement();
                                },
                                tooltip: 'Decrement',
                                child: Icon(Icons.remove),
                                backgroundColor: widget.color
                              ),
                              FloatingActionButton(
                                onPressed: () {
                                  BlocProvider.of<CounterCubit>(context)
                                      .increment();
                                },
                                tooltip: 'Increment',
                                child: Icon(Icons.add),
                                backgroundColor: widget.color
                              )
                            ],
                          ),
                         Container(
                           margin: EdgeInsets.only(top: 40),
                           child: MaterialButton(
                             onPressed: () {
                               Navigator.of(context).pushNamed('/second');
                             },
                             color: widget.color,
                             child: Text('Next to second screen'),
                           ),
                         )
                        ],
                      )
                  );
                }
            ),
          ],
        )
    );
  }
}
