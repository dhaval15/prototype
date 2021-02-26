mixin NodeMixin<T, N extends NodeMixin<T, N>> {
  N parent;
  T self;
  int index;
  List<N> get children;

  N find(T value) {
    if (self == value) return this;
    for (final child in children) {
      final found = child.find(value);
      if (found != null) return found;
    }
    return null;
  }

  List<N> route(T value) {
    final route = _route(value);
    print(route);
    if (route is List || route == null)
      return route;
    else
      return [route];
  }

  bool drop([void Function(N parent, T value, N child) onDrop]) {
    if (parent != null && children.length == 1) {
      final child = children.first;
      child.index = index;
      child.parent = parent;
      children.clear();
      remove();
      parent.children.insert(index, child);
      onDrop?.call(parent, self, child);
      return true;
    }
    return false;
  }

  void remove() {
    parent.children.remove(this);
  }

  dynamic _route(T value) {
    if (self == value) {
      return this;
    } else {
      for (final child in children) {
        final route = child._route(value);
        if (route != null) {
          if (route is List)
            return <N>[child, ...route];
          else
            return <N>[route];
        }
      }
      return null;
    }
  }
}
