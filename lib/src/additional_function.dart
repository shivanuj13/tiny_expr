// Helper Functions
import 'dart:math';

/// Calculates the factorial of a number.
///
/// The formula used is:
/// n! = n * (n - 1) * (n - 2) * ... * 1
/// 0! = 1
///
/// Returns NaN if the input is negative.
///
/// - Parameters:
///  - x: The input value.
/// - Returns: The factorial of the input value.
double factorial(double x) {
  if (x < 0) return double.nan;
  if (x == 0 || x == 1) return 1.0;
  return List.generate(x.toInt(), (i) => i + 1).fold(1.0, (a, b) => a * b);
}

/// Calculates the number of combinations (n choose r).
///
/// The formula used is:
/// C(n, r) = n! / (r! * (n - r)!)
///
/// Returns NaN if n < r or if either n or r are negative.
///
/// - Parameters:
///   - n: The total number of items.
///   - r: The number of items to choose.
/// - Returns: The number of combinations.
double combinations(double n, double r) {
  if (n < r || n < 0 || r < 0) return double.nan;
  return factorial(n) / (factorial(r) * factorial(n - r));
}

/// Calculates the number of permutations.
///
/// The formula used is:
/// P(n, r) = n! / (n - r)!
///
/// Returns NaN if n < r or if either n or r are negative.
///
/// - Parameters:
///   - n: The total number of items.
///   - r: The number of items to arrange.
/// - Returns: The number of permutations.
double permutations(double n, double r) {
  if (n < r || n < 0 || r < 0) return double.nan;
  return factorial(n) / factorial(n - r);
}

/// Calculates the hyperbolic sine of a number.
///
/// The formula used is:
/// sinh(x) = (e^x - e^(-x)) / 2
///
/// - Parameters:
///   - x: The input value.
/// - Returns: The hyperbolic sine of the input value.
double sinh(double x) => (exp(x) - exp(-x)) / 2;

/// Calculates the hyperbolic cosine of a number.
///
/// The formula used is:
/// cosh(x) = (e^x + e^(-x)) / 2
///
/// - Parameters:
///   - x: The input value.
/// - Returns: The hyperbolic cosine of the input value.
double cosh(double x) => (exp(x) + exp(-x)) / 2;

/// Calculates the hyperbolic tangent of a number.
///
/// The formula used is:
/// tanh(x) = sinh(x) / cosh(x)
///
/// - Parameters:
///   - x: The input value.
/// - Returns: The hyperbolic tangent of the input value.
double tanh(double x) => sinh(x) / cosh(x);
