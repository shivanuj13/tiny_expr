import 'dart:math';
import 'package:tiny_expr/tiny_expr.dart';

void main() {
  // Test a TinyExpr evaluator with a given expression and expected result
  void testExpression(String expression, double expected,
      {bool approx = false, Map<String, double>? variables}) {
    try {
      final result = expression.evaluate(variables: variables);

      if (approx) {
        // For approximate comparisons (e.g., floating-point results)
        if ((result - expected).abs() < 1e-6) {
          print("✅ Passed: $expression = $result (expected: $expected)");
        } else {
          print("❌ Failed: $expression = $result (expected: $expected)");
        }
      } else {
        // For exact comparisons
        if (result == expected) {
          print("✅ Passed: $expression = $result");
        } else {
          print("❌ Failed: $expression = $result (expected: $expected)");
        }
      }
    } catch (e) {
      print("❌ Failed: $expression threw an error: $e");
    }
  }

  // Run all tests
  print("Starting tests...\n");

  // Basic Arithmetic
  testExpression("2 + 3", 5.0);
  testExpression("10 - 4", 6.0);
  testExpression("6 * 7", 42.0);
  testExpression("20 / 5", 4.0);
  testExpression("8 % 3", 2.0);

  // Exponentiation
  testExpression("2^3", 8.0);
  testExpression("5^0", 1.0);

  // Parentheses and Operator Precedence
  testExpression("(2 + 3) * 4", 20.0);
  testExpression("2 + 3 * 4", 14.0);
  testExpression("(2 + 3)^2", 25.0);

  // Unary Negation
  testExpression("-5", -5.0);
  testExpression("-(2 + 3)", -5.0);

  // Constants
  testExpression("pi", pi, approx: true);
  testExpression("e", e, approx: true);

  // Trigonometric Functions
  testExpression("sin(pi / 2)", 1.0, approx: true);
  testExpression("cos(pi)", -1.0, approx: true);
  testExpression("tan(pi / 4)", 1.0, approx: true);
  testExpression("atan2(1, 1)", pi / 4, approx: true);
  testExpression("cosec(pi / 2)", 1.0, approx: true);
  testExpression("sec(0)", 1.0, approx: true);
  testExpression("cot(pi / 4)", 1.0, approx: true);

  // Hyperbolic Functions
  testExpression("sinh(1)", sinh(1.0), approx: true);
  testExpression("cosh(1)", cosh(1.0), approx: true);
  testExpression("tanh(1)", tanh(1.0), approx: true);

  // Logarithmic Functions
  testExpression("log(100)", 2.0);
  testExpression("ln(e)", 1.0, approx: true);

  // Square Root and Absolute Value
  testExpression("sqrt(16)", 4.0);
  testExpression("abs(-5)", 5.0);

  // Exponential
  testExpression("exp(1)", e, approx: true);

  // Rounding Functions
  testExpression("ceil(2.1)", 3.0);
  testExpression("floor(2.9)", 2.0);

  // Factorial
  testExpression("fac(5)", 120.0);
  testExpression("fac(0)", 1.0);
  testExpression("fac(1)", 1.0);
  testExpression("5!", 120.0); // Added example for factorial operator
  testExpression("0!", 1.0); // Added example for factorial operator
  testExpression("1!", 1.0); // Added example for factorial operator

  // Combinations (nCr) and Permutations (nPr)
  testExpression("ncr(5, 3)", 10.0);
  testExpression("npr(5, 2)", 20.0);

  // Variables
  try {
    final expression = "x + y * z";
    final variables = {"x": 3.0, "y": 2.0, "z": 5.0};
    final result = expression.evaluate(variables: variables);
    if (result == 13.0) {
      print("✅ Passed: x + y * z with variables = $result");
    } else {
      print("❌ Failed: x + y * z with variables = $result (expected: 13.0)");
    }
  } catch (e) {
    print("❌ Failed: Variable tests threw an error: $e");
  }

  // Nested Expressions
  testExpression("fac(3) + ncr(5, 2) * sqrt(16)", 6 + 10 * 4);

  // Complex Expressions
  testExpression("2 + 3 * (4 - 1)^2 / 2", 15.5);
  testExpression("5! + 3^2 - sqrt(16) * log(100)", 120.0 + 9 - 4 * 2);
  testExpression("sin(pi / 2) + cos(0) * tan(pi / 4)", 1.0 + 1.0 * 1.0,
      approx: true);
  testExpression("exp(1) + ln(e) - fac(3)", e + 1.0 - 6.0, approx: true);
  testExpression("ceil(2.1) + floor(2.9) * abs(-5)", 3.0 + 2.0 * 5.0);

  // Errors
  try {
    "unknown".evaluate();
    print("❌ Failed: Unknown variable/function should throw error");
  } catch (e) {
    print("✅ Passed: Unknown variable/function error handled: $e");
  }

  try {
    "5 +".evaluate();
    print("❌ Failed: Incomplete expression should throw error");
  } catch (e) {
    print("✅ Passed: Incomplete expression error handled: $e");
  }

  try {
    "log(-1)".evaluate();
    print("❌ Failed: log(-1) should throw error or return NaN");
  } catch (e) {
    print("✅ Passed: log(-1) error handled: $e");
  }

  print("\nAll tests completed!");
}
