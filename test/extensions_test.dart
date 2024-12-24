import 'dart:math';

import 'package:test/test.dart';
import 'package:tiny_expr/tiny_expr.dart';

void main() {
  // A helper function to run a test case with optional approximate checks
  void testExpression(String description, String expression, double expected,
      {bool approx = false, Map<String, double>? variables}) {
    test(description, () {
      final result = expression.evaluate(variables: variables);

      if (approx) {
        // Assert approximate equality for floating-point comparisons
        expect((result - expected).abs(), lessThan(1e-6),
            reason: "Expected $expected, got $result");
      } else {
        // Assert exact equality for integers and simple floating-point values
        expect(result, equals(expected),
            reason: "Expected $expected, got $result");
      }

      // Print success message
      print("✅ Success: $description ($expression = $result)");
    });
  }

  group('TinyExprStringExtension Basic Arithmetic', () {
    testExpression('Addition', "2 + 3", 5.0);
    testExpression('Subtraction', "10 - 4", 6.0);
    testExpression('Multiplication', "6 * 7", 42.0);
    testExpression('Division', "20 / 5", 4.0);
    testExpression('Modulo', "8 % 3", 2.0);
  });

  group('TinyExprStringExtension Exponentiation', () {
    testExpression('Power', "2^3", 8.0);
    testExpression('Zero Power', "5^0", 1.0);
  });

  group('TinyExprStringExtension Parentheses and Precedence', () {
    testExpression('Parentheses', "(2 + 3) * 4", 20.0);
    testExpression('Operator Precedence', "2 + 3 * 4", 14.0);
    testExpression('Nested Parentheses', "(2 + 3)^2", 25.0);
  });

  group('TinyExprStringExtension Unary Negation', () {
    testExpression('Negative Number', "-5", -5.0);
    testExpression('Negative Expression', "-(2 + 3)", -5.0);
  });

  group('TinyExprStringExtension Constants', () {
    testExpression('Pi', "pi", pi, approx: true);
    testExpression('Euler\'s Number', "e", e, approx: true);
  });

  group('TinyExprStringExtension Trigonometric Functions', () {
    testExpression('Sine', "sin(pi / 2)", 1.0, approx: true);
    testExpression('Cosine', "cos(pi)", -1.0, approx: true);
    testExpression('Tangent', "tan(pi / 4)", 1.0, approx: true);
    testExpression('Atan2', "atan2(1, 1)", pi / 4, approx: true);
    testExpression('Cosecant', "cosec(pi / 2)", 1.0, approx: true);
    testExpression('Secant', "sec(0)", 1.0, approx: true);
    testExpression('Cotangent', "cot(pi / 4)", 1.0, approx: true);
  });

  group('TinyExprStringExtension Hyperbolic Functions', () {
    testExpression('Sinh', "sinh(1)", sinh(1.0), approx: true);
    testExpression('Cosh', "cosh(1)", cosh(1.0), approx: true);
    testExpression('Tanh', "tanh(1)", tanh(1.0), approx: true);
  });

  group('TinyExprStringExtension Logarithmic Functions', () {
    testExpression('Logarithm Base-10', "log(100)", 2.0);
    testExpression('Natural Logarithm', "ln(e)", 1.0, approx: true);
  });

  group('TinyExprStringExtension Square Root and Absolute Value', () {
    testExpression('Square Root', "sqrt(16)", 4.0);
    testExpression('Absolute Value', "abs(-5)", 5.0);
  });

  group('TinyExprStringExtension Exponential Function', () {
    testExpression('Exponential', "exp(1)", e, approx: true);
  });

  group('TinyExprStringExtension Rounding Functions', () {
    testExpression('Ceiling', "ceil(2.1)", 3.0);
    testExpression('Floor', "floor(2.9)", 2.0);
  });

  group('TinyExprStringExtension Factorial', () {
    testExpression('Factorial of 5', "fac(5)", 120.0);
    testExpression('Factorial of 0', "fac(0)", 1.0);
    testExpression('Factorial of 1', "fac(1)", 1.0);
    testExpression(
        'Factorial Operator', "5!", 120.0); // Added test for factorial operator
    testExpression(
        'Factorial Operator', "0!", 1.0); // Added test for factorial operator
    testExpression(
        'Factorial Operator', "1!", 1.0); // Added test for factorial operator
  });

  group('TinyExprStringExtension Combinations and Permutations', () {
    testExpression('Combinations nCr', "ncr(5, 3)", 10.0);
    testExpression('Permutations nPr', "npr(5, 2)", 20.0);
  });

  group('TinyExprStringExtension Variables', () {
    testExpression('Variable Expression 1', "x + y * z", 13.0,
        variables: {"x": 3.0, "y": 2.0, "z": 5.0});
    testExpression('Variable Expression 2', "a - b / c", 8.0,
        variables: {"a": 10.0, "b": 4.0, "c": 2.0});
  });

  group('TinyExprStringExtension Nested Expressions', () {
    testExpression(
        'Nested Combination', "fac(3) + ncr(5, 2) * sqrt(16)", 6 + 10 * 4);
  });

  group('TinyExprStringExtension Complex Expressions', () {
    testExpression('Complex Expression 1', "2 + 3 * (4 - 1)^2 / 2", 15.5);
    testExpression('Complex Expression 2', "5! + 3^2 - sqrt(16) * log(100)",
        120.0 + 9 - 4 * 2);
    testExpression('Complex Expression 3', "sin(pi / 2) + cos(0) * tan(pi / 4)",
        1.0 + 1.0 * 1.0,
        approx: true);
    testExpression(
        'Complex Expression 4', "exp(1) + ln(e) - fac(3)", e + 1.0 - 6.0,
        approx: true);
    testExpression('Complex Expression 5', "ceil(2.1) + floor(2.9) * abs(-5)",
        3.0 + 2.0 * 5.0);
  });

  group('TinyExprStringExtension Error Handling', () {
    test('Unknown Variable or Function', () {
      expect(() => "unknown".evaluate(), throwsA(isA<FormatException>()));
      print("✅ Success: Handled Unknown Variable or Function Error");
    });

    test('Incomplete Expression', () {
      expect(() => "5 +".evaluate(), throwsA(isA<FormatException>()));
      print("✅ Success: Handled Incomplete Expression Error");
    });

    test('Domain Error for Logarithm', () {
      expect(() => "log(-1)".evaluate(), throwsA(isA<FormatException>()));
      print("✅ Success: Handled Domain Error for Logarithm");
    });
  });
}
