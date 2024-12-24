TinyExpr is a lightweight expression evaluator for Dart, designed to evaluate mathematical expressions from strings. This makes it an ideal choice for applications requiring dynamic calculations.

> This project draws inspiration from the TinyExpr library written in C. The original library can be found [here](https://github.com/codeplea/tinyexpr). We extend our gratitude to the original author for their outstanding work.

## Features

- Evaluate mathematical expressions from strings.
- Support for basic arithmetic operations: addition, subtraction, multiplication, and division.
- Support for parentheses to define operation precedence.
- Support for exponentiation.
- Support for unary negation.
- Support for constants (e.g., `pi`, `e`).
- Support for trigonometric functions (e.g., `sin`, `cos`, `tan`, `cosec`, `sec`, `cot`).
- Support for hyperbolic functions (e.g., `sinh`, `cosh`, `tanh`).
- Support for logarithmic functions (e.g., `log`, `ln`).
- Support for square root and absolute value.
- Support for exponential function.
- Support for rounding functions (e.g., `ceil`, `floor`).
- Support for factorial, combinations (nCr), and permutations (nPr).
- Lightweight and easy to integrate.
- Support for extension method on `String` to directly use `.evaluate()` method.

## Getting started

To start using TinyExpr, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  tiny_expr: ^0.3.0
```

Then, run `flutter pub get` to install the package.

## Usage

### Simple Implementation

Here is a simple example of how to use TinyExpr to evaluate an expression:

```dart
import 'package:tiny_expr/tiny_expr.dart';

void main() {
  final expression = '3 + 5 * (2 - 4)';
  final result = TinyExpr(expression).evaluate();
  print('Result: $result'); // Output: Result: -7
}
```

### Using Variables

Here is an example of how to use TinyExpr with variables:

```dart
import 'package:tiny_expr/tiny_expr.dart';

void main() {
  final expression = 'x + y * z';
  final te = TinyExpr(expression);
  te.addVariables({'x': 3.0, 'y': 2.0, 'z': 5.0});
  final result = te.evaluate();
  print('Result: $result'); // Output: Result: 13.0

  // Update variable values
  te.updateVariables({'x': 10.0});
  final updatedResult = te.evaluate();
  print('Updated Result: $updatedResult'); // Output: Updated Result: 20.0
}
```

### Using Extension Method

TinyExpr now supports an extension method on `String` to directly evaluate expressions:

```dart
import 'package:tiny_expr/tiny_expr.dart';

void main() {
  final expression = '3 + 5 * (2 - 4)';
  final result = expression.evaluate();
  final expressionWithVariables = 'x + y';
  final resultWithVariables =
      expressionWithVariables.evaluate(variables: {'x': 2, 'y': 15});
  print('Result: $result'); // Output: Result: -7
  print('Result: $resultWithVariables'); // Output: Result: 17
}
```

For more examples, check the `/example` folder.

## Available Operations

| Operation Type          | Operators/Functions                                 | Usage Example                                                                                    |
| ----------------------- | --------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| Basic Arithmetic        | `+`, `-`, `*`, `/`, `%`                             | `2 + 3`, `10 - 4`, `6 * 7`, `20 / 5`, `8 % 3`                                                    |
| Exponentiation          | `^`                                                 | `2^3`                                                                                            |
| Parentheses             | `()`                                                | `(2 + 3) * 4`                                                                                    |
| Unary Negation          | `-`                                                 | `-5`, `-(2 + 3)`                                                                                 |
| Constants               | `pi`, `e`                                           | `pi`, `e`                                                                                        |
| Trigonometric Functions | `sin`, `cos`, `tan`, `cosec`, `sec`, `cot`, `atan2` | `sin(pi / 2)`, `cos(pi)`, `tan(pi / 4)`, `cosec(pi / 2)`, `sec(0)`, `cot(pi / 4)`, `atan2(1, 1)` |
| Hyperbolic Functions    | `sinh`, `cosh`, `tanh`                              | `sinh(1)`, `cosh(1)`, `tanh(1)`                                                                  |
| Logarithmic Functions   | `log`, `ln`                                         | `log(100)`, `ln(e)`                                                                              |
| Square Root             | `sqrt`                                              | `sqrt(16)`                                                                                       |
| Absolute Value          | `abs`                                               | `abs(-5)`                                                                                        |
| Exponential Function    | `exp`                                               | `exp(1)`                                                                                         |
| Rounding Functions      | `ceil`, `floor`                                     | `ceil(2.1)`, `floor(2.9)`                                                                        |
| Factorial               | `fac`, `!`                                          | `fac(5)`, `5!`                                                                                   |
| Combinations            | `ncr`                                               | `ncr(5, 3)`                                                                                      |
| Permutations            | `npr`                                               | `npr(5, 2)`                                                                                      |

## Test Coverage

The TinyExpr package includes comprehensive tests to ensure the correctness of the expression evaluation. The tests cover:

| Test Category                  | Description                                                                       | Status |
| ------------------------------ | --------------------------------------------------------------------------------- | ------ |
| Basic Arithmetic               | Tests for addition, subtraction, multiplication, division, and modulo operations. | ✅     |
| Exponentiation                 | Tests for power operations.                                                       | ✅     |
| Parentheses and Precedence     | Tests for parentheses and operator precedence.                                    | ✅     |
| Unary Negation                 | Tests for unary negation.                                                         | ✅     |
| Constants                      | Tests for mathematical constants like `pi` and `e`.                               | ✅     |
| Trigonometric Functions        | Tests for trigonometric functions like `sin`, `cos`, `tan`, etc.                  | ✅     |
| Hyperbolic Functions           | Tests for hyperbolic functions like `sinh`, `cosh`, `tanh`.                       | ✅     |
| Logarithmic Functions          | Tests for logarithmic functions like `log` and `ln`.                              | ✅     |
| Square Root and Absolute Value | Tests for square root and absolute value functions.                               | ✅     |
| Exponential Function           | Tests for the exponential function.                                               | ✅     |
| Rounding Functions             | Tests for rounding functions like `ceil` and `floor`.                             | ✅     |
| Factorial                      | Tests for the factorial function.                                                 | ✅     |
| Combinations and Permutations  | Tests for combinations (nCr) and permutations (nPr).                              | ✅     |
| Variable Handling              | Tests for handling variables in expressions.                                      | ✅     |
| Nested Expressions             | Tests for nested expressions.                                                     | ✅     |
| Complex Expressions            | Tests for complex expressions with multiple types of operators.                   | ✅     |
| Error Handling                 | Tests for error handling in expressions.                                          | ✅     |

## Documentation Coverage

The TinyExpr package is well-documented, with detailed explanations of the available features, usage examples, and API reference. The documentation covers:

| Documentation Section    | Description                                            | Status                                                                     |
| ------------------------ | ------------------------------------------------------ | -------------------------------------------------------------------------- |
| Overview                 | Overview of the TinyExpr package                       | ✅                                                                         |
| Features and Limitations | Features and limitations of the TinyExpr package       | ✅                                                                         |
| Getting Started Guide    | Guide to get started with TinyExpr                     | ✅                                                                         |
| Usage Examples           | Examples of how to use TinyExpr                        | ✅                                                                         |
| Available Operations     | List of available operations in TinyExpr               | ✅                                                                         |
| API Reference            | API reference for the `TinyExpr` class and its methods | [API Reference](https://pub.dev/documentation/tiny_expr/latest/tiny_expr/) |

## Future Plans

Future plans for the TinyExpr package include:

- Adding support for more advanced mathematical functions (e.g., hyperbolic trigonometric functions, special functions).
- Improving performance for complex expressions.
- Adding support for user-defined functions.
- Enhancing error handling and reporting.
- Providing more usage examples and documentation.
- Adding support for additional mathematical constants.
- Adding support for more extension methods.

## Additional information

For more information, visit the [TinyExpr GitHub repository](https://github.com/shivanuj13/tiny_expr).

To contribute to the package, please submit a [pull request](https://github.com/shivanuj13/tiny_expr/pulls) or file an [issue on GitHub](https://github.com/shivanuj13/tiny_expr/issues). We welcome contributions and will respond to issues as quickly as possible.

If you encounter any problems or have any questions, feel free to open an [issue on GitHub](https://github.com/shivanuj13/tiny_expr/issues). We aim to provide timely and helpful responses to all inquiries.
