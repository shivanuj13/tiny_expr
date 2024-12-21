TinyExpr is a lightweight expression evaluator for Dart, designed to evaluate mathematical expressions from strings. This makes it an ideal choice for applications requiring dynamic calculations.

> This project draws inspiration from the TinyExpr library written in C. The original library can be found [here](https://github.com/codeplea/tinyexpr). We extend our gratitude to the original author for their outstanding work.

## Features

- Evaluate mathematical expressions from strings.
- Support for basic arithmetic operations: addition, subtraction, multiplication, and division.
- Support for parentheses to define operation precedence.
- Lightweight and easy to integrate.

## Getting started

To start using TinyExpr, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  tiny_expr: ^0.1.0
```

Then, run `flutter pub get` to install the package.

## Usage

Here is a simple example of how to use TinyExpr to evaluate an expression:

```dart
import 'package:tiny_expr/tiny_expr.dart';

void main() {
  final expression = '3 + 5 * (2 - 4)';
  final result = TinyExpr().evaluate(expression);
  print('Result: $result'); // Output: Result: -7
}
```

For more examples, check the `/example` folder.

## Additional information

For more information, visit the [TinyExpr GitHub repository](https://github.com/yourusername/tiny_expr).

To contribute to the package, please submit a pull request or file an issue on GitHub. We welcome contributions and will respond to issues as quickly as possible.

If you encounter any problems or have any questions, feel free to open an issue on GitHub. We aim to provide timely and helpful responses to all inquiries.
