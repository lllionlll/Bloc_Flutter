import 'package:counter_bloc/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<CounterCubit, CounterState>(
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
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              BlocProvider.of<CounterCubit>(context)
                                  .increment();
                            },
                            tooltip: 'Increment',
                            child: Icon(Icons.add),
                          )
                        ],
                      )
                    ],
                  )
              );
            }
        )
    );
  }
}
