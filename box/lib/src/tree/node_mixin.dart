mixin NodeMixin<T> {
  NodeMixin<T> get parent;
  T get self;
  int get index;
  List<NodeMixin<T>> get children;

  NodeMixin<T> find(T value) {
    if (self == value) return this;
    for (final child in children) {
      final found = child.find(value);
      if (found != null) return found;
    }
    return null;
  }

  List<NodeMixin<T>> route(T value) {
    final route = _route(value);
    print(route);
    if (route is List || route == null)
      return route;
    else
      return [route];
  }

  void drop() {
    parent.children.remove(this);
  }

  void remove(T value) {
    final node = find(value);
    node.drop();
  }

  dynamic _route(T value) {
    if (self == value) {
      return this;
    } else {
      for (final child in children) {
        final route = child._route(value);
        if (route != null) {
          if (route is List)
            return <NodeMixin<T>>[child, ...route];
          else
            return <NodeMixin<T>>[route];
        }
      }
      return null;
    }
  }
}
