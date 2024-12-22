import 'dart:math';
import 'package:tiny_expr/src/token.dart';

part 'helper.dart';

/// {@template tiny_expr}
/// The `TinyExpr` class provides a lightweight expression parser and evaluator.
///
/// This class allows you to parse and evaluate mathematical expressions represented
/// as strings. It supports basic arithmetic operations such as addition, subtraction,
/// multiplication, and division, as well as parentheses for grouping.
///
/// Example usage:
/// ```dart
/// var expr = TinyExpr('3 + 4 * 2 / (1 - 5)');
/// var result = expr.evaluate();
/// print(result); // Output: 1.0
/// ```
///
/// The `TinyExpr` class can be useful in scenarios where you need to evaluate
/// mathematical expressions dynamically at runtime, such as in calculators,
/// scripting engines, or configuration files.
///
/// Features:
/// - Supports basic arithmetic operations: `+`, `-`, `*`, `/`
/// - Supports parentheses for grouping: `(`, `)`
/// - Handles operator precedence and associativity
///
/// Limitations:
/// - Does not support advanced mathematical functions (e.g., trigonometric functions)
/// - Does not support variables or constants
///
/// Example:
/// ```dart
/// var expr = TinyExpr('10 + (2 * 3) - 4 / 2');
/// var result = expr.evaluate();
/// print(result); // Output: 15.0
/// ```
///
/// Note: This class is designed for simplicity and ease of use, and may not be
/// suitable for complex mathematical expressions or performance-critical applications.
/// {@endtemplate}
class TinyExpr {
  /// The input mathematical expression.
  /// for example: `3 + 4 * 2 / (1 - 5)`

  final String expression;

  /// Determines the order of exponentiation.
  /// By default, exponentiation is left-associative (e.g., `2^3^4` is evaluated as `(2^3)^4`).
  /// If `powFromRight` is set to `true`, exponentiation is right-associative (e.g., `2^3^4` is evaluated as `2^(3^4)`).
  final bool powFromRight;

  /// User-defined variables.
  /// for example: `{'x': 5, 'y': 10}`
  /// used to store the value of variables in the expression.
  /// use `addVariables` to add a new variables.
  /// use `updateVariables` to update the value of an existing variable.
  final Map<String, double> variables = {};

  /// User-defined functions.
  /// for example: `{'f': (double x) => x * x}`
  /// used to store the value of functions in the expression.
  final Map<String, Function> functions = {};

  /// User-defined constants.
  /// for example: `{'pi': 3.14159, 'e': 2.71828}`
  final Map<String, double> constants = {};

  /// The list of tokens generated from the input expression.
  /// for example: `[Token.number(3), Token.operator('+'), Token.number(4), ...]`
  /// used to store the tokens generated from the input expression during evaluation.
  ///
  /// The current token being processed is accessed using the `currentToken` getter.
  ///
  final List<Token> tokens = [];

  /// The current index of the token being processed.
  /// for example: `0`
  /// used to keep track of the current token being processed during evaluation.
  ///
  /// The current token is accessed using the `currentToken` getter.
  int _currentIndex = 0;

  /// Creates a new `TinyExpr` instance with the given [expression].
  ///
  /// The optional [powFromRight] parameter specifies whether exponentiation
  /// should be right-associative (i.e., `2^3^4` is evaluated as `2^(3^4)`).
  /// By default, exponentiation is left-associative (i.e., `2^3^4` is evaluated as `(2^3)^4`).
  ///
  /// The `TinyExpr` class supports basic arithmetic operations such as addition, subtraction,
  /// multiplication, and division, as well as parentheses for grouping.
  ///
  ///
  /// {@macro tiny_expr}
  TinyExpr(this.expression, {this.powFromRight = false}) {
    _initializeFunctionsAndConstants();
  }

  // Initialize built-in mathematical functions and constants
  void _initializeFunctionsAndConstants() {
    // Built-in functions
    functions.addAll({
      'sin': (double x) => sin(x),
      'cos': (double x) => cos(x),
      'tan': (double x) => tan(x),
      'cosec': (double x) {
        if (x == 0) throw FormatException("cosec is undefined for x = 0");
        return 1 / sin(x);
      },
      'sec': (double x) {
        if (x == pi / 2 || x == -pi / 2) {
          throw FormatException("sec is undefined for x = ±pi/2");
        }
        return 1 / cos(x);
      },
      'cot': (double x) {
        if (x == 0) throw FormatException("cot is undefined for x = 0");
        return 1 / tan(x);
      },
      'atan2': (double y, double x) => atan2(y, x),
      'log': (double x) {
        if (x <= 0) throw FormatException("log is undefined for x <= 0");
        return log(x) / log(10); // Base-10 logarithm
      },
      'ln': (double x) {
        if (x <= 0) throw FormatException("ln is undefined for x <= 0");
        return log(x); // Natural logarithm
      },
      'sqrt': (double x) {
        if (x < 0) throw FormatException("sqrt is undefined for x < 0");
        return sqrt(x);
      },
      'abs': (double x) => x.abs(),
      'exp': (double x) => exp(x),
      'fac': (double x) => factorial(x), // Factorial
      'ncr': (double n, double r) => combinations(n, r), // Combinations
      'npr': (double n, double r) => permutations(n, r), // Permutations
      'ceil': (double x) => x.ceilToDouble(),
      'floor': (double x) => x.floorToDouble(),
      'sinh': (double x) => sinh(x),
      'cosh': (double x) => cosh(x),
      'tanh': (double x) => tanh(x),
    });

    // Built-in constants
    constants.addAll({
      'pi': pi,
      'e': e,
    });
  }

  /// Add a new variable with the given [name] and [value].
  ///
  /// This method allows you to define new variables in the expression.
  /// The variable can then be used in the expression, and its value will be substituted during evaluation.
  ///
  /// For example:
  /// ```dart
  ///   var expr = TinyExpr('x + y * z');
  ///   expr.addVariables({'x': 3.0, 'y': 2.0, 'z': 5.0});
  ///   var result = expr.evaluate(); // Output: 13.0
  /// ```
  ///
  void addVariables(Map<String, double> variables) {
    this.variables.addAll(variables);
  }

  /// Update the value of an existing variable with the given [name] and [value].
  ///
  /// This method allows you to update the value of an existing variable in the expression.
  /// The variable can then be used in the expression, and its value will be substituted during evaluation.
  ///
  /// For example:
  /// ```dart
  ///   var expr = TinyExpr('x + y * z');
  ///   expr.updateVariables({'x': 3.0, 'y': 2.0, 'z': 5.0});
  ///   var result = expr.evaluate(); // Output: 13.0
  /// ```
  ///
  void updateVariables(Map<String, double> variables) {
    this.variables.addAll(variables);
  }

  // Tokenize the input expression
  void _tokenize() {
    final buffer = StringBuffer();
    for (int i = 0; i < expression.length; i++) {
      final char = expression[i];

      // Handle numbers
      if (RegExp(r'[0-9.]').hasMatch(char)) {
        buffer.write(char);
        while (i + 1 < expression.length &&
            RegExp(r'[0-9.]').hasMatch(expression[i + 1])) {
          i++;
          buffer.write(expression[i]);
        }
        tokens.add(Token.number(double.parse(buffer.toString())));
        buffer.clear();
      }
      // Handle variables, functions, and constants
      else if (RegExp(r'[a-zA-Z_]').hasMatch(char)) {
        buffer.write(char);
        while (i + 1 < expression.length &&
            RegExp(r'[a-zA-Z0-9_]').hasMatch(expression[i + 1])) {
          i++;
          buffer.write(expression[i]);
        }
        final name = buffer.toString();
        if (functions.containsKey(name)) {
          tokens.add(Token.function(name));
        } else if (constants.containsKey(name)) {
          tokens.add(Token.constant(name));
        } else if (variables.containsKey(name)) {
          tokens.add(Token.variable(name));
        } else {
          tokens.add(Token.error());
          throw FormatException(
              "Unknown variable, function, or constant: $name");
        }
        buffer.clear();
      }
      // Handle operators and special characters
      else if ("+-*/^%,()!".contains(char)) {
        // Added '!' for factorial
        if (char == ',') {
          tokens.add(Token.separator());
        } else {
          tokens.add(Token.operator(char));
        }
      }
      // Ignore whitespace
      else if (char.trim().isEmpty) {
        continue;
      }
      // Handle unexpected characters
      else {
        tokens.add(Token.error());
        throw FormatException("Unexpected character: $char");
      }
    }
    tokens.add(Token.end());
  }

  /// The current token being processed during evaluation.
  ///
  ///
  /// for example: `Token.number(3)`
  /// used to access the current token being processed during evaluation.
  /// The `nextToken` method is used to move to the next token.
  /// The `evaluate` method is used to evaluate the expression.
  Token get currentToken => tokens[_currentIndex];

  /// Move to the next token in the list of tokens.
  ///
  ///
  /// used to move to the next token in the list of tokens during evaluation.
  /// The `currentToken` getter is used to access the current token.
  void _nextToken() {
    _currentIndex++;
  }

  /// Evaluate the input expression and return the result.
  /// for example: `3 + 4 * 2 / (1 - 5)`
  /// used to evaluate the input expression and return the result.
  /// The `addVariables` method is used to add new variables.
  /// The `updateVariables` method is used to update the value of an existing variable.
  /// The `variables` map is used to store the value of variables in the expression.
  /// The `functions` map is used to store the value of functions in the expression.
  /// The `constants` map is used to store the value of constants in the expression.
  /// The `tokens` list is used to store the tokens generated from the input expression.
  /// The `currentToken` getter is used to access the current token being processed.
  ///
  /// Returns the result of the evaluation.
  /// Throws a [FormatException] if an error occurs during evaluation.
  ///
  /// Example:
  ///
  /// ```dart
  /// var expr = TinyExpr('3 + 4 * 2 / (1 - 5)');
  /// var result = expr.evaluate();
  /// print(result); // Output: 1.0
  /// ```
  ///
  double evaluate() {
    _tokenize(); // Tokenize the input expression
    _currentIndex = 0; // Reset the token index
    final result = _optimize(
        _parseExpression()); // Parse and optimize the top-level expression
    if (currentToken.type != TokenType.end) {
      throw FormatException("Unexpected token at the end of the expression.");
    }
    return result;
  }

  // Optimize constant subexpressions
  double _optimize(double value) {
    return value; // Currently just returns the value as-is.
  }

  // Parse an expression
  double _parseExpression() {
    double result = _parseTerm();
    while (currentToken.type == TokenType.operator &&
        (currentToken.operator == '+' || currentToken.operator == '-')) {
      final op = currentToken.operator;
      _nextToken();
      final right = _parseTerm();
      result = op == '+' ? result + right : result - right;
    }
    return result;
  }

  // Parse a term
  double _parseTerm() {
    double result = _parseFactor();
    while (currentToken.type == TokenType.operator &&
        (currentToken.operator == '*' ||
            currentToken.operator == '/' ||
            currentToken.operator == '%')) {
      final op = currentToken.operator;
      _nextToken();
      final right = _parseFactor();
      if (op == '*') result *= right;
      if (op == '/') result /= right;
      if (op == '%') result %= right;
    }
    return result;
  }

  // Parse a factor
  double _parseFactor() {
    double result = _parsePower();
    while (currentToken.type == TokenType.operator &&
        (currentToken.operator == '^' || currentToken.operator == '!')) {
      // Handle factorial
      final op = currentToken.operator;
      _nextToken();
      if (op == '^') {
        final right = _parsePower();
        result = pow(result, right) as double;
      } else if (op == '!') {
        result = factorial(result);
      }
    }
    return result;
  }

  // Parse a power or base case
  double _parsePower() {
    if (currentToken.type == TokenType.operator &&
        currentToken.operator == '-') {
      _nextToken();
      return -_parsePower();
    } else if (currentToken.type == TokenType.number) {
      final value = currentToken.value!;
      _nextToken();
      return value;
    } else if (currentToken.type == TokenType.variable) {
      final name = currentToken.name!;
      if (!variables.containsKey(name)) {
        throw FormatException("Variable '$name' is not defined.");
      }
      final value = variables[name]!;
      _nextToken();
      return value;
    } else if (currentToken.type == TokenType.constant) {
      final name = currentToken.name!;
      final value = constants[name]!;
      _nextToken();
      return value;
    } else if (currentToken.type == TokenType.function) {
      final name = currentToken.name!;
      _nextToken();
      if (currentToken.type == TokenType.operator &&
          currentToken.operator == '(') {
        _nextToken();
        final args = <double>[];
        args.add(_parseExpression());
        while (currentToken.type == TokenType.separator) {
          _nextToken();
          args.add(_parseExpression());
        }
        if (currentToken.type != TokenType.operator ||
            currentToken.operator != ')') {
          throw FormatException("Mismatched parentheses.");
        }
        _nextToken();
        final func = functions[name]!;
        return Function.apply(func, args);
      } else {
        throw FormatException("Expected '(' after function name: $name");
      }
    } else if (currentToken.type == TokenType.operator &&
        currentToken.operator == '(') {
      _nextToken();
      final value = _parseExpression();
      if (currentToken.type != TokenType.operator ||
          currentToken.operator != ')') {
        throw FormatException("Mismatched parentheses.");
      }
      _nextToken();
      return value;
    } else {
      throw FormatException("Unexpected token: $currentToken");
    }
  }
}
