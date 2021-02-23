abstract class BaseSprinkle<T> with SprinkleListener {
  T _last;

  bool get isListening => _onListen != null;

  @override
  T get last => _last ?? super.last;

  void add(T data) {
    _last = data;
    if (_onListen != null) {
      onListen(data);
    } else {
      _remains.add(data);
    }
  }

  void notify() {
    if (_onListen != null) onListen(_last);
  }
}

class Sprinkle<T> extends BaseSprinkle<T> {
  Sprinkle();

  factory Sprinkle.combine(List<SprinkleListener> flows,
          {SprinkleCombiner<T> combiner, List initialValues}) =>
      CombinerSprinkle(flows, combiner: combiner, initialValues: initialValues);

  factory Sprinkle.withValues(List values) => Sprinkle().._remains = values;

  Sprinkle broadcast() {
    final sprinkle = Sprinkle();
    final onListen = _onListen;
    _onListen = null;
    this.listen((value) {
      onListen?.call(value);
      sprinkle.add(value);
    });
    if (last != null) sprinkle.add(last);
    return sprinkle;
  }
}

typedef SprinkleCombiner<T> = T Function(List);

class CombinerSprinkle<T> extends Sprinkle<T> {
  final List<SprinkleListener> flows;

  CombinerSprinkle(this.flows,
      {SprinkleCombiner<T> combiner, List initialValues}) {
    final converter = combiner ?? (values) => values as T;
    final length = flows.length;
    final list = initialValues ?? List(length);
    int index = 0;
    final onUpdate = (int index) => (value) => list[index] = value;
    int target = initialValues?.length ?? 0;
    flows.forEach((f) {
      final onUpdateForStream = onUpdate(index++);
      bool isFirstElement = initialValues == null;
      f.listen((value) {
        onUpdateForStream(value);
        if (isFirstElement) {
          target++;
          isFirstElement = false;
        }
        if (target == length) add(converter(List.unmodifiable(list)));
      });
    });
  }

  @override
  void cancel() {
    super.cancel();
    flows.forEach((element) {
      element.cancel();
    });
  }
}

class ListSprinkle extends Sprinkle<List> {
  final List<BaseSprinkle> sprinkles;

  @override
  List get _last => sprinkles
      .map((sprinkle) => sprinkle._last)
      .where((value) => value != null)
      .toList();

  ListSprinkle(this.sprinkles) : super();

  @override
  void listen(Function(List) onListen) {
    super.listen(onListen);
    if (sprinkles.isEmpty) onListen([]);
    sprinkles.forEach((sprinkle) {
      sprinkle.listen((value) {
        notify();
      });
    });
  }

  void append(SprinkleListener sprinkle) {
    sprinkles.add(sprinkle);
    notify();
    sprinkle.listen((value) {
      notify();
    });
  }

  void remove(SprinkleListener sprinkle) {
    sprinkles.remove(sprinkle);
    sprinkle.cancel();
  }
}

mixin SprinkleListener<T> {
  Function(T) _onListen;
  List _remains = [];
  T get last => _remains.isNotEmpty ? _remains.last : null;

  void onListen(data) {
    _onListen(data);
  }

  void listen(Function(T) onListen) {
    _onListen = onListen;
    while (_remains.isNotEmpty) {
      onListen(_remains.first);
      _remains.removeAt(0);
    }
  }

  void cancel() {
    _onListen = null;
  }
}
