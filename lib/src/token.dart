/// {@template tiny_expr_token_type}
/// Enums to represent different types of tokens used in the expression parser.
///
/// The `TokenType` enum defines the following types of tokens:
///
/// - `number`: Represents a numeric value.
/// - `variable`: Represents a variable name.
/// - `operator`: Represents an operator (e.g., +, -, *, /).
/// - `function`: Represents a function name.
/// - `constant`: Represents a constant value.
/// - `separator`: Represents a separator (e.g., comma).
/// - `end`: Represents the end of the expression.
/// - `error`: Represents an error in tokenization.
/// {@endtemplate}
enum TokenType {
  /// A numeric value, such as an integer or a floating-point number.
  number,

  /// A variable, which can hold different values.
  variable,

  /// An operator, such as +, -, *, /, etc.
  operator,

  /// A function, which can perform specific operations.
  function,

  /// A constant value, which does not change.
  constant,

  /// A separator, such as a comma, used to separate function arguments.
  separator,

  /// Indicates the end of the expression.
  end,

  /// Represents an error in the expression.
  error
}

/// {@template tiny_expr_token}
/// A class representing a token in the expression parser.
/// A token can be a number, variable, operator, function, constant, separator,
/// end of expression, or an error.
/// - `type`: The type of the token (e.g., number, variable, operator etc).
/// - `value`: The value of the token (for number tokens).
/// - `name`: The name of the token (for variable, function, or constant tokens).
/// - `operator`: The operator of the token (for operator tokens).
/// {@endtemplate}
class Token {
  /// The type of the token
  TokenType type;

  /// The value of the token, used for number tokens
  double? value;

  /// The name of the token, used for variable, function, or constant names
  String? name;

  /// The operator of the token, used for operator tokens
  String? operator;

  /// Constructor for number tokens
  /// - `value`: The numeric value of the token.
  /// - `type`: The type of the token (number).
  ///
  ///
  /// {@macro tiny_expr_token}
  Token.number(this.value) : type = TokenType.number;

  /// Constructor for variable tokens
  /// - `name`: The name of the variable.
  /// - `type`: The type of the token (variable).
  ///
  ///
  /// {@macro tiny_expr_token}
  Token.variable(this.name) : type = TokenType.variable;

  /// Constructor for operator tokens
  /// - `operator`: The operator symbol.
  /// - `type`: The type of the token (operator).
  ///
  ///
  /// {@macro tiny_expr_token}
  Token.operator(this.operator) : type = TokenType.operator;

  /// Constructor for function tokens
  /// - `name`: The name of the function.
  /// - `type`: The type of the token (function).
  ///
  ///
  /// {@macro tiny_expr_token}
  Token.function(this.name) : type = TokenType.function;

  /// Constructor for constant tokens
  /// - `name`: The name of the constant.
  /// - `type`: The type of the token (constant).
  ///
  ///
  /// {@macro tiny_expr_token}
  Token.constant(this.name) : type = TokenType.constant;

  /// Constructor for separator tokens
  /// - `type`: The type of the token (separator).
  ///
  ///
  /// {@macro tiny_expr_token}
  Token.separator() : type = TokenType.separator;

  /// Constructor for end tokens
  /// - `type`: The type of the token (end).
  ///
  ///
  /// {@macro tiny_expr_token}
  Token.end() : type = TokenType.end;

  /// Constructor for error tokens
  /// - `type`: The type of the token (error).
  ///
  ///
  /// {@macro tiny_expr_token}
  Token.error() : type = TokenType.error;

  /// Returns a string representation of the token.
  /// This method is used for debugging and logging purposes.
  ///
  @override
  String toString() {
    switch (type) {
      case TokenType.number:
        return 'Token(number, value: $value)';
      case TokenType.variable:
        return 'Token(variable, name: $name)';
      case TokenType.operator:
        return 'Token(operator, operator: $operator)';
      case TokenType.function:
        return 'Token(function, name: $name)';
      case TokenType.constant:
        return 'Token(constant, name: $name)';
      case TokenType.separator:
        return 'Token(separator)';
      case TokenType.end:
        return 'Token(end)';
      case TokenType.error:
        return 'Token(error)';
    }
  }
}
