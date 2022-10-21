import 'package:bloc/bloc/event/remote_event.dart';
import 'package:bloc/bloc/remote_bloc.dart';
import 'package:bloc/bloc/state/remote_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = RemoteBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<RemoteState>(
          stream: bloc.stateController.stream,
          initialData: bloc.state,
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            return Text('Âm lượng hiện tại: ${snapshot.data!.amluong}');
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              bloc.eventController.sink.add(TangAmLuong(5));
            }, // add event <=== new
            child: Icon(Icons.volume_up),
          ),
          FloatingActionButton(
            onPressed: () {
              bloc.eventController.sink.add(GiamAmLuong(5));
            }, // add event <=== new
            child: Icon(Icons.volume_down),
          ),
          FloatingActionButton(
            onPressed: () {
              bloc.eventController.sink.add(Mute());
            }, // add event <=== new
            child: Icon(Icons.volume_mute),
          ),
        ],
      ),
    );
  }
}
