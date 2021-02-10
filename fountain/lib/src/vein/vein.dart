import 'dart:async';
import 'dart:isolate';
import 'package:fountain/fountain.dart';

part 'sub_vein.dart';

class Vein {
  static Vein instance;
  final Isolate _isolate;
  final SendPort _sendPort;
  final ReceivePort _receivePort;
  final List<SubVein> _veins = [];

  Vein(this._isolate, this._sendPort, this._receivePort);

  Future<SubVein> createSubVein() async {
    ReceivePort receivePort = ReceivePort();
    _sendPort.send(receivePort.sendPort);
    Completer<SendPort> completer = Completer();
    SubVein subVein = SubVein(receivePort);
    receivePort.listen((result) {
      if (result is SendPort)
        completer.complete(result);
      else
        subVein._onResult(result);
    });
    subVein._sendPort = await completer.future;
    _veins.add(subVein);
    return subVein;
  }

  void remove(SubVein vein) {
    _veins.remove(vein);
  }

  static Future init() async {
    ReceivePort receivePort = ReceivePort();
    Isolate isolate = await Isolate.spawn(_compute, receivePort.sendPort);
    Completer<SendPort> _completer = Completer();
    receivePort.listen((message) {
      if (message is SendPort) _completer.complete(message);
    });
    instance = Vein(isolate, await _completer.future, receivePort);
  }

  static void _compute(SendPort sendPort) {
    ReceivePort receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    receivePort.listen(_computeListen);
  }

  static void _computeListen(message) {
    if (message is SendPort) {
      _Wrapper wrapper = _Wrapper();
      ReceivePort receivePort = ReceivePort();
      message.send(receivePort.sendPort);
      receivePort.listen((action) {
        SubVein._onAction(wrapper, message, receivePort, action);
      });
    }
  }

  void kill() {
    _isolate.kill(priority: Isolate.immediate);
    _receivePort.close();
    _veins.forEach((vein) {
      vein.kill();
    });
  }
}
