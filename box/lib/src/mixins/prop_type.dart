import 'package:lambda/lambda.dart';

/// [PropType] determines how the box exposes the value
/// null value exposes defaultValue
abstract class PropType {
  const PropType();

  /// Exposes normal value
  static const value = ValuePropType._();

  /// Exposes scopedVariable which defined above in the tree
  static ScopedPropType scoped(String variableName) =>
      ScopedPropType._(variableName);

  /// Exposes a lambda value
  static LambdaPropType lambda(Lambda lambda) => LambdaPropType._(lambda);

  /// Get [PropType] from data
  factory PropType.fromData(dynamic data) {
    if (data == null) return null;
    if (data is Map) {
      if (data['_type'] == 'Scoped')
        return scoped(data['value']);
      else if (data['_type'] == 'Lambda') return lambda(data['value']);
      return value;
    } else
      return value;
  }
}

class ValuePropType extends PropType {
  const ValuePropType._();
}

class ScopedPropType extends PropType {
  final String variableName;
  const ScopedPropType._(this.variableName);
}

class LambdaPropType extends PropType {
  final Lambda lambda;
  const LambdaPropType._(this.lambda);
}
