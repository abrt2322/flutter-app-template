import 'package:enum_to_string/enum_to_string.dart';

enum Flavor { dev, prod }

class EnvironmentVariable {
  const EnvironmentVariable._({required this.baseUrl});

  factory EnvironmentVariable.of() {
    switch (flavor) {
      case Flavor.dev:
        return EnvironmentVariable._dev();
      case Flavor.prod:
      default:
        return EnvironmentVariable._prod();
    }
  }

  factory EnvironmentVariable._dev() {
    return const EnvironmentVariable._(baseUrl: 'http://dev');
  }

  factory EnvironmentVariable._prod() {
    return const EnvironmentVariable._(baseUrl: 'http://prod');
  }

  /// エンドポイント
  final String baseUrl;

  /// 環境 Flavor
  static Flavor get flavor =>
      EnumToString.fromString(
        Flavor.values,
        const String.fromEnvironment('FLAVOR'),
      ) ??
      Flavor.dev;

  /// Device Previewを有効化するかどうか
  static bool get enablePreview => const bool.fromEnvironment('PREVIEW');
}
