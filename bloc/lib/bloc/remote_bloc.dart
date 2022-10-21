import 'dart:async';

import 'state/remote_state.dart';
import 'event/remote_event.dart';

class RemoteBloc {
  var state = RemoteState(70);

  final eventController = StreamController<RemoteEven>();

  final stateController = StreamController<RemoteState>();

  RemoteBloc() {
    eventController.stream.listen((RemoteEven event) {
      if (event is TangAmLuong) {
        if (state.amluong < 100) state = RemoteState(state.amluong + event.amluong);
      } else if (event is GiamAmLuong) {
        if (state.amluong > 0) state = RemoteState(state.amluong - event.amluong);
      } else {
        state = RemoteState(0);
      }
      stateController.sink.add(state);
    });
  }
  void dispose() {
    stateController.close();
    eventController.close();
  }
}
