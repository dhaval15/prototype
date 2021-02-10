part of 'vein.dart';

class _Wrapper {
  Timer _timer;
  int i = 0;
}

class SubVein extends Sprinkle {
  SendPort _sendPort;
  ReceivePort _receivePort;
  String status;

  SubVein(this._receivePort);

  static void _onAction(
    _Wrapper wrapper,
    SendPort sendPort,
    ReceivePort receivePort,
    _Action action,
  ) async {
    if (action is _KillAction) {
      wrapper._timer?.cancel();
      receivePort.close();
    } else if (action is _RunAction) {
      wrapper._timer?.cancel();
      if (action.handler.repeatingDuration != null) {
        wrapper.i++;
        wrapper._timer =
            Timer.periodic(action.handler.repeatingDuration, (t) async {
          sendPort.send(await action.handler.compute());
        });
      } else {
        sendPort.send(await action.handler.compute());
      }
    } else if (action is _ResetAction) {
      wrapper._timer?.cancel();
    }
  }

  void kill() {
    status = 'killed';
    _receivePort.close();
    _sendPort.send(_KillAction());
  }

  void run(Handler handler) async {
    if (handler is ConstHandler) {
      reset();
      _onResult(await handler.compute());
    } else
      _sendPort.send(_RunAction(handler));
  }

  void reset() {
    status = 'reset';
    _sendPort.send(_ResetAction());
  }

  void _onResult(result) {
    add(result);
  }
}

mixin _Action {}

class _KillAction with _Action {}

class _RunAction with _Action {
  final Handler handler;

  _RunAction(this.handler);
}

class _ResetAction with _Action {}
