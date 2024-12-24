import 'package:tiny_expr/tiny_expr.dart';

/// A set of extensions on [String] to evaluate mathematical expressions.
///
/// makes it easier to evaluate mathematical expressions using TinyExpr.

extension TinyExprStringExtension on String {
  /// This extension adds a `evaluate` method to [String] that allows you to
  /// evaluate the string as a mathematical expression using TinyExpr.
  ///
  /// You can also add variables to the expression using the `variables` parameter.
  ///
  /// For example:
  /// ```dart
  /// final expression = "x + y";
  /// final variables = {"x": 2, "y": 3};
  /// final result = expression.evaluate(variables: variables);
  /// print(result); // 5.0
  /// ```
  double evaluate({
    Map<String, double>? variables,
  }) {
    try {
      final te = TinyExpr(this);
      if (variables != null) {
        te.addVariables(variables);
      }
      return te.evaluate();
    } on Exception {
      rethrow;
    }
  }
}
